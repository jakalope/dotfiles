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
    let g:copy='xsel -i'
endif

" function! SaveRegContents()
"     let l:contents = ""
"     for l:line in v:event['regcontents']
"         let l:contents = l:contents."\n".l:line
"     endfor
"     exec "!echo '".l:contents."' | ".g:copy
" endfunction

augroup Copy
    autocmd!
"     autocmd TextYankPost * call SaveRegContents()
"     " autocmd TextYankPost * exec "!echo '".v:event['regcontents']."' | ".g:copy
augroup END
    

"""""""""" Plugin opts

" Utilities
let g:util_min_split_cols = 83
let g:util_split_with_terminal = 1

nnoremap ze :execute 'edit '.jakalope#utilities#companion()<CR>
nnoremap zt :execute 'tabnew '.jakalope#utilities#companion()<CR>
nnoremap zv :execute 'vsplit '.jakalope#utilities#companion()<CR>
nnoremap zs :execute 'split '.jakalope#utilities#companion()<CR>

" CtrlP (for buffer search and CmdT backup option)
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'

nnoremap <Leader>b :CtrlPBuffer<CR>
nnoremap <Leader>p :CtrlP<CR>

" CommandT (for file search)
let g:CommandTMaxFiles=1000000
let g:CommandTFileScanner="git"
let g:CommandTGitScanSubmodules=1

nnoremap <Leader>t :CommandTFlush<CR>:CommandT<CR>
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
let g:ycm_server_python_interpreter='/usr/bin/python'
let g:ycm_keep_logfiles = 1

let s:proposed_ycm_conf = 'scripts/editors/vim/ycm_extra_conf.py'
if filereadable(s:proposed_ycm_conf)
    let g:ycm_global_ycm_extra_conf = s:proposed_ycm_conf
else
    let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
endif

" nnoremap <C-\> :YcmCompleter GoTo<CR>
" nnoremap <C-g> :YcmCompleter FixIt<CR>
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
map <Leader>w <Plug>(easymotion-bd-w)
map <Leader>s <Plug>(easymotion-s)

" MiniYank
let g:miniyank_filename = $HOME."/.miniyank.mpack"

"""""""""" Vim-Plug

call plug#begin('~/.vim/plugged')

" Plug 'PeterRincker/vim-argumentative'

if has('nvim')
    Plug 'bfredl/nvim-miniyank'
else
    Plug 'Valloric/YouCompleteMe', { 'do':
                \ './install.py --clang-completer --racer-completer' }
    Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
endif

Plug 'Peaches491/vim-glog-syntax'
Plug 'easymotion/vim-easymotion'
Plug 'jakalope/vim-utilities'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'kana/vim-operator-user'
Plug 'kana/vim-smartword'
Plug 'kien/ctrlp.vim'
Plug 'moll/vim-bbye'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'rust-lang/rust.vim'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'wincent/command-t', { 'do':
            \ 'cd ruby/command-t/ext/command-t && ruby extconf.rb && make' }
Plug 'xolox/vim-misc'
Plug 'xolox/vim-reload'

call plug#end()

" Clear and reset options and scripts, source vimrc, reload scripts
command! Src call ClearAll() | source ~/.vimrc  | call VimRCSource()
function! ClearAll()
    " Reset all options and mappings.
    set all&
    mapclear | mapclear <buffer> | mapclear! | mapclear! <buffer>

    " Reload scripts that were unmapped at the top of this file.
    unlet! g:vim_utilities_loaded
    unlet! g:loaded_smartword
    unlet! g:command_t_loaded
    unlet! g:loaded_abolish
    unlet! g:loaded_commentary
    unlet! g:loaded_syntastic_rust_filetype
    unlet! g:EasyMotion_loaded
endfunction
function! VimRCSource()
    ReloadScript ~/.vim/plugged/vim-utilities/plugin/vim-utilities.vim
    ReloadScript ~/.vim/plugged/vim-smartword/plugin/smartword.vim
    ReloadScript ~/.vim/plugged/command-t/plugin/command-t.vim
    ReloadScript ~/.vim/plugged/vim-abolish/plugin/abolish.vim
    ReloadScript ~/.vim/plugged/vim-commentary/plugin/commentary.vim
    ReloadScript ~/.vim/plugged/rust.vim/plugin/rust.vim
    ReloadScript ~/.vim/plugged/vim-easymotion/plugin/EasyMotion.vim

    " Re-detect filetypes.
    " TODO With a rust filetype loaded, this will cause an error.
    Detect
endfunction

filetype plugin indent on
syntax on

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
if has('fastwincmd')
    set fastwincmd
endif
set fileencoding=utf-8
set history=50
set nobackup
set noswapfile
set incsearch
set laststatus=2 " Always display status line
set nofoldenable
set nohlsearch
set number
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
set viewoptions=
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
nnoremap zn :call OpenToLineInPrevious('<C-R><C-A>')<CR>
function! OpenToLineInPrevious(line)
    let cur_file=expand('<cfile>')
    let split_list=split(a:line, ':')
    wincmd p
    exec 'edit '.cur_file
    if len(split_list) > 1
        let cur_line=split_list[1]
        call cursor(cur_line, 0)
    endif
endfunction

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

nnoremap <C-q> :call RotateOthers()<CR>
function! RotateOthers()
    " Rotate all windows left except mine.
    wincmd R
    wincmd x
    wincmd l
endfunction

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
hi SpellRare ctermfg=blue ctermbg=NONE

" Insert minuses between EOL and the 80'th column.
nnoremap -- $a <Esc>:exec 'normal! '.(78 - getcurpos()[2]).'a-'<CR>
nnoremap -= i <Esc>:exec 'normal! '.(79 - col('$')).'i-'<CR>

" Toggle numbering
nnoremap ;n :set invrnu<CR>

function! SetTerminalOps()
    setlocal nospell
    setlocal nonumber
    setlocal norelativenumber
endfunction

if has('nvim') || has('terminal')
    tnoremap <F10> <C-\><C-n>?Reading 'startup'<CR>/error:<CR>0
    nnoremap <F10> <C-\><C-n>?Reading 'startup'<CR>/error:<CR>0
endif

if has('nvim')
    set notimeout " https://github.com/neovim/neovim/issues/6166
    let g:terminal_scrollback_buffer_size = 100000
    let g:util_workspace_dir = $MY_WORKSPACE_DIR

	tnoremap <F5> <C-\><C-n>:tabp<CR>
	tnoremap <F6> <C-\><C-n>:bp<CR>
	tnoremap <F7> <C-\><C-n>:bn<CR>
	tnoremap <F8> <C-\><C-n>:tabn<CR>
	tnoremap <F9><F9> <C-\><C-n>:Bdelete<CR>

    tnoremap <C-\> <C-\><C-n>

    tnoremap <C-h> <C-\><C-n><C-w>h
    tnoremap <C-j> <C-\><C-n><C-w>j
    tnoremap <C-k> <C-\><C-n><C-w>k
    tnoremap <C-l> <C-\><C-n><C-w>l

	tnoremap <C-u> <C-\><C-n><C-u>
	tnoremap <C-d> <C-\><C-n><C-d>

    highlight TermCursor ctermfg=red guifg=red

    augroup terminal
		autocmd!
        " autocmd BufWinEnter,WinEnter term://* startinsert
       
        " Don't spellcheck our terminal buffers :-P
        autocmd BufWinEnter,WinEnter term://* call SetTerminalOps()
    augroup END
elseif has('terminal')
    augroup terminal
        " Don't spellcheck our terminal buffers :-P
        au BufWinEnter * if &buftype == 'terminal' | call SetTerminalOps() | endif
    augroup END
    if v:servername == ""
        " When vim is started without a servername, set the
        " servername to the " basename of the current working
        " directory.
        call remote_startserver(fnamemodify(getcwd(), ':t'))
    endif

	tnoremap <F5> <C-w>:tabp<CR>
	tnoremap <F6> <C-w>:bp<CR>
	tnoremap <F7> <C-w>:bn<CR>
	tnoremap <F8> <C-w>:tabn<CR>
	tnoremap <F9><F9> <C-w>:Bdelete<CR>

    tnoremap <C-\> <C-\><C-n>:call SetTerminalOps()<CR>

    tnoremap <C-h> <C-w>h
    tnoremap <C-j> <C-w>j
    tnoremap <C-k> <C-w>k
    tnoremap <C-l> <C-w>l

	tnoremap <C-u> <C-\><C-n><C-u>
	tnoremap <C-d> <C-\><C-n><C-d>
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

let g:enable_auto_format=1
command! AutoFormatToggle call s:AutoFormatToggle()
function! s:AutoFormatToggle()
    if exists("g:enable_auto_format") && g:enable_auto_format
        let g:enable_auto_format=0
    else
        let g:enable_auto_format=1
    endif
endfunction

function! s:OnBufWritePre()
    if g:enable_auto_format==1
        if &filetype=='python'
            call jakalope#utilities#format('yapf')
        elseif &filetype=='c' || &filetype=='cpp' || &filetype=='proto'
            call jakalope#utilities#format('clang_format')
        elseif expand('%:t')=='BUILD' && g:uname == "Linux"
            call jakalope#utilities#format('buildifier')
        elseif &filetype=='bash' || &filetype=='sh'
            call jakalope#utilities#format('beautify_bash.py -')
        endif
    endif
endfunction

if isdirectory("bazel-genfiles")
    set path+=bazel-genfiles
endif
