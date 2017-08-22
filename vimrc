" Support for neovim
let g:python_host_prog="/usr/bin/python"
let g:python3_host_prog="/usr/local/bin/python3"
if !filereadable(g:python3_host_prog)
	let g:python3_host_prog="/usr/bin/python3"
endif

" Determine the OS type (Darwin, Unix, Linux)
let g:uname=split(system("uname"), "\000")[0]

" Use the appropriate clipboard CLI for the given OS.
if g:uname=='Darwin'
    let g:copy='pbcopy'
else
    let g:copy='xsel -ipbs'
endif

"""""""""" Plugin opts

" Utilities
let g:util_min_split_cols = 83

nnoremap ze :execute 'edit '.jakalope#utilities#companion()<CR>
nnoremap zt :execute 'tabnew '.jakalope#utilities#companion()<CR>
nnoremap zv :execute 'vsplit '.jakalope#utilities#companion()<CR>
nnoremap zs :execute 'split '.jakalope#utilities#companion()<CR>

" CtrlP (just for buffer search)
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'

nnoremap <Leader>b :CtrlPBuffer<CR>

" CommandT (for file search)
let g:CommandTMaxFiles=1000000
let g:CommandTFileScanner="git"
let g:CommandTGitScanSubmodules=1

nnoremap <Leader>c :CommandTFlush<CR>

" YouCompleteMe
set completeopt-=preview
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_always_populate_location_list = 0
let g:ycm_auto_trigger = 0
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_collect_identifiers_from_tags_files = 0
let g:ycm_confirm_extra_conf = 0
let g:ycm_filepath_completion_use_working_dir = 1
let g:ycm_filetype_specific_completion_to_disable = { 'gitcommit': 1, }
let g:ycm_key_invoke_completion = '<C-space>'
let g:ycm_open_loclist_on_ycm_diags = 0

let s:proposed_ycm_conf = 'scripts/editors/vim/ycm_extra_conf.py'
if filereadable(s:proposed_ycm_conf)
    let g:ycm_global_ycm_extra_conf = s:proposed_ycm_conf
else
    let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
endif

nnoremap <C-\> :YcmCompleter GoTo<CR>
nnoremap <C-g> :YcmCompleter FixIt<CR>
nnoremap <C-t> :YcmCompleter GetType<CR>
nnoremap <C-f> :YcmForceCompileAndDiagnostics<CR>
nnoremap <C-F> :YcmRestartServer<CR>:YcmForceCompileAndDiagnostics<CR>


function! YcmToggle()
    if exists("b:ycm_largefile") && b:ycm_largefile
        let b:ycm_largefile=0
    else
        let b:ycm_largefile=1
    endif
endfunction

" Smartword
map <SPACE>  <Plug>(smartword-w)
map <BackSpace>  <Plug>(smartword-b)
map <S-SPACE>  W

" TODO server2client({clientid}, {string})			*server2client()*

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
map gh <Plug>(easymotion-bd-w)

"""""""""" VAM
"source ~/.vim/vam_setup.vim

"""""""""" Vundle
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle; disable Git because we hate git submodules
Plugin 'VundleVim/Vundle.vim', {'pinned': 1}

" Plugin 'PeterRincker/vim-argumentative'
Plugin 'Valloric/YouCompleteMe'
Plugin 'easymotion/vim-easymotion'
Plugin 'jakalope/vim-utilities'
Plugin 'kana/vim-operator-user'
Plugin 'kana/vim-smartword'
Plugin 'kien/ctrlp.vim'
Plugin 'moll/vim-bbye'
Plugin 'octol/vim-cpp-enhanced-highlight'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-fugitive'
Plugin 'wincent/command-t'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-reload'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
syntax on

"""""""""" End Vundle

set clipboard=unnamed

" Used by restore_view.vim
set autoindent
set autoread
" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start
set bs=2
set cindent
set cmdheight=2
" set encoding=utf-8
set equalalways
set expandtab
set fileencoding=utf-8
set history=50
set noswapfile
set nobackup
set noswapfile
set incsearch
set laststatus=2 " Always display status line
set nofoldenable
set nohlsearch
set number
set notimeout
set nopaste
set relativenumber
set scrolloff=111112
set shiftwidth=4
set showcmd " Show partial commands in the last line of the screen
set showmode
set softtabstop=4
set spell spelllang=en_us
set splitbelow
set splitright
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

"============================================================

" Disable matchparen highlighting
let loaded_matchparen = 1

let DoxygenToolkit_commentType=1

nnoremap + maO<esc>`a
nnoremap = mao<esc>`a

"""""""""""""" Change how vim is interacted with

" Resize splits on window resize.
augroup AutoResizeSplits
   autocmd!
   autocmd VimResized * exe "normal! \<c-w>="
augroup END

command! W :w
command! Wa :wa

" Stop accidental entry into Ex mode
nnoremap Q <CR>

""""""""""""""

" set clipboard=unnamed

nnoremap _g :grep! "\b<C-R><C-W>\b" * 2>/dev/null<CR>

command! Make cexpr s:Maker()
function! s:Maker()
    return system("> /dev/null make_this_package ".expand('%')." 2>&1 \| grep ".
                  \"-E \' error:\'")
endfunction

command! CompileVisible exe "silent !make_this_package % 2>&1 \| grep ".
                        \"--color -E \'error:\|\$\' &>".g:tty." &"

command! CompileFast    exe "silent !make_this_package % &>".g:tty." &"

command! CompileOpt     exe "silent !make_this_package % ".
                        \"--compilation_mode=opt &>".g:tty." &"

command! CompileDebug   exe "silent !make_this_package % ".
                        \"--compilation_mode=dbg &>".g:tty." &"

" Redefine _c to execute some other commands. Used as a switching mechanism.
nnoremap _e :nnoremap _c :CompileVisible<LT>CR><LT>C-L><CR>
                        \:echo "Set compile mode to Visible"<CR>

nnoremap _f :nnoremap _c :CompileFast<LT>CR><LT>C-L><CR>
                        \:echo "Set compile mode to Fast"<CR>

nnoremap _o :nnoremap _c :CompileOpt<LT>CR><LT>C-L><CR>
                        \:echo "Set compile mode to Optimized"<CR>

nnoremap _d :nnoremap _c :CompileDebug<LT>CR><LT>C-L><CR>
                        \:echo "Set compile mode to Debug"<CR>

" Set a default state for _c
nnoremap _c :CompileOpt<CR>

" Copy current file:line to the system clipboard, preceded by "b"
" Used to set breakpoints in GDB
nnoremap _b :exe "silent !echo b ${PWD}/".expand("%").":".
        \line(".")." \| ".g:copy<CR>

" yank name of current file to register 0 and to system clipboard
nnoremap _y :let @"=@%<CR>:let @+=@%<CR>

" Breaks undo at each line break. It also expands abbreviations before this.
inoremap <CR> <C-]><C-G>u<CR>

" Open the file under the cursor in the previous window.
" TODO fix:
" E684: list index out of range: 1
" E15: Invalid expression: split('"vehicle/common/pub_sub/ros_native_publisher.h"', ':')[1]
nnoremap zn :let cur_file=expand('<cfile>')<CR>
            \:let cur_line=split('<C-R><C-A>', ':')[1]<CR>
            \:wincmd p<CR>
            \:exec 'edit '.cur_file<CR>
            \:call cursor(cur_line, 0)<CR>

" Cycle through tabs and buffers
nnoremap <F5> :tabp<CR>
nnoremap <F6> :bp<CR>
nnoremap <F7> :bn<CR>
nnoremap <F8> :tabn<CR>

" fast buffer deletion
nnoremap <F9><F9> :Bdelete<CR>

map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

imap <C-h> <Esc><C-w>h
imap <C-j> <Esc><C-w>j
imap <C-k> <Esc><C-w>k
imap <C-l> <Esc><C-w>l

command! Wcd cd ${MY_WORKSPACE_DIR}

function! CurrentBranch()
    return system('git rev-parse --abbrev-ref HEAD')
endfunction

function! SaveBranchSession()
    let l:sessionops = &sessionoptions
    set sessionoptions=buffers,sesdir
    let l:current_branch=xolox#misc#str#slug(CurrentBranch())
    exec 'mksession! '.l:current_branch
    exec 'set sessionoptions='.l:sessionops
endfunction

function! LoadBranchSession()
    let l:sessionops = &sessionoptions
    set sessionoptions=buffers,sesdir
    let l:current_branch=xolox#misc#str#slug(CurrentBranch())
    exec 'source '.l:current_branch
    exec 'set sessionoptions='.l:sessionops
endfunction

" colors
set guifont=Droid\ Sans\ Mono\ for\ Powerline\ 12
colorscheme elflord
hi SpellBad ctermfg=red ctermbg=NONE
hi SpellCap ctermfg=green ctermbg=NONE

" Toggle numbering
nnoremap ;n :set invrnu<CR>

if has('nvim')
    let g:terminal_scrollback_buffer_size = 100000
    let g:util_workspace_dir = $MY_WORKSPACE_DIR

    tnoremap <C-\> <C-\><C-n>

	tnoremap <F5> <C-\><C-n>:tabp<CR>
	tnoremap <F6> <C-\><C-n>:bp<CR>
	tnoremap <F7> <C-\><C-n>:bn<CR>
	tnoremap <F8> <C-\><C-n>:tabn<CR>
	tnoremap <F9><F9> <C-\><C-n>:Bdelete<CR>

    tnoremap <F10> <C-\><C-n>?Reading 'startup'<CR>/error:<CR>0

    tnoremap <C-h> <C-\><C-n><C-w>h
    tnoremap <C-j> <C-\><C-n><C-w>j
    tnoremap <C-k> <C-\><C-n><C-w>k
    tnoremap <C-l> <C-\><C-n><C-w>l

	tnoremap <C-u> <C-\><C-n><C-u>
	tnoremap <C-d> <C-\><C-n><C-d>

    highlight TermCursor ctermfg=red guifg=red

    augroup terminal
		autocmd!
        autocmd TermOpen * setlocal nospell
        autocmd BufWinEnter,WinEnter term://* startinsert
    augroup END

    autocmd VimEnter * nested vsplit term://bash
    autocmd VimEnter * enew
    autocmd VimEnter * b2
endif

augroup formatting_and_filetypes
    autocmd!

    " Handle all BufWritePre events for specific filetypes.
    " Especially useful for auto-formatting commands.
    autocmd BufWritePre * call s:OnBufWritePre()

    autocmd BufNewFile,BufRead *.[hCH],*.cc,*.hh,*.[ch]xx setfiletype cpp
    autocmd BufNewFile,BufRead *.bzl setfiletype bazel
    autocmd BufNewFile,BufRead *.proto setfiletype proto
    autocmd BufNewFile,BufRead BUILD setfiletype bazel
    autocmd BufNewFile,BufRead CMakeLists.txt,*.cmake setfiletype cmake
    autocmd BufNewFile,BufRead COMMIT_EDITMSG setfiletype commit_editmsg
augroup END

function! s:OnBufWritePre()
    if &filetype=='python'
        call jakalope#utilities#format('yapf')
    elseif &filetype=='c' || &filetype=='cpp' || &filetype=='proto'
        call jakalope#utilities#format('clang_format')
    elseif expand('%:t')=='BUILD' && g:uname == "Linux"
        call jakalope#utilities#format('buildifier')
    elseif &filetype=='bash' || &filetype=='sh'
        call jakalope#utilities#format('beautify_bash.py -')
    endif
endfunction

if isdirectory("bazel-genfiles")
    set path+=bazel-genfiles
endif
