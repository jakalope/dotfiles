" pathogen
call pathogen#infect()
let g:session_autosave = 'yes'
let g:session_autoload = 'no'
let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
" let g:ycm_register_as_syntastic_checker = 0
let g:ycm_always_populate_location_list = 1
filetype on
filetype plugin on
filetype indent on
syntax on
set paste
set nocompatible
set showmode
set title
set viminfo='20,\"50
set history=50
set bs=2
set ruler
set nohlsearch

set encoding=utf-8 
set fileencoding=utf-8 

" Indentation settings for using hard tabs for indent. Display tabs as
" two characters wide.
set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4
set autoindent
set smartindent

" ctags
set tags=tags;/

" gvim
if has("gui_running")
    colorscheme default
endif

" taglist
"let Tlist_Auto_Open=1
"let Tlist_Exit_OnlyWindow=1
"nnoremap <silent> <F8> :TlistToggle<CR>

" vcscommand
"cabbrev vlog VCSLog
"cabbrev vdiff VCSDiff
"cabbrev vblame VCSAnnotate

" nnoremap <C-s> :Unite buffer -input=

" for tmux:
" nnoremap <C-b> <C-a>

nnoremap <C-\> :YcmCompleter GoToDefinition<CR>
nnoremap <C-]> :YcmCompleter GoToImprecise<CR>
nnoremap <C-f> :YcmCompleter GoToInclude<CR>
nnoremap <C-t> :YcmCompleter GetType<CR>

nnoremap _w :wa<CR>:!git clang-format -f<CR>:Reload<CR>

" set nowrap

" Allows you to switch from an
" unsaved buffer without saving it first. Also allows you to keep an undo
" history for multiple files. Vim will complain if you try to quit without
" saving, and swap files will keep you safe if your computer crashes.
set hidden

" Better command-line completion
set wildmenu

" Show partial commands in the last line of the screen
set showcmd

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start

" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent

" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler

" Always display the status line, even if only one window is displayed
set laststatus=2

" Instead of failing a command because of unsaved changes, raise a
" dialogue asking if you wish to save changed files.
set confirm

" Use visual bell instead of beeping when doing something wrong
set visualbell

" Reset the terminal code for the visual bell.  If visualbell is set, and
" this line is also included, vim will neither flash nor beep.  If visualbell
" is unset, this does nothing.
set t_vb=

" Set the command window height to 2 lines, to avoid many cases of having to
" "press <Enter> to continue"
set cmdheight=2

" Display line numbers on the left
set number

set incsearch
set scrolloff=2

let DoxygenToolkit_commentType=1

nnoremap + maO<esc>`a
nnoremap = mao<esc>`a

"nnoremap <C-p> "0p

" Make hg merge easier.
"nmap <F4> :diffput 2<CR>
"nmap <F5> :diffget 3<CR>
"nmap <F6> :diffget 4<CR>

"------------------------------------------------------------

nnoremap <C-}> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
nnoremap tab mo:tabnew %<CR>`o<C-]>
nnoremap tib mo:tabnew %<CR>`o<C-\>f
nnoremap _g :grep! "\b<C-R><C-W>\b" *<CR>

map! <F1> <ESC>
"map <F1> dwWbi <ESC>px  
"map <F2> 0f<cf=local_params.getParam(<ESC>2f"ld2Wdw0wPa = <ESC>$xxxA;<ESC>j0
"map <F3> :!pdflatex %:t<CR>:!evince %:r.pdf<CR>
"map <F4> 0f(?::<CR>bd2f:>>$a;<ESC>
"map <F5> dw"+gPb

" convert a 1-line CPP function definition signature to a declaration signature
nnoremap _sig >>Wd2f:A;<ESC>0w

" Put cursor over a character to align the rest of the paragraph to, then type _align
nnoremap _align ywmvV}:s/<C-r>"/`<C-r>"/g<CR>V'v:!column -ts \`<CR>

" Open previous tag in new tab
nnoremap _t :tabnew %<CR>:tabprev<CR><C-o>

" Restyle source code
vnoremap _style :!astyle<CR>
nnoremap _style :%!astyle<CR>
command! Style :%!astyle

"
nnoremap _c :!make_this_package % 2>$(cat ~/use-me-tty) >$(cat ~/use-me-tty) &<CR>
command! W :w
command! Wa :wa

" Convert Structure-Of-Arrays to Array-Of-Structures
vnoremap _aos :s/\(\w*\)\.\(\w*\)\[\(\w*\)\]/\1[\3].\2/g<CR>

" Copy current file:line to the system clipboard
nnoremap _b :exe "silent !echo \"b $(pwd)/".expand("%").":".line(".")."\" \| xsel --clipboard --input"<CR>:redraw!<CR>

" Find all files that include this file, in this directory
nnoremap _down :let g:cmd=system("echo ".expand('%')." \| awk -F/ '{print $(NF-1)\"/\"$NF}'")<CR>:cs find i <C-R>=g:cmd<CR><CR>

" Open compainion file, if it exists (e.g. test.h -> test.cpp)
nnoremap <C-C> :let g:word="\\/" . expand("%:t:r") . "\\.c"<CR>:vsp<CR>:cs find f <C-R>=g:word<CR><CR>
nnoremap <C-H> :let g:word="\\/" . expand("%:t:r") . "\\.h"<CR>:vsp<CR>:cs find f <C-R>=g:word<CR><CR>
nnoremap <C-c> :let g:word="\\/" . expand("%:t:r") . "\\.c"<CR>:cs find f <C-R>=g:word<CR><CR>
nnoremap <C-h> :let g:word="\\/" . expand("%:t:r") . "\\.h"<CR>:cs find f <C-R>=g:word<CR><CR>

" Cycle through windows
nnoremap <F5> <C-w>W
nnoremap <F6> <C-w>w

" Cycle through tabs
nnoremap <F7> :tabprev<CR>
nnoremap <F8> :tabnext<CR>

" Cycle through buffers in the current window
nnoremap <S-F7> :bp<CR>
nnoremap <S-F8> :bn<CR>

" Cycle through tags
nnoremap <C-F5> :tp<CR>
nnoremap <C-F6> :tn<CR>

" Break up this multi-var definition into two lines
nnoremap _n 0wyWf,i;	pdf,0

" Reload all windows in all tabs
command! Reload :tabdo exec 'windo e'

" Detect filetype in each tab
command! Detect :tabdo exec 'filetype detect'

" Remove all buffers
command! Clear :0,10000bd


nnoremap >> 0i<TAB><ESC>

" Move to beginning of next word, skipping non-word characters
function! NextWord() range
    for i in range(1,v:count1)
        call search('\W*\<\w', 'eW')
    endfor
endfunction
noremap <silent> Y :call NextWord()<CR>

" 
command! -nargs=1 Tnb call s:Tnb(<f-args>)
function! s:Tnb(arg)
    tabnew
    let cmd = 'Unite -input='.a:arg.' buffer'
    execute cmd
endfunction

" Converters for hex and decimal numbers
command! -nargs=? -range Dec2hex call s:Dec2hex(<line1>, <line2>, '<args>')
function! s:Dec2hex(line1, line2, arg) range
  if empty(a:arg)
    if histget(':', -1) =~# "^'<,'>" && visualmode() !=# 'V'
      let cmd = 's/\%V\<\d\+\>/\=printf("0x%x",submatch(0)+0)/g'
    else
      let cmd = 's/\<\d\+\>/\=printf("0x%x",submatch(0)+0)/g'
    endif
    try
      execute a:line1 . ',' . a:line2 . cmd
    catch
      echo 'Error: No decimal number found'
    endtry
  else
    echo printf('%x', a:arg + 0)
  endif
endfunction

command! -nargs=? -range Hex2dec call s:Hex2dec(<line1>, <line2>, '<args>')
function! s:Hex2dec(line1, line2, arg) range
  if empty(a:arg)
    if histget(':', -1) =~# "^'<,'>" && visualmode() !=# 'V'
      let cmd = 's/\%V0x\x\+/\=submatch(0)+0/g'
    else
      let cmd = 's/0x\x\+/\=submatch(0)+0/g'
    endif
    try
      execute a:line1 . ',' . a:line2 . cmd
    catch
      echo 'Error: No hex number starting "0x" found'
    endtry
  else
    echo (a:arg =~? '^0x') ? a:arg + 0 : ('0x'.a:arg) + 0
  endif
endfunction

Detect

