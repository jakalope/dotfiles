# client.py - watchman client
#
# Copyright 2013 Facebook, Inc.
#
# This software may be used and distributed according to the terms of the
# GNU General Public License version 2 or any later version.

import os, errno, stat, getpass, socket, subprocess, time
from mercurial import util
import bser

_minversion = '2.7'
_socktimeout = 1.0

class Unavailable(Exception):
    def __init__(self, msg, warn=True, invalidate=False):
        self.msg = msg
        self.warn = warn
        self.invalidate = invalidate
    def __str__(self):
        if self.warn:
            return 'warning: watchman unavailable: %s' % self.msg
        else:
            return 'watchman unavailable: %s' % self.msg

class WatchmanNoRoot(Exception):
    def __init__(self, root):
        self.root = root
    def __str__(self):
        return "unable to resolve root %s" % self.root

class client(object):
    socket = None
    user = None

    def __init__(self, repo):
        err = None
        if not self._user:
            err = "couldn't get user"
            warn = True
        if self._user in repo.ui.configlist('watchman', 'blacklistusers'):
            err = 'user %s in blacklist' % self._user
            warn = False

        # todo: don't watch nfs
        if err:
            raise Unavailable(err, warn)

        self._root = repo.root
        self._ui = repo.ui
        self._available = True

    def getcurrentclock(self):
        result = self.command('clock')
        return result['clock']

    def available(self):
        return self._available

    @util.propertycache
    def _user(self):
        try:
            return getpass.getuser()
        except:
            # couldn't figure out our user
            return None

    @util.propertycache
    def _sock(self):
        # query watchman over the command line for the socket name
        cmd = ['watchman', '--output-encoding=bser', 'get-sockname']
        try:
            p = subprocess.Popen(cmd, stdout=subprocess.PIPE,
                                 stderr=subprocess.PIPE, close_fds=util.closefds)
        except OSError:
            raise Unavailable('"watchman" executable not in PATH')

        stdout, stderr = p.communicate()
        exitcode = p.poll()

        if exitcode:
            raise Unavailable('watchman exited with code %d' % exitcode)

        result = bser.loads(stdout)
        if 'error' in result:
            raise Unavailable('watchman socket discovery error: "%s"' %
                              result['error'])

        sockname = result['sockname']
        sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
        try:
            sock.settimeout(_socktimeout)
            sock.connect(sockname)
        except socket.error:
            raise Unavailable("can't connect to socket %s" % sockname)

        return sock

    def _command(self, *args):
        cmd = bser.dumps((args[0], self._root) + args[1:])
        result = None

        sock = self._sock
        if sock is None:
            return None

        try:
            sock.sendall(cmd)
            buf = [sock.recv(8192)]
            if not buf[0]:
                raise Unavailable('watchman response was empty')

            elen = bser.pdu_len(buf[0])
            rlen = len(buf[0])
            while elen > rlen:
                buf.append(sock.recv(elen - rlen))
                rlen += len(buf[-1])
            response = ''.join(buf)
        except socket.timeout:
            # drop the state
            raise Unavailable('timed out waiting for response', False, True)

        # verify the response actually is good
        try:
            result = bser.loads(response)
        except ValueError, ex:
            raise Unavailable("watchman result couldn't be decoded, %s" % ex)

        if 'version' not in result or result['version'] < _minversion:
            raise Unavailable("watchman version too old: got %s, want %s" % (
                result.get('version'), _minversion))

        if 'error' in result:
            if result['error'].startswith('unable to resolve root'):
                raise WatchmanNoRoot(self._root)
            raise Unavailable('watchman command error: "%s"' % result['error'])

        return result

    def command(self, *args):
        try:
            return self._command(*args)
        except WatchmanNoRoot:
            self._command('watch')
            return self._command(*args)
        except Unavailable:
            self._available = False
            raise
