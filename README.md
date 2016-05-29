# linux-config Cheat Sheet

Bash
----

* `sed -i 's/[regex]/[replacement]/g' <file1> <file2> ... <fileN>` Inline search/replace.
* `sed -n '/[regex]/p' <file1> <file2> ... <fileN>` Use `sed` regex syntax to `grep` for things.
* `awk [-f<delimiter-char>] '{print $<field>}'`
* `time <program>`


Git
---

* Typical workflow
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
* Squash workflow
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
* Auto-build YCM with `--clang-completer`

