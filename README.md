# linux-config Cheat Sheet

Bash
----

* `pkill -trap <ros-node-name>` Trap a process that's running in GDB without causing a delayed SIGKILL.
* `sed -i 's/[regex]/[replacement]/g' <file1> <file2> ... <fileN>` Inline search/replace.
* `sed -n '/[regex]/p' <file1> <file2> ... <fileN>` Use `sed` regex syntax to `grep` for things.
* `awk [-F<delimiter-char>] '{print $<field>}'`
* `time <program>`
* `trap "rm -rf \"${your_temporary_files}\"" EXIT` Cleanup after yourself, no matter how your script exits.


### Useful CLI stuff

* `code_window` Open 2 `gnome-terminal`s, (1) with a vimserver (suffix is first arg), the other is a prompt.
* `cfiles` List all c-language related files in the current direction and all sub-directories.
* `cgrep` Grep through all files listed by `cfiles`.
* `mfiles` Same as `cfiles`, for Matlab files.
* `mgrep` Same as `cgrep`, for Matlab files.
* `pyfiles` Same as `cfiles`, for Python files.
* `pygrep` Same as `cgrep`, for Python files.
* `vims` Open a vimserver or open a file in an existing vimserver.
* `jf` Open the file path in the system clipboard in the existing vimserver.
* `. most-used` Tell what your most used commands are.

### My workflow
```
<Ctrl-Alt-t>       # Open a new terminal.
$ code_window      # Replace new terminal with a vimserver and a bash prompt.
$ wcd              # Change directories to my workspace directory.
$ vim-uncommitted  # Open any uncommitted files in the vimserver.
$ vims somefile.c  # Open a specific file in the vimserver.
<Alt-Tab>          # Switch to vimserver.
_e                 # Attempt to compile the current buffer's file's module,
                   # displaying all output in the other bash prompt window and 
                   # highlighting errors in red.
<Copy>             # Double click on [filename]:[line]:[column] from the 
                   # error line (directly behind the red text) and
                   # right click to copy.
$ jf               # From bash prompt, open the [filename]:[line] in the 
                   # system clipboard in the vimserver and go to the line.
$ cgrep some_thng  # Some C-language identifier is being misused.
                   # Look for occurances and print them with line numbers.
<Copy>             # Same as before, copy the [filename]:[line].
$ jf               # Open the [filename]:[line] in the vimserver.
<API-change>       # Sometimes you have to change the same thing in lots of places.
$ cgrep chgd_thng | vims
                   # You can just pipe the output of cgrep to vims and
                   # vims will open each file, placing the cursor at the given line.
```

### My most used commands

| Usage  |Command|
|--------|-------|
|   3645 |git    |
|   3267 |bazel  |
|   2674 |cd     |
|   2378 |vims   |
|   2113 |gs     |
|   1910 |ls     |
|   1536 |jf     |
|   1041 |gc     |
|    731 |bcd    |
|    644 |cgrep  |

Git
---

* `git diff --name-only HEAD~1` List the files changes between HEAD and HEAD~1. Useful for piping into `vims`!
* `git log origin..HEAD` View a log w.r.t. the current HEAD. Similar to `hg log -b $(hg branch)`
* `git checkout messy_old_branch -- path/to/relavent/files/*` Cherry pick some files to be committed on a new branch.

### Aliases
* `ga` Alias for `git add`
* `gc` Alias for `git commit`
* `gd` Alias for `git diff`
* `gf` Alias for `git fetch`
* `gs` Alias for `git status`

### Typical workflow
```sh
git fetch origin
git checkout master
git merge origin/master
git checkout -b feature_branch
<work>
git commit -am "work"
git push origin feature_branch
git fetch origin
git merge origin/master
git push origin feature_branch
```

### Squash workflow
```sh
git checkout feature_branch
git fetch origin
git rebase -i origin/master
<squash all commits but the first>
git push origin feature_branch --force 
```

### Alternate squash workflow
```sh
<on my branch -- original_branch>
git fetch origin -p
git merge origin/master
<resolve merge conflicts>
git commit
git checkout master
git pull
git checkout -b temp
git merge --squash original_branch
git commit -am 'squash merge master onto original_branch'
git branch -D original_branch
git checkout -b original_branch
git branch -D temp
```

GCC
---

* `gcc -S helloworld.c` Outputs assembler code to `helloworld.s`.

GDB
---

### Printing and inspection
* `p [arg]`
* `p {type}[address]` [Type Shortcut](http://visualgdb.com/gdbreference/commands/print)
* `p *[pointer]@[num_elements]` [Artificial Arrays](https://sourceware.org/gdb/onlinedocs/gdb/Arrays.html)
* `whatis [arg]`
* `ptype [arg]`
* `display`
* `info locals`
* `info scope`

### Breakpoints and line-by-line flow
* `b [place] [if [expr]]` Set a breakpoint at line `[place]` (default: current line), optionally on condition `[expr]`.
* `d [num]` Delete breakpoint `[num]` (default: all breakpoints).
* `n` Continue till next line.
* `s` Step into the current line.
* `fin` Step out of the current function.
* A typical flow is `n`, `n`, `s`, `fin`, `s`, `fin`, `s`, `n`, `n`, 
`info locals`, `fin`,..., i.e. continue until you get to the function 
of interest, step into the first argument of that function, step out of it, 
step into the second argument, step out, step into the actual function,
continue a couple of lines, print values of all local variables, step out.


### Call stack inspection
* `up` Move up the call stack without affecting execution.
* `down` Move down the call stack without affecting execution.
* `backtrace; bt` Print the call stack (aka backtrace) without affecting execution.

### Thread inspection
* `info threads` Display the list of threads.
* `thread [num]` Switch to thread `[num]`.
* `thread apply all backtrace` Backtrace all threads.

VIM
---

### Built-in things that I typically forget about

* `<leader>` => `\`
* `<C-W> =` Set vim splits to equal size.
* `g-` Reload to a previous save.
* `it` Inner-tag motion, e.g. `citasdf` applied anywhere inside `<a>fdsa</a>` will yield `<a>asdf</a>`.

### Custom key-bindings

* `_y` Copy [relative-path] of current buffer to register 0 and the system clipboard (used to create #include lines).
* `_b` Copy "b [absolute-path]:[line]" of the current buffer to the system clipboard (used to set breakpoints in GDB).

### Plugin Cusomizations

### [vim-git](https://github.com/tpope/vim-git)

* `ze` Open companion file in current window.
* `zt` Open companion file in new tab.
* `zv` Open companion file in new vertical split.
* `zs` Open companion file in new horizontal split.

### [vim-fugative](https://github.com/tpope/vim-fugitive)

* `Gblame` Run a side pane with `git blame` output.

### [CtrlP.vim](https://github.com/kien/ctrlp.vim)

* `;p` Open CtrlP file path search dialog (default: `<C-P>`).
* `;b` Open CtrlP buffer search dialog (default: `<C-B>`).
* `;m` Open CtrlP most-recently-used dialog.
* `;c` Clear CtrlP cache NOW (default: `<F5>`).

### [YouCompleteMe](https://github.com/Valloric/YouCompleteMe)

* `<C-\>` Go to definition.
* `<C-]>` Go to definition (imprecise) or file in include path.
* `<C-t>` Get type.
* `<C-f>` Force clang recompile.
* `<C-j>` Fix-it.
* `:call YcmToggle()` Toggle Ycm for this buffer.

### [vim-abolish](https://github.com/tpope/vim-abolish)

Automatically handle various cases, such as `snake_case`, `camelCase`, `UPPER_CASE`, and `MixedCase` when doing a search/replace or when you want to change the case of the word under the cursor.

* `:[range]S/[regex]/[string]/g` abolish-subvert
* `crc`, `crm`, `crs`, `cru` abolish-coercion

### [vim-easymotion](https://github.com/easymotion/vim-easymotion)
* `;l` Search anywhere on the page.
* `\\s<letter><follow-letter>` Search anywhere on the page for `<letter>` and jump to `<follow-letter>`.

Valgrind
--------

### False positive suppression
* `valgrind --gen-suppressions=yes` Generate suppressions file.
* `valgrind --suppressions=<filename>` Use suppressions file to omit specific valgrind errors.

### Tools
* `valgrind --tool=cachegrind --cache-sim=yes --branch-sim=yes` Cache-miss and branch-misprediction profiler.
* `cg_annotate --auto=yes` 
* `valgrind --tool=callgrind --callgrind-out-file=<file>` CPU profiler.
* `kcachegrind <file>` CPU profile viewer.
* `valgrind --tool=massif` Memory profiler.
* `massif-visualizer <file>` Memory profile visualizer.


GraphViz
--------

* `dot -Txlib <dot-file>`


Todo
----

* CtrlP: prioritize regexp. If no results, use fuzzy.
* Consider CTags again, as YCM doesn't work when your code doesn't compile.
* Proper dereferencing of `unique_ptr` pretty printer in gdb.
* Figure out how to get `valgrind --db-attach=yes` working.
* Make `code_window` terminal-size-aware
* CtrlP: filter .pyc files
* vims: remove extraneous content of $line variable
* jf: find a way to Alt-TAB to vimserver window after opening the file
* Fix vimserver changing its working directory on `<C-]>`
* Make a switch for compilation mode and use a single mapping to compile
* Find a way to automate use of `clang-3.6 -v -E -x c++ -` for ycm
  (see also https://github.com/Valloric/YouCompleteMe/issues/1790)
