# __init__.py - hgwatchman initialization and overrides
#
# Copyright 2013 Facebook, Inc.
#
# This software may be used and distributed according to the terms of the
# GNU General Public License version 2 or any later version.

'''faster status operations with the Watchman file monitor

For more information, see https://bitbucket.org/facebook/hgwatchman.
'''

import client, state
from mercurial import dirstate, context, util, scmutil, osutil, extensions
from mercurial import match as matchmod
from mercurial.i18n import _
import os, stat, collections, sys

testedwith = '3.1'

# pathauditor has been moved in 2.9
try:
    from mercurial import pathutil
    pathutil.pathauditor
except ImportError:
    pathutil = scmutil

watchmanstat = collections.namedtuple('watchmanstat',
                                      ['st_mode', 'st_size', 'st_mtime'])

_blacklist = ['largefiles', 'inotify', 'eol']

def _handleunavailable(ui, state, ex):
    if ex.warn:
        ui.warn(str(ex) + '\n')
    if ex.invalidate:
        state.invalidate()
    ui.log('watchman', 'watchman unavailable: %s\n', ex.msg)

def _hashignore(ignore):
    sha1 = util.sha1()
    if util.safehasattr(ignore, 'includepat'):
        sha1.update(ignore.includepat)
    sha1.update('\0\0')
    if util.safehasattr(ignore, 'excludepat'):
        sha1.update(ignore.excludepat)
    sha1.update('\0\0')
    if util.safehasattr(ignore, 'patternspat'):
        sha1.update(ignore.patternspat)
    sha1.update('\0\0')
    if util.safehasattr(ignore, '_files'):
        for f in ignore._files:
            sha1.update(f)
    sha1.update('\0')
    return sha1.hexdigest()

def overridewalk(orig, self, match, subrepos, unknown, ignored, full=True):
    '''Whenever full is False, ignored is False, and the watchman client is
    available, use watchman combined with saved state to possibly return only a
    subset of files.'''
    def bail():
        return orig(match, subrepos, unknown, ignored, full=True)

    if full or ignored or not self._watchmanclient.available():
        return bail()
    clock, ignorehash, notefiles = self._watchmanstate.get()
    if not clock:
        return bail()

    def fwarn(f, msg):
        self._ui.warn('%s: %s\n' % (self.pathto(f), msg))
        return False

    def badtype(mode):
        kind = _('unknown')
        if stat.S_ISCHR(mode):
            kind = _('character device')
        elif stat.S_ISBLK(mode):
            kind = _('block device')
        elif stat.S_ISFIFO(mode):
            kind = _('fifo')
        elif stat.S_ISSOCK(mode):
            kind = _('socket')
        elif stat.S_ISDIR(mode):
            kind = _('directory')
        return _('unsupported file type (type is %s)') % kind

    ignore = self._ignore
    dirignore = self._dirignore
    if unknown:
        if _hashignore(ignore) != ignorehash:
            # ignore list changed -- can't rely on watchman state any more
            self._ui.log('watchman', 'watchman: ignore list hash changed, '
                         'nuking state\n')
            self._watchmanstate.invalidate()
            return bail()
    else:
        # always ignore
        ignore = util.always
        dirignore = util.always

    matchfn = match.matchfn
    matchalways = match.always()
    dmap = self._map
    copymap = self._copymap
    getkind = stat.S_IFMT
    dirkind = stat.S_IFDIR
    regkind = stat.S_IFREG
    lnkkind = stat.S_IFLNK
    join = self._join

    exact = skipstep3 = False
    if matchfn == match.exact: # match.exact
        exact = True
        dirignore = util.always # skip step 2
    elif match.files() and not match.anypats(): # match.match, no patterns
        skipstep3 = True

    if not exact and self._checkcase:
        normalize = self._normalize
        skipstep3 = False
    else:
        normalize = None

    # step 1: find all explicit files
    results, work, dirsnotfound = self._walkexplicit(match, subrepos)

    skipstep3 = skipstep3 and not (work or dirsnotfound)
    work = [d for d in work if not dirignore(d)]
    if not work and (exact or skipstep3):
        for s in subrepos:
            del results[s]
        del results['.hg']
        return results

    # step 2: query watchman
    try:
        result = self._watchmanclient.command('query', {
            'fields': ['exists', 'mode', 'name', 'mtime', 'size'],
            'since': clock,
            'sync_timeout': 2000,
            'empty_on_fresh_instance': True,
        })
    except client.Unavailable, ex:
        _handleunavailable(self._ui, self._watchmanstate, ex)
        return bail()
    else:
        if result['is_fresh_instance']:
            return bail()

    # for file paths which require normalization and we encounter a case
    # collision, we stat the file and store it in here. Note that everything
    # returned from _walkexplicit is stat'd already.
    if normalize:
        statcache = results.copy()

    for entry in result['files']:
        fname = entry['name']
        if normalize:
            fname = normalize(fname, False, True)
        fmode = entry['mode']
        fexists = entry['exists']
        kind = getkind(fmode)
        if fname == '.hg' or fname.startswith('.hg/'):
            continue

        if normalize and fname in results:
            # case collision -- stat the file as currently exists and
            # regenerate the result
            if fname not in statcache:
                try:
                    st = os.lstat(fname)
                    statcache[fname] = st
                    # overwrite these as well
                    fexists = True
                    fmode = st.st_mode
                    kind = getkind(fmode)
                except OSError:
                    statcache[fname] = None
                    fexists = False
                del results[fname]

        if fname not in results:
            if not fexists:
                if fname in dmap and (matchalways or matchfn(fname)):
                    results[fname] = None
            elif kind == dirkind:
                if fname in dmap and (matchalways or matchfn(fname)):
                    results[fname] = None
            elif kind == regkind or kind == lnkkind:
                if normalize and fname in statcache:
                    st = statcache[fname]
                else:
                    st = watchmanstat(fmode, entry['size'], entry['mtime'])
                if fname in dmap:
                    if matchalways or matchfn(fname):
                        results[fname] = st
                elif (matchalways or matchfn(fname)) and not ignore(fname):
                    results[fname] = st
            elif fname in dmap and (matchalways or matchfn(nf)):
                results[fname] = None

    # step 3: query notable files we don't already know about
    # XXX try not to iterate over the entire dmap
    if normalize:
        notefiles = set((normalize(f, False, True) for f in notefiles))
    visit = set((f for f in notefiles if (f not in results and matchfn(f)
                                          and (f in dmap or not ignore(f)))))
    if matchalways:
        visit.update((f for f, st in dmap.iteritems()
                      if (f not in results and
                          (st[2] < 0 or st[0] != 'n'))))
        visit.update((f for f in copymap if f not in results))
    else:
        visit.update((f for f, st in dmap.iteritems()
                      if (f not in results and
                          (st[2] < 0 or st[0] != 'n')
                          and matchfn(f))))
        visit.update((f for f in copymap if f not in results and matchfn(f)))

    audit = pathutil.pathauditor(self._root).check
    auditpass = [f for f in visit if audit(f)]
    auditpass.sort()
    auditfail = visit.difference(auditpass)
    for f in auditfail:
        results[f] = None

    nf = iter(auditpass).next
    for st in util.statfiles([join(f) for f in auditpass]):
        f = nf()
        if st or f in dmap:
            results[f] = st

    for s in subrepos:
        del results[s]
    del results['.hg']
    return results

def overridestatus(orig, self, node1='.', node2=None, match=None, ignored=False,
                   clean=False, unknown=False, listsubrepos=False):
    listignored = ignored
    listclean = clean
    listunknown = unknown

    def _cmpsets(l1, l2):
        try:
            if 'HGWATCHMAN_LOG_FILE' in os.environ:
                fn = os.environ['HGWATCHMAN_LOG_FILE']
                f = open(fn, 'wb')
            else:
                fn = 'watchmanfail.log'
                f = self.opener(fn, 'wb')
        except (IOError, OSError), inst:
            self.ui.warn('warning: unable to write to %s\n' % fn)
            return

        try:
            for i, (s1, s2) in enumerate(zip(l1, l2)):
                if set(s1) != set(s2):
                    f.write('sets at position %d are unequal\n' % i)
                    f.write('watchman returned: %s\n' % s1)
                    f.write('stat returned: %s\n' % s2)
        finally:
            f.close()

    if isinstance(node1, context.changectx):
        ctx1 = node1
    else:
        ctx1 = self[node1]
    if isinstance(node2, context.changectx):
        ctx2 = node2
    else:
        ctx2 = self[node2]

    working = ctx2.rev() is None
    parentworking = working and ctx1 == self['.']
    match = match or matchmod.always(self.root, self.getcwd())

    # Maybe we can use this opportunity to update watchman's state.
    updatestate = parentworking and match.always()
    if updatestate:
        try:
            startclock = self._watchmanclient.getcurrentclock()
        except client.Unavailable, ex:
            _handleunavailable(self.ui, self._watchmanstate, ex)
            # boo, watchman failed. bail
            return orig(node1, node2, match, listignored, listclean,
                        listunknown, listsubrepos)

        # We need info about unknown files. This may make things slower the
        # first time, but whatever.
        stateunknown = True
    else:
        stateunknown = listunknown

    r = orig(node1, node2, match, listignored, listclean, stateunknown,
             listsubrepos)
    modified, added, removed, deleted, unknown, ignored, clean = r

    if updatestate:
        notefiles = modified + added + removed + deleted + unknown + ignored
        self._watchmanstate.set(startclock, _hashignore(self.dirstate._ignore),
                                notefiles)

    if not listignored:
        ignored = []
    if not listunknown:
        unknown = []

    # don't do paranoid checks if we're not going to query watchman anyway
    full = listclean or match.traversedir is not None
    if self._watchmanstate.mode == 'paranoid' and not full:
        # run status again and fall back to the old walk this time
        self.dirstate._watchmandisable = True

        # shut the UI up
        quiet = self.ui.quiet
        self.ui.quiet = True
        fout, ferr = self.ui.fout, self.ui.ferr
        self.ui.fout = self.ui.ferr = open(os.devnull, 'wb')

        try:
            rv2 = orig(node1, node2, match, listignored, listclean, listunknown,
                       listsubrepos)
        finally:
            self.dirstate._watchmandisable = False
            self.ui.quiet = quiet
            self.ui.fout, self.ui.ferr = fout, ferr

        # clean isn't tested since it's set to True above
        _cmpsets([modified, added, removed, deleted, unknown, ignored, clean],
                 rv2)
        modified, added, removed, deleted, unknown, ignored, clean = rv2

    return modified, added, removed, deleted, unknown, ignored, clean

def reposetup(ui, repo):
    # We don't work with largefiles or inotify
    exts = extensions.enabled()
    for ext in _blacklist:
        if ext in exts:
            return

    if util.safehasattr(repo, 'dirstate'):
        # We don't work with subrepos either. Note that we can get passed in
        # e.g. a statichttprepo, which throws on trying to access the substate.
        # XXX This sucks.
        try:
            # if repo[None].substate can cause a dirstate parse, which is too
            # slow. Instead, look for a file called hgsubstate,
            if repo.wvfs.exists('.hgsubstate') or repo.wvfs.exists('.hgsub'):
                return
        except:
            return

        watchmanstate = state.state(repo)
        try:
            watchmanclient = client.client(repo)
        except client.Unavailable, ex:
            _handleunavailable(ui, watchmanstate, ex)
            return

        repo._watchmanstate = repo.dirstate._watchmanstate = watchmanstate
        repo._watchmanclient = repo.dirstate._watchmanclient = watchmanclient
        # _watchmandisable is used in paranoid mode
        repo.dirstate._watchmandisable = False

        if watchmanstate.mode == 'off':
            return

        class watchmandirstate(repo.dirstate.__class__):
            def walk(self, *args, **kwargs):
                orig = super(watchmandirstate, self).walk
                if self._watchmandisable:
                    return orig(*args, **kwargs)
                return overridewalk(orig, self, *args, **kwargs)

            def rebuild(self, *args, **kwargs):
                self._watchmanstate.invalidate()
                return super(watchmandirstate, self).rebuild(*args, **kwargs)

            def invalidate(self, *args, **kwargs):
                self._watchmanstate.invalidate()
                return super(watchmandirstate, self).invalidate(*args, **kwargs)

        repo.dirstate.__class__ = watchmandirstate

        class watchmanrepo(repo.__class__):
            def status(self, *args, **kwargs):
                orig = super(watchmanrepo, self).status
                return overridestatus(orig, self, *args, **kwargs)

        repo.__class__ = watchmanrepo
