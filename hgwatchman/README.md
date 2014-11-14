hgwatchman
==========

Integrates the file-watching program watchman with Mercurial to produce faster
status results.

On a particular Linux system, for a real-world repository with over 200,000
files hosted on ext4, vanilla `hg status` takes over 3 seconds. On the
same system, with hgwatchman it takes under 0.6 seconds.

Platforms Supported
===================

**Linux:** *Stable*. Watchman and hgwatchman are both known to work reliably,
  even under severe loads.

**Mac OS X:** *Stable*. The Mercurial test suite passes with hgwatchman turned
  on, on case-insensitive HFS+. There has been a reasonable amount of user
  testing under normal loads.

**Solaris, BSD:** *Alpha*. watchman and hgwatchman are believed to work, but
  very little testing has been done.

**Windows:** *Unsupported*.

Installing
==========

First, install [watchman](https://github.com/facebook/watchman) and make sure it
is in your PATH.

Then, run

    :::sh
    hg clone https://bitbucket.org/facebook/hgwatchman
    cd hgwatchman
    make local

In your `hgrc`, add the following lines:

    :::ini
    [extensions]
    hgwatchman = path/to/this/directory/hgwatchman

Configuring
===========

hgwatchman requires no configuration -- it will tell watchman about your
repository as necessary. There does exist one configuration option, though:

    :::ini
    [watchman]
    mode = {off, on, paranoid}

When `mode = off`, hgwatchman will disable itself. When `mode = on`, hgwatchman
will be enabled as usual. When `mode = paranoid`, hgwatchman will query both
watchman and the filesystem, and ensure that the results are consistent.

Known Issues
============

* hgwatchman will disable itself if any of the following extensions are enabled:
  largefiles, inotify, eol; or if the repository has subrepos.
* hgwatchman will produce incorrect results if nested repos that are not
  subrepos exist. *Workaround*: add nested repo paths to your `.hgignore`.

The issues related to nested repos and subrepos are probably not fundamental
ones. Patches to fix them are welcome.

Testing
=======

hgwatchman doesn't have a test suite of its own. Instead, you can run most of
Mercurial's test suite with hgwatchman enabled. First, clone Mercurial:

    :::sh
    hg clone http://selenic.com/repo/hg
    cd hg
    make local

(Recommended) Run the test suite without hgwatchman and make sure it passes.

    :::sh
    cd tests
    ./run-tests.py -j8

`-j` is the number of tests simultaneously run. Pick an appropriate value for
your machine.

Now run the tests with hgwatchman.

    :::sh
    cd path/to/this/directory/tests
    ./run-tests.py --hg=path/to/hg -j 8

With hgwatchman, setting too high a value for `-j` might lead to [system limits
being hit](https://github.com/facebook/watchman#system-specific-preparation). If
you're seeing strange failures, try lowering the `-j` value or raising the
system limits.

Any additional options and arguments get passed through to Mercurial's
`run-tests.py` -- see its help for more.

Note that you need to use `-j 8` instead of `-j8`; this is an `optparse`
limitation.

Contributing
============

Patches are welcome as pull requests, though they will be collapsed and rebased
to maintain a linear history. We may also set up a Phabricator project on
https://reviews.facebook.net/ soon.

We (Facebook) have to ask for a "Contributor License Agreement" from someone who
sends in a patch or code that we want to include in the codebase. This is a
legal requirement; a similar situation applies to Apache and other ASF projects.

If we ask you to fill out a CLA we'll direct you to our
[online CLA page](https://developers.facebook.com/opensource/cla) where you can
complete it easily. We use the same form as the Apache CLA so that friction is
minimal.

License
=======

hgwatchman is made available under the terms of the GNU General Public License
version 2, or any later version. See the COPYING file that accompanies this
distribution for the full text of the license.
