# linux-config Cheat Sheet

Bash
----

* `sed -i 's/[regex]/[replacement]/g' <file1> <file2> ... <fileN>` Inline search/replace.
* `sed -n '/[regex]/p' <file1> <file2> ... <fileN>` Use `sed` regex syntax to `grep` for things.
* `awk [-F<delimiter-char>] '{print $<field>}'`
* `time <program>`


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

| Rank | Usage % | Command  |
|------|---------|----------|
|1.    |  55.5%  | git      |
|2.    |  9.2%   |  cd      |
|3.    |  6.2%   |  jf      |
|4.    |  4%     |  bcd     |
|5.    |  2.9%   |  ls      |
|6.    |  2.8%   |  vims    |
|7.    |  2.6%   | valgrind |
|8.    |  2.3%   |  cgrep   |
|9.    |  2%     |  gdb     |
|10.   |  1.7%   |  ll      |

Git
---

### Aliases
* `ga` Alias for `git add`
* `gc` Alias for `git commit`
* `gd` Alias for `git diff`
* `gf` Alias for `git fetch`
* `gs` Alias for `git status`

### Typical workflow
```
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
```
git checkout feature_branch
git fetch origin
git rebase -i origin/master
<squash all commits but the first>
git push origin feature_branch --force 
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

VIM
---

* `<leader>` => `\`
* `<C-W> =` Set vim splits to equal size.
* `g-` Reload to a previous save.
* `_y` Copy [relative-path] of current buffer to register 0 and the system clipboard (used to create #include lines).
* `_b` Copy "b [absolute-path]:[line]" of the current buffer to the system clipboard (used to set breakpoints in GDB).

### Plugin Cusomizations

### [vim-git](https://github.com/tpope/vim-git)

* `ze` Open companion file in current window.
* `zt` Open companion file in new tab.
* `zv` Open companion file in new vertical split.
* `zs` Open companion file in new horizontal split.

### [CtrlP.vim](https://github.com/kien/ctrlp.vim)

* `;p` Open CtrlP file path search dialog (default: `<C-P>`).
* `;b` Open CtrlP buffer search dialog (default: `<C-B>`).
* `;m` Open CtrlP most-recently-used dialog.
* `;;` Clear CtrlP cache NOW (default: `<F5>`).

### [YouCompleteMe](https://github.com/Valloric/YouCompleteMe)

* `<C-\>` Go to definition.
* `<C-]>` Go to definition (imprecise).
* `<C-f>` Go to file in include path.
* `<C-t>` Get type.

### [vim-abolish](https://github.com/tpope/vim-abolish)

Automatically handle various cases, such as `snake_case`, `camelCase`, `UPPER_CASE`, and `MixedCase` when doing a search/replace or when you want to change the case of the word under the cursor.

* `:[range]S/[regex]/[string]/g` abolish-subvert
* `crc`, `crm`, `crs`, `cru` abolish-coercion

### [vim-easymotion](https://github.com/easymotion/vim-easymotion)
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

