# state.py - hgwatchman persistent state
#
# Copyright 2013 Facebook, Inc.
#
# This software may be used and distributed according to the terms of the
# GNU General Public License version 2 or any later version.

import os, errno, struct, socket

_version = 4
_versionformat = ">I"

class state(object):
    def __init__(self, repo):
        self._opener = repo.opener
        self._ui = repo.ui
        self._rootdir = os.path.join(repo.root, '')

        self.mode = self._ui.config('watchman', 'mode', default='on')

    def get(self):
        try:
            file = self._opener('watchman.state', 'rb')
        except IOError, inst:
            if inst.errno != errno.ENOENT:
                raise
            return None, None, None

        versionbytes = file.read(4)
        if len(versionbytes) < 4:
            self._ui.log('watchman', ('watchman: state file only has %d bytes, '
                                      'nuking state\n' % len(versionbytes)))
            self.invalidate()
            return None, None, None
        try:
            diskversion = struct.unpack(_versionformat, versionbytes)[0]
            if diskversion != _version:
                # different version, nuke state and start over
                self._ui.log('watchman', 'watchman: version switch from %d to '
                             '%d, nuking state\n' % (diskversion, _version))
                self.invalidate()
                return None, None, None

            state = file.read().split('\0')
            # state = hostname\0clock\0ignorehash\0 + list of files, each
            # followed by a \0
            diskhostname = state[0]
            hostname = socket.gethostname()
            if diskhostname != hostname:
                # file got moved to a different host
                self._ui.log('watchman', 'watchman: stored hostname "%s" '
                             'different from current "%s", nuking state\n' %
                             (diskhostname, hostname))
                self.invalidate()
                return None, None, None

            clock = state[1]
            ignorehash = state[2]
            # discard the value after the last \0
            notefiles = state[3:-1]

        finally:
            file.close()

        return clock, ignorehash, notefiles

    def set(self, clock, ignorehash, notefiles):
        try:
            file = self._opener('watchman.state', 'wb')
        except (IOError, OSError), inst:
            self._ui.warn("warning: unable to write out watchman state\n")
            return

        try:
            file.write(struct.pack(_versionformat, _version))
            file.write(socket.gethostname() + '\0')
            file.write(clock + '\0')
            file.write(ignorehash + '\0')
            if notefiles:
                file.write('\0'.join(notefiles))
                file.write('\0')
        finally:
            file.close()

    def invalidate(self):
        try:
            os.unlink(self._rootdir + '.hg/watchman.state')
        except OSError, inst:
            if inst.errno != errno.ENOENT:
                raise
