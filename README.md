# linux-config

Cheet Sheet
===========

GDB
---

* `print; p [arg]`
* `p {`*type*`}[address]` [Type Shortcut](http://visualgdb.com/gdbreference/commands/print)
* `whatis [arg]`
* `ptype [arg]`
* `display`
* `info locals`
* `info scope`
* `break [place] [conditional]`
* `d [num]`
* `next; n`
* `step; s`
* `finish; fin`
* `up`
* `down`
* `backtrace; bt`
* `info threads`
* `thread [num]`
* `p *[pointer]@[num_elements]` [Artificial Arrays](https://sourceware.org/gdb/onlinedocs/gdb/Arrays.html)


VIM Plugins
-----------

### CtrlP

* `<C-p>`
* `<C-b>`
* `<C-c>`
* `;;` Clear cache NOW (normally <F5>)

### YouCompleteMe

* `<C-\> :tab YcmCompleter GoToDefinition`
* `<C-]> :tab YcmCompleter GoToImprecise`
* `<C-f> :tab YcmCompleter GoToInclude`
* `<C-t> :YcmCompleter GetType`

### Abolish

* `:[range]S/[regex]/[string]/g` abolish-substitute
* `crc`, `crm`, `crs`, `cru` abolish-coercion
 

Valgrind
--------

* `valgrind --gen-suppressions=yes`
* `valgrind --suppressions=<filename>`
* `valgrind --db-attach=yes`
* `valgrind --tool=cachegrind --cache-sim=yes --branch-sim=yes --cachegrind-out-file=<file>`
