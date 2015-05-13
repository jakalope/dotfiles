if exists('g:split_to_tab_loaded')
    finish
endif

let g:split_to_tab_loaded = 1

" get the directory this script resides in
" http://stackoverflow.com/questions/4976776/how-to-get-path-to-the-current-vimscript-being-executed
let s:path = fnamemodify(resolve(expand('<sfile>:p')), ':h')

" Enable extended key mappings in vim under screen/tmux.
" See http://stackoverflow.com/questions/15445481/mapping-arrow-keys-when-running-tmux
exe "silent !tmux source-file ".s:path."/vim-support.conf"
if &term =~ '^screen' && exists('$TMUX')
    set mouse+=a
    " tmux knows the extended mouse mode
    set ttymouse=xterm2
    " tmux will send xterm-style keys when xterm-keys is on
"    execute "set <xUp>=\e[1;*A"
"    execute "set <xDown>=\e[1;*B"
"    execute "set <xRight>=\e[1;*C"
"    execute "set <xLeft>=\e[1;*D"
"    execute "set <xHome>=\e[1;*H"
"    execute "set <xEnd>=\e[1;*F"
    execute "set <Insert>=\e[2;*~"
    execute "set <Delete>=\e[3;*~"
    execute "set <PageUp>=\e[5;*~"
    execute "set <PageDown>=\e[6;*~"
    execute "set <xF1>=\e[1;*P"
    execute "set <xF2>=\e[1;*Q"
    execute "set <xF3>=\e[1;*R"
    execute "set <xF4>=\e[1;*S"
    execute "set <F5>=\e[15;*~"
    execute "set <F6>=\e[17;*~"
    execute "set <F7>=\e[18;*~"
    execute "set <F8>=\e[19;*~"
    execute "set <F9>=\e[20;*~"
    execute "set <F10>=\e[21;*~"
    execute "set <F11>=\e[23;*~"
    execute "set <F12>=\e[24;*~"
endif

" Create/load a xolox session
"let g:vim_server = $VIMSERVER
"breakadd here
"if !empty(g:vim_server)
"    echo "~/.vim/sessions/".g:vim_server
"    echo filereadable("~/.vim/sessions/".g:vim_server)
"    echo !filereadable("~/.vim/sessions/".g:vim_server)
"    if !filereadable("~/.vim/sessions/".g:vim_server)
"        SaveSession $VIMSERVER
"    endif
"endif

function! SplitsToTabs()
    wincmd l
    exe "normal \<c-w>T"
    for i in range(tabpagenr('$'))
        tabnext
        wincmd l
        exe "normal \<c-w>T"
    endfor
endfunction

function! TabsToSplits()
    if tabpagenr('$') == 1 && winnr('$') == 1
        return
    endif

    tabnext 1
    for i in range(tabpagenr('$'))
        exe "tabnext ".(i+2)
        let l:cur_buf = bufnr('%') "get buffer
        exe "tabnext ".(i+1)
        vsp
        wincmd l
        exe "b".l:cur_buf
        exe "tabnext ".(i+2)
        close!
    endfor
endfunction

function! ToggleCollapse()
    if exists('g:collapsed')
        unlet g:collapsed
        exe "silent !tmux resize-pane -t ".v:servername." -Z"
        exe "silent !tmux source-file ".s:path."/enable_pane_switching.conf"
        call SplitsToTabs()
    else
        let g:collapsed = 1
        exe "silent !tmux resize-pane -t ".v:servername." -Z"
        exe "silent !tmux source-file ".s:path."/disable_pane_switching.conf"
        call TabsToSplits()
    endif
endfunction

function! ToggleCollapsedState()
    if exists('g:collapsed')
        unlet g:collapsed
    else
        let g:collapsed = 1
    endif
endfunction

function! RunInPane(pane, ...)
    if exists('g:collapsed')
        call ToggleCollapse()
    endif
    exe "silent !tmux select-pane -t ".a:pane
    let l:command = ''
    for i in a:000
        let l:command = l:command.' '.i
    endfor
    exe "silent !tmux send-keys '".l:command."' C-m"
    silent !tmux select-pane -t 0
    redraw!
    redrawstatus!
endfunction

nnoremap ;l :call ToggleCollapse()<CR>
nnoremap ;p :call RunInPane('1', 'cd '.system('printf "%s" "$(pwd)"').'/'.system('dirname '.shellescape(expand('%'))))<CR>
nnoremap ;m :w<CR>:call RunInPane('1', 'q')<CR>:call RunInPane('1', 'make_this_package '.expand('%'))<CR>
nnoremap ;n :w<CR>:call RunInPane('1', 'make_this_package_abridged '.expand('%'))<CR>
nnoremap ;c :call RunInPane('1', 'gen_clang_complete.bash '.expand('%'))<CR>
nnoremap ;r :call RunInPane('1', 'rosmake perception')<CR>
nnoremap ;v :call RunInPane('2', 'visualize_perception.sh')<CR>

" TODO: see if mapping <c-a><c-a> in vim and unmapping it in tmux works -- use when in collapsed state
" TODO: remember what file we were editing and navigate back there after ;l
" TODO: handle CTRL-F7, CTRL-F8 for toggling collapse

" TODO: use -L after all tmux commands to specifiy which ros-edit to apply change to
