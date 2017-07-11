" Reset all options and mappings.
set all&
mapclear | mapclear <buffer> | mapclear! | mapclear! <buffer>

"""""""""" Script opts
let g:util_min_split_cols = 83

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

" CtrlP (just for buffer search)
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'

nnoremap <Leader>b :CtrlPBuffer<CR>

" CommandT (for file search)
let g:CommandTMaxFiles=1000000
let g:CommandTFileScanner="git"
let g:CommandTGitScanSubmodules=1

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

" Reload scripts that were unmapped at the top of this file.
unlet! g:loaded_smartword
ReloadScript vim/bundle/vim-smartword/plugin/smartword.vim

unlet! g:command_t_loaded
ReloadScript vim/bundle/command-t/plugin/command-t.vim

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

function! s:Maker()
    return system("> /dev/null make_this_package ".expand('%')." 2>&1 \| grep ".
                  \"-E \' error:\'")
endfunction
command! Make cexpr s:Maker()

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

function! g:Sequence(prefix, list)
    let l:out = []
    for item in a:list
        let l:out += [a:prefix.".".item]
    endfor
    return l:out
endfunction

function! g:GitLs(fn)
    let l:git_ls_command = "git ls-files --full-name ".a:fn
    exec "let l:companion_file = system(\"".l:git_ls_command."\")"
    return l:companion_file
endfunction

" Open companion file, if it exists (e.g. test.h -> test.cpp)
function! g:Companion()
    let l:fn_ext = expand("%:e")
    let l:fn_root = expand("%:r")
    let l:c_ext = ["cpp", "c", "cc", "cx", "cxx"]
    let l:h_ext = ["h", "hpp", "hxx", "hh"]
    if index(l:c_ext, l:fn_ext) != -1
        let l:fns = g:Sequence(l:fn_root, l:h_ext)
        for l:fn in l:fns
            let l:companion_file = g:GitLs(l:fn)
            if l:companion_file != ""
                return l:companion_file
            endif 
        endfor
    elseif index(l:h_ext, l:fn_ext) != -1
        let l:fns = g:Sequence(l:fn_root, l:c_ext)
        for l:fn in l:fns
            echom l:fn
            let l:companion_file = g:GitLs(l:fn)
            echom l:companion_file
            if l:companion_file != ""
                return l:companion_file
            endif 
        endfor
    endif
    return expand("%")
endfunction

nnoremap ze :execute 'edit '.g:Companion()<CR>
nnoremap zt :execute 'tabnew '.g:Companion()<CR>
nnoremap zv :execute 'vsplit '.g:Companion()<CR>
nnoremap zs :execute 'split '.g:Companion()<CR>
nnoremap zn :execute '!vims <C-R><C-A>'<CR>

" Cycle through tabs and buffers
nnoremap <F5> :tabp<CR>
nnoremap <F6> :bp<CR>
nnoremap <F7> :bn<CR>
nnoremap <F8> :tabn<CR>

" fast buffer deletion
nnoremap <F9><F9> :Bdelete<CR>

" Map <A-{h,j,k,l}> to <C-w>{h,j,k,l}
nnoremap ˙ <C-w>h
nnoremap ∆ <C-w>j
nnoremap ˚ <C-w>k
nnoremap ¬ <C-w>l

nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

inoremap <A-h> <C-w>h
inoremap <A-j> <C-w>j
inoremap <A-k> <C-w>k
inoremap <A-l> <C-w>l

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Reload all windows, tabs, buffers, etc.
command! Reload :call s:Reload()
function! s:Reload()
    setlocal autoread
    checktime
    set autoread<
endfunction

" Detect filetype in each tab
command! Detect :tabdo exec 'filetype detect'
command! Wcd cd ${MY_WORKSPACE_DIR}
command! Src exec 'set all&' | exec 'source ~/.vimrc' | Detect

" Remove all non-terminal buffers
function! IsATerm()
    if bufname("%")=~#"term://.*"
        return 1
    endif
    return 0
endfunction

function! BdeleteNonTerm()
    if !IsATerm()
        Bdelete
    endif
endfunction

function! ClearNonTerminals()
    bufdo call BdeleteNonTerm()
    enew
    stopinsert
endfunction
command! Clear :call ClearNonTerminals()

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

    tnoremap ˙ <C-\><C-n><C-w>h
    tnoremap ∆ <C-\><C-n><C-w>j
    tnoremap ˚ <C-\><C-n><C-w>k
    tnoremap ¬ <C-\><C-n><C-w>l

    tnoremap <C-h> <C-\><C-n><C-w>h
    tnoremap <C-j> <C-\><C-n><C-w>j
    tnoremap <C-k> <C-\><C-n><C-w>k
    tnoremap <C-l> <C-\><C-n><C-w>l

	tnoremap <C-u> <C-\><C-n><C-u>
	tnoremap <C-d> <C-\><C-n><C-d>

    tnoremap <C-e> <C-\><C-n>:enew<CR>

    highlight TermCursor ctermfg=red guifg=red

    augroup terminal
		autocmd!
        autocmd TermOpen * setlocal nospell
        autocmd BufWinEnter,WinEnter term://* startinsert
    augroup END

    autocmd VimEnter * nested vsplit term://bash
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

function! s:Format(formatter)
    let view = winsaveview()
    exec 'silent! undojoin | keepmarks keepjumps %!'.a:formatter
    call winrestview(view)
endfunction

function! s:OnBufWritePre()
    if &filetype=='python'
        call s:Format('yapf')
    elseif &filetype=='c' || &filetype=='cpp' || &filetype=='proto'
        call s:Format('clang_format')
    elseif expand('%:t')=='BUILD' && g:uname == "Linux\n"
        call s:Format('buildifier')
    endif
endfunction

