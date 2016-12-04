" Remove all autocommands for the current group.
autocmd!

"""""""""" Script opts
" YouCompleteMe
" let g:ycm_register_as_syntastic_checker = 0
set completeopt-=preview
let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
let g:ycm_always_populate_location_list = 0
let g:ycm_open_loclist_on_ycm_diags = 1
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 0
let g:ycm_key_invoke_completion = '<C-m>'
let g:ycm_collect_identifiers_from_tags_files = 0
let g:ycm_filetype_specific_completion_to_disable = {
    \ 'gitcommit': 1,
    \}

nnoremap <C-\> :YcmCompleter GoTo<CR>
nnoremap <C-j> :YcmCompleter FixIt<CR>
nnoremap <C-t> :YcmCompleter GetType<CR>
nnoremap <C-f> :YcmForceCompileAndDiagnostics<CR>

function! YcmToggle()
    if exists("b:ycm_largefile") && b:ycm_largefile
        let b:ycm_largefile=0
    else
        let b:ycm_largefile=1
    endif
endfunction

" CtrlP
let g:ctrlp_clear_cache_on_exit = 1
let g:ctrlp_max_files = 0
let g:ctrlp_max_depth = 40
let g:ctrlp_regexp = 1
nnoremap ;p :CtrlP<CR>
nnoremap ;b :CtrlPBuffer<CR>
nnoremap ;m :CtrlPMRU<CR>
nnoremap ;] :CtrlPTag<CR>
nnoremap ;c :CtrlPClearAllCaches<CR>

" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" Python-mode
let g:pymode_rope_goto_definition_bind = "<C-]>"
let g:pymode_run_bind = "<C-S-e>"
let g:pymode_doc_bind = "<C-S-d>"
let g:pymode_trim_whitespaces = 1
let g:pymode_indent = 1
let g:pymode_options = 1
let g:pymode_doc = 1
let g:pymode_rope_complete_on_dot = 0
let g:pymode_rope_completion_bind = '<C-n>'

" UltiSnips
" Trigger configuration. Do not use <tab> if you use YCM
let g:UltiSnipsExpandTrigger="<C-space>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsSnippetsDir="~/.vim/ultisnips"

" Smartword
map <SPACE>  <Plug>(smartword-w)
map <C-SPACE>  <Plug>(smartword-b)
" map e  <Plug>(smartword-e)
" map ge  <Plug>(smartword-ge)

" Argumentitive
" nmap [; <Plug>Argumentative_Prev
" nmap ]; <Plug>Argumentative_Next
" xmap [; <Plug>Argumentative_XPrev
" xmap ]; <Plug>Argumentative_XNext
nnoremap <; <Plug>Argumentative_MoveLeft
nnoremap >; <Plug>Argumentative_MoveRight
" xmap i; <Plug>Argumentative_InnerTextObject
" xmap a; <Plug>Argumentative_OuterTextObject
" omap i; <Plug>Argumentative_OpPendingInnerTextObject
" omap a; <Plug>Argumentative_OpPendingOuterTextObject

" Easymotion
map ;l <Plug>(easymotion-bd-w)

" Easy-tags
set tags="./tags,~/.vim/tags";
let g:easytags_file = '~/.vim/tags'   " global tags file
let g:easytags_dynamic_files = 1
let g:easytags_async = 1
let g:easytags_events = []
let g:easytags_on_cursorhold = 0
let g:easytags_auto_update = 1
let g:easytags_include_members = 1
let g:easytags_auto_highlight = 0
let vbs=1  " check timing with :messages

"""""""""" Vundle
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle; disable Git because we hate git submodules
Plugin 'VundleVim/Vundle.vim', {'pinned': 1}

Plugin 'Valloric/YouCompleteMe'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'drmikehenry/vim-fontsize'
Plugin 'easymotion/vim-easymotion'
Plugin 'kana/vim-operator-user'
Plugin 'kana/vim-smartword'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-sensible'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-scripts/restore_view.vim'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'xolox/vim-easytags'
Plugin 'xolox/vim-misc'
Plugin 'PeterRincker/vim-argumentative'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
syntax on

"""""""""" End Vundle

" Used by restore_view.vim
set autoindent
set backspace=indent,eol,start " Allow backspacing over autoindent, line breaks and start of insert action
set bs=2
set cindent
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
set relativenumber
set scrolloff=999
set shiftwidth=4
set showcmd " Show partial commands in the last line of the screen
set showmode
set softtabstop=4
set spell spelllang=en_us
set tabstop=4
set title
set viewoptions=cursor,folds,slash,unix
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

" colors
colorscheme desert
set guifont=Droid\ Sans\ Mono\ for\ Powerline\ 11

"============================================================

let DoxygenToolkit_commentType=1

nnoremap + maO<esc>`a
nnoremap = mao<esc>`a

"""""""""""""" Change how vim is interacted with

" Resize splits on window resize.
augroup AutoResizeSplits
   autocmd!
   autocmd VimResized * exe "normal! \<c-w>="
augroup END

" fast buffer deletion
nnoremap <F9><F9> :bd<CR>

map! <F1> <ESC>

command! W :w
command! Wa :wa

" Stop accidental entry into Ex mode
nnoremap Q <CR>


""""""""""""""

nnoremap _g :grep! "\b<C-R><C-W>\b" * 2>/dev/null<CR>

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

" Set a default state for _c
nnoremap _c :CompileOptimized<CR>

" Redefine _c to execute some other commands. Used as a switching mechanism.
command! CompileVisible   exe "silent !make_this_package % 2>&1 \| grep --color -E \'error:\|\$\' &>$(cat ~/use-me-tty-".v:servername.") &"
command! CompileFast      exe "silent !make_this_package % &>$(cat ~/use-me-tty-".v:servername.") &"
command! CompileOptimized exe "silent !make_this_package % --compilation_mode=opt &>$(cat ~/use-me-tty-".v:servername.") &"
command! CompileDebug     exe "silent !make_this_package % --compilation_mode=dbg &>$(cat ~/use-me-tty-".v:servername.") &"

nnoremap _e :nnoremap _c :CompileVisible<LT>CR><LT>C-L><CR>:echo "Set compile mode to Visible"<CR>
nnoremap _f :nnoremap _c :CompileFast<LT>CR><LT>C-L><CR>:echo "Set compile mode to Fast"<CR>
nnoremap _o :nnoremap _c :CompileOptimized<LT>CR><LT>C-L><CR>:echo "Set compile mode to Optimized"<CR>
nnoremap _d :nnoremap _c :CompileDebug<LT>CR><LT>C-L><CR>:echo "Set compile mode to Debug"<CR>

" Convert Structure-Of-Arrays to Array-Of-Structures
vnoremap _aos :s/\(\w*\)\.\(\w*\)\[\(\w*\)\]/\1[\3].\2/g<CR>

" Copy current file:line to the system clipboard, preceded by "b"
" Used to set breakpoints in GDB
nnoremap _b :exe "silent !echo \"b $(pwd)/".expand("%").":".line(".")."\" \| xsel --clipboard --input"<CR>:redraw!<CR>

" yank name of current file to register 0 and to system clipboard
nnoremap _y :let @"=@%<CR>:let @+=@%<CR>

" Find all files that include this file, in this directory
" nnoremap _down :let g:cmd=system("echo ".expand('%')." \| awk -F/ '{print $(NF-1)\"/\"$NF}'")<CR>:cs find i <C-R>=g:cmd<CR><CR>

"This redefines the backspace key to start a new undo sequence.  You can now
"undo the effect of the backspace key, without changing what you typed before
"that, with CTRL-O u.
inoremap <C-H> <C-G>u<C-H>

"This breaks undo at each line break.  It also expands abbreviations before
"this.
inoremap <CR> <C-]><C-G>u<CR>

" Open companion file, if it exists (e.g. test.h -> test.cpp)
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

nnoremap ze :cd ${MY_WORKSPACE_DIR}<CR>:execute 'edit '.g:Companion()<CR>
nnoremap zt :cd ${MY_WORKSPACE_DIR}<CR>:execute 'tabnew '.g:Companion()<CR>
nnoremap zv :cd ${MY_WORKSPACE_DIR}<CR>:execute 'vsplit '.g:Companion()<CR>
nnoremap zs :cd ${MY_WORKSPACE_DIR}<CR>:execute 'split '.g:Companion()<CR>

" Cycle through tabs and buffers
nnoremap <F5> :tabp<CR>
nnoremap <F6> :bp<CR>
nnoremap <F7> :bn<CR>
nnoremap <F8> :tabn<CR>

" Reload all windows, tabs, buffers, etc.
command! Reload :call s:Reload()
function! s:Reload()
    setlocal autoread
    checktime
    set autoread<
endfunction

" Apply `yapf` to current file
nnoremap ;f :%!yapf<CR>

" Detect filetype in each tab
command! Detect :tabdo exec 'filetype detect'

command! Wcd cd ${MY_WORKSPACE_DIR}
command! Src source ~/.vimrc

" Remove all buffers
command! Clear :0,10000bd

Detect
filetype plugin on
