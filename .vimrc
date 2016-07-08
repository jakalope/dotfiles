" Remove all autocommands for the current group.
autocmd!

"""""""""" Script opts
" Clang-Format
let g:clang_format#command = 'clang-format-3.6'
let g:clang_format#detect_style_file = 1

" Autoformat
let g:formatdef_autopep8 = "'autopep8 - --range '.a:firstline.' '.a:lastline.' --max-line-length=80'"
let g:formatters_python = ['autopep8']

" YouCompleteMe
" let g:ycm_register_as_syntastic_checker = 0
let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
let g:ycm_always_populate_location_list = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:tern_request_timeout = 3

" CtrlP
let g:ctrlp_clear_cache_on_exit = 1
let g:ctrlp_regexp = 1

" Airline
let g:airline#extensions#tabline#enabled = 1

"""""""""" Vundle
set nocompatible              " be iMproved, required
filetype off                  " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'Valloric/YouCompleteMe'
Plugin 'Chiel92/vim-autoformat'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'easymotion/vim-easymotion'
Plugin 'vim-airline/vim-airline'
Plugin 'kana/vim-operator-user'
Plugin 'kana/vim-smartword'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'rhysd/vim-clang-format'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-sensible'
Plugin 'vim-scripts/restore_view.vim'
Plugin 'drmikehenry/vim-fontsize'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

"""""""""" End Vundle

" Used by restore_view.vim
set viewoptions=cursor,folds,slash,unix

filetype on
filetype plugin on
syntax on

set autoindent
set backspace=indent,eol,start " Allow backspacing over autoindent, line breaks and start of insert action
set bs=2
set cmdheight=2
set encoding=utf-8
set equalalways
set expandtab
set fileencoding=utf-8
set history=50
set incsearch
set laststatus=2 " Always display the status line, even if only one window is displayed
set nofoldenable
set nohlsearch
set number
set paste
set scrolloff=999
set shiftwidth=4
set showcmd " Show partial commands in the last line of the screen
set showmode
set smartindent
set softtabstop=4
set spell spelllang=en_us
set tabstop=4
set title
set viminfo='20,\"50
set visualbell " Use visual bell instead of beeping when doing something wrong
set wildmenu " Better command-line completion

" Allows you to switch from an
" unsaved buffer without saving it first. Also allows you to keep an undo
" history for multiple files. Vim will complain if you try to quit without
" saving, and swap files will keep you safe if your computer crashes.
set hidden

" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler

" Instead of failing a command because of unsaved changes, raise a
" dialogue asking if you wish to save changed files.
set confirm

" Reset the terminal code for the visual bell.  If visualbell is set, and
" this line is also included, vim will neither flash nor beep.  If visualbell
" is unset, this does nothing.
set t_vb=

" ctags
set tags=tags;/

" colors
colorscheme desert
set guifont=Monospace\ 11

"""""""""""""" YCM
nnoremap <C-\> :YcmCompleter GoToDefinition<CR>
nnoremap <C-]> :YcmCompleter GoToImprecise<CR>
nnoremap <C-f> :YcmCompleter FixIt<CR>
nnoremap <C-t> :YcmCompleter GetType<CR>

"""""""""""""" CtrlP
nnoremap ;p :CtrlP<CR>
nnoremap ;b :CtrlPBuffer<CR>
nnoremap ;m :CtrlPMRU<CR>

"""""""""""""" ClangFormat
" map to <Leader>cf in C++ code
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>
" if you install vim-operator-user
autocmd FileType c,cpp,objc map <buffer><Leader>x <Plug>(operator-clang-format)
" Toggle auto formatting:
nmap <Leader>C :ClangFormatAutoToggle<CR>

let DoxygenToolkit_commentType=1

nnoremap + maO<esc>`a
nnoremap = mao<esc>`a

"============================================================

"""""""""""""" Change how vim is interacted with

" Resize splits on window resize.
augroup AutoResizeSplits
   autocmd!
   autocmd VimResized * exe "normal! \<c-w>="
augroup END

command! Src source ~/.vimrc

" alternative ESC key combo ( 'cause <Esc> is too far away :-P )
inoremap jk <Esc>

" fast buffer deletion
nnoremap <F9><F9> :bd<CR>

map! <F1> <ESC>

command! W :w
command! Wa :wa

" Stop accidental entry into Ex mode
nnoremap Q <CR>


""""""""""""""

nnoremap _g :grep! "\b<C-R><C-W>\b" *<CR>

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

" TODO: only use compilation_mode when build system is bazel
nnoremap _e :exe "silent !make_this_package % 2>&1 \| grep --color -E \'error:\|\$\' &>$(cat ~/use-me-tty-".v:servername.") &"<CR><C-L>
nnoremap _f :exe "silent !make_this_package % &>$(cat ~/use-me-tty-".v:servername.") &"<CR><C-L>
nnoremap _c :exe "silent !make_this_package % --compilation_mode=opt &>$(cat ~/use-me-tty-".v:servername.") &"<CR><C-L>
nnoremap _d :exe "silent !make_this_package % --compilation_mode=dbg &>$(cat ~/use-me-tty-".v:servername.") &"<CR><C-L>

" TODO make this use a custom command
nnoremap _h :exe "silent !make_this_package % --compilation_mode=dbg &>$(cat ~/use-me-tty-".v:servername.") &"<CR><C-L>

" Convert Structure-Of-Arrays to Array-Of-Structures
vnoremap _aos :s/\(\w*\)\.\(\w*\)\[\(\w*\)\]/\1[\3].\2/g<CR>

" Copy current file:line to the system clipboard, preceded by "b"
" Used to set breakpoints in GDB
nnoremap _b :exe "silent !echo \"b $(pwd)/".expand("%").":".line(".")."\" \| xsel --clipboard --input"<CR>:redraw!<CR>

" yank name of current file to register 0 and to system clipboard
nnoremap _y :let @"=@%<CR>:let @+=@%<CR>

" Find all files that include this file, in this directory
" nnoremap _down :let g:cmd=system("echo ".expand('%')." \| awk -F/ '{print $(NF-1)\"/\"$NF}'")<CR>:cs find i <C-R>=g:cmd<CR><CR>

" Open compainion file, if it exists (e.g. test.h -> test.cpp)
function! g:Companion()
    let l:fn_ext = expand("%:e")
    let l:fn_root = expand("%:r")
    if l:fn_ext == "cpp" || l:fn_ext == "c" || l:fn_ext == "cc" || l:fn_ext == "cx" || l:fn_ext == "cxx"
        " TODO see if this file exists; otherwise try other extensions
        let l:fn = l:fn_root.".h"
    elseif l:fn_ext == "h" || l:fn_ext == "hpp"
        " TODO see if this file exists; otherwise try other extensions
        let l:fn = l:fn_root.".cpp"
    else
        return expand("%")
    endif
    let l:git_ls_command = "git ls-files --full-name ".l:fn
    exec "let l:companion_file = system(\"".l:git_ls_command."\")"
    return l:companion_file
endfunction

nnoremap ze :execute 'edit '.g:Companion()<CR>
nnoremap zt :execute 'tabnew '.g:Companion()<CR>
nnoremap zv :execute 'vsplit '.g:Companion()<CR>
nnoremap zs :execute 'split '.g:Companion()<CR>

" Cycle through tabs and buffers
nnoremap <F5> :tabp<CR>
nnoremap <F6> :bp<CR>:AirlineRefresh<CR>
nnoremap <F7> :bn<CR>:AirlineRefresh<CR>
nnoremap <F8> :tabn<CR>

" Reload all windows, tabs, buffers, etc.
command! Reload :call s:Reload()
function! s:Reload()
    setlocal autoread
    checktime
    set autoread<
endfunction

" Apply `git clang-format -f` and reload all buffers
nnoremap <C-d> :Format<CR>
command! Format :call s:Format()
function! s:Format()
    setlocal autoread
    silent wa
    silent !git clang-format -f
    Reload
    set autoread<
endfunction

" Detect filetype in each tab
command! Detect :tabdo exec 'filetype detect'

" Remove all buffers
command! Clear :0,10000bd

Detect
filetype plugin on
