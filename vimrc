"""""""""" Script opts
let g:util_min_split_cols = 83

let g:python_host_prog="/usr/bin/python"
let g:python3_host_prog="/usr/local/bin/python3"
if !filereadable(g:python3_host_prog)
	let g:python3_host_prog="/usr/bin/python3"
endif

" CtrlP
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'

nnoremap <Leader>b :CtrlPBuffer<CR>


" CommandT
let g:CommandTMaxFiles=1000000
let g:CommandTFileScanner="git"
let g:CommandTGitScanSubmodules=1

" Syntastic
let g:syntastic_java_checkers=['javac']
let g:syntastic_java_javac_config_file_enabled = 1

" YouCompleteMe
" let g:ycm_register_as_syntastic_checker = 0
set completeopt-=preview
let g:ycm_always_populate_location_list = 0
let g:ycm_open_loclist_on_ycm_diags = 0
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_key_invoke_completion = '<C-space>'
let g:ycm_collect_identifiers_from_tags_files = 0
let g:ycm_confirm_extra_conf = 0
let g:ycm_filepath_completion_use_working_dir = 1
let g:ycm_auto_trigger = 0
let g:ycm_filetype_specific_completion_to_disable = {
    \ 'gitcommit': 1,
    \}

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

" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 0

" UltiSnips
" Trigger configuration. Do not use <tab> if you use YCM
" let g:UltiSnipsExpandTrigger="<C-space>"
" let g:UltiSnipsJumpForwardTrigger="<c-b>"
" let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" let g:UltiSnipsSnippetsDir="~/.vim/ultisnips"

" Smartword
map <SPACE>  <Plug>(smartword-w)
map <BackSpace>  <Plug>(smartword-b)
map <S-SPACE>  W
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
" map ;l <Plug>(easymotion-prefix)

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

" Plugin 'drmikehenry/vim-fontsize'
Plugin 'easymotion/vim-easymotion'
Plugin 'kana/vim-operator-user'
Plugin 'kana/vim-smartword'
Plugin 'octol/vim-cpp-enhanced-highlight'
" Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-fugitive'
Plugin 'Valloric/YouCompleteMe'
" Plugin 'vim-airline/vim-airline'
" Plugin 'vim-scripts/restore_view.vim'
" Plugin 'SirVer/ultisnips'
" Plugin 'xolox/vim-easytags'
" Plugin 'xolox/vim-misc'
" Plugin 'PeterRincker/vim-argumentative'
Plugin 'moll/vim-bbye'
Plugin 'jakalope/vim-utilities'
Plugin 'wincent/command-t'
Plugin 'kien/ctrlp.vim'

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
set incsearch
set laststatus=2 " Always display the status line, even if only one window is displayed
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
nnoremap _b :exe "silent !echo \"b $(pwd)/".expand("%").":".
        \line(".")."\" \| xsel --clipboard --input"<CR>:redraw!<CR>

" yank name of current file to register 0 and to system clipboard
nnoremap _y :let @"=@%<CR>:let @+=@%<CR>

"This breaks undo at each line break.  It also expands abbreviations before
"this.
inoremap <CR> <C-]><C-G>u<CR>

" I often hit tab instead of <Capslock> (which I have hard remapped to <Esc>.
inoremap <Tab>:w<CR> <Esc>:w<CR>

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

" Cursor to yellow on insert mode
" Blue on command/other mode
" Note the use of hex codes (ie 3971ED)
if exists('$TMUX')
    let &t_EI = "\<Esc>Ptmux;\<Esc>\033]Pl3971ED\033\\"
    let &t_SI = "\<Esc>Ptmux;\<Esc>\033]PlFBA922\033\\"
    silent !echo -ne "\<Esc>Ptmux;\<Esc>\033]Pl3971ED\033\\"
    autocmd VimLeave * silent !echo -ne "\<Esc>Ptmux;\<Esc>\033]Pl3971ED\033\\"

    set t_8f=^[[38;2;%lu;%lu;%lum  " Needed in tmux
    set t_8b=^[[48;2;%lu;%lu;%lum  " Ditto
endif

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
command! Src set all& | source ~/.vimrc

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
colorscheme peachpuff
hi SpellBad ctermfg=red ctermbg=NONE
hi SpellCap ctermfg=green ctermbg=NONE

" Toggle numbering
function! NumberToggle()
  if(&relativenumber == 1)
    set nornu
  else
    set rnu
  endif
endfunc
nnoremap ;n :call NumberToggle()<cr>

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
    autocmd BufWritePre * call OnBufWritePre()
    autocmd BufWritePre BUILD call OnBufWritePre()

    autocmd BufNewFile,BufRead CMakeLists.txt,*.cmake setfiletype cmake
    autocmd BufNewFile,BufRead COMMIT_EDITMSG setfiletype commit_editmsg
    autocmd BufNewFile,BufRead *.[hCH],*.cc,*.hh,*.[ch]xx setfiletype cpp
    autocmd BufNewFile,BufRead BUILD setfiletype bazel
    autocmd BufNewFile,BufRead *.bzl setfiletype bazel
    autocmd BufNewFile,BufRead *.proto setfiletype proto
augroup END

function! OnBuildWritePre()
    let view = winsaveview()
    silent! undojoin | keepmarks keepjumps %!buildifier
    call winrestview(view)
endfunction

function! OnBufWritePre()
    if &filetype=='python'
        let view = winsaveview()
        silent! undojoin | keepmarks keepjumps %!yapf
        call winrestview(view)
    elseif &filetype=='c' || &filetype=='cpp' || &filetype=='proto'
        let view = winsaveview()
        silent! undojoin | keepmarks keepjumps %!clang_format
        call winrestview(view)
    endif
endfunction
