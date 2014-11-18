---
id: cli-options
title: Command Line
layout: docs
category: Invocation
permalink: docs/cli-options.html
---

The `watchman` executable contains both the client and the server components
of the watchman service.

By default, when `watchman` is run, it will attempt to communicate with your
existing server instance (each user has their own persistent process), and will
attempt to start it if it doesn't exist.

There are some options that affect how `watchman` will locate the server, some
options that affect only the client and some others that affect only the
server.  Since all of the options are understood by the same executable we've
broken those out into sections of their own to make it clearer when they apply.

## Quick note on default locations

Watchman will prefer to resolve your user name from the `$USER` environmental
variable, or `$LOGNAME` if `$USER` was not set.  If neither are set watchman
will look it up from the system using `getpwuid(getuid())`.  When we refer to
`<USER>` in this documentation we mean the result of this resolution.

In some cases Watchman will need to create files in a temporary location.
Watchman will resolve this temporary location by looking at the `$TMPDIR`
environmental variable, or `$TMP` if `$TMPDIR` was not set.  If neither are set
watchman will use `/tmp`.  When we refer to `<TMPDIR>` in this documentation we
mean the result of this resolution.

## Locating the service

```
 -U, --sockname=PATH   Specify alternate sockname
```

If you configured watchman using `--enable-statedir=<STATEDIR>` the
default location for sockname will be `<STATEDIR>/<USER>`, otherwise it will be
`<TMPDIR>/.watchman.<USER>`.

If you are building a client to access the service programmatically, we
recommend that you invoke [watchman get-sockname](
/watchman/docs/cmd/get-sockname.html) to discover the path that the client and
server would use.  This has the side effect of spawning the service for you if
it isn't already running.

## Client Options

The `watchman` executable will attempt to start the service if there is no
response on the socket specified above.  In some cases it is desirable to avoid
starting the service if it isn't running:

```
 --no-spawn            Don't spawn service if it is not already running.
                       Will try running the command in client mode if
                       possible.
 --no-local            When no-spawn is enabled, don't use client mode
```

Client mode implements the [watchman find command](
/watchman/docs/cmd/find.html) as an immediate search.

These options control how the client talks to the server:

```
 -p, --persistent           Persist and wait for further responses
     --server-encoding=ARG  CLI<->server encoding. json or bser.
```

Persistent connections have relatively limited use with the CLI, but can be
useful to connect ad-hoc to the service to receive logging information (See
[log-level](/watchman/docs/cmd/log-level.html)).

The server encoding option controls how requests and responses are formatted
when talking to the server.  You generally shouldn't need to worry about this.

### Input and Output

Most simple invocations of the CLI will pass a list of arguments:

```bash
$ watchman watch /path/to/dir
```

This is turned into a request like this:

```json
["watch", "/path/to/dir"]
```

and sent to the service using the [Socket Interface](
/watchman/docs/socket-interface.html).

The response is received and then sent to the `stdout` stream formatted based on
the selected output-encoding:

```
     --output-encoding=ARG  CLI output encoding. json (default) or bser
     --no-pretty            Don't pretty print JSON output (more efficient
                            when being processed by another program)
```

Each command has its own response output but watchman will always include a
field named `error` if something about the request was not successful.  In case
of some protocol level errors (eg: connection was terminated) instead of
printing a response on `stdout`, an unstructured error message will be printed
to `stderr` and the process will exit with a non-zero exit status.

Instead of passing the request as command line parameters, you can send a JSON
representation on the `stdin` stream.  These invocations are all equivalent:

```bash
$ watchman watch /path/to/dir
```

```bash
$ watchman -j <<-EOT
["watch", "/path/to/dir"]
EOT
```

```bash
$ echo '["watch", "/path/to/dir"]' | watchman -j
```

```bash
$ echo '["watch", "/path/to/dir"]' > cmd.json
$ watchman -j < cmd.json
```

```bash
$ watchman --json-command <<-EOT
["watch", "/path/to/dir"]
EOT
```

## Server Options

These options are used when starting the server.  They are recognized by the
client and affect how it will start the server, but have no effect if the
server is already running.  To change the effective values of these options
for a running server, you will need to restart it (you can stop it by running
[watchman shutdown-server](/watchman/docs/cmd/shutdown-server.html)).

By default, watchman will remember all watches and associated triggers and
reinstate them if the process is restarted.  This state is stored in the
*statefile*:

```
 --statefile=PATH      Specify path to file to hold watch and trigger state
 -n, --no-save-state   Don't save state between invocations
```

If you configured watchman using `--enable-statedir=<STATEDIR>` the
default location for statefile will be `<STATEDIR>/<USER>.state`, otherwise it
will be `<TMPDIR>/.watchman.<USER>.state`.

```
-o, --logfile=PATH   Specify path to logfile
    --log-level      set log verbosity (0 = off, default is 1, verbose = 2)
```

If you configured watchman using `--enable-statedir=<STATEDIR>` the
default location for logfile will be `<STATEDIR>/<USER>.log`, otherwise it
will be `<TMPDIR>/.watchman.<USER>.log`.

In some relatively uncommon circumstances, such as in test harnesses, you may
need to directly run the service without it putting itself into the background:

```
 -f, --foreground      Run the service in the foreground
```
