if exists("did_load_filetypes")
    finish
endif

augroup filetypedetect
    autocmd!

    " Handle all BufWritePre events for specific filetypes.
    " Especially useful for auto-formatting commands.
    autocmd BufWritePre * call OnBufWritePre()

    autocmd BufNewFile,BufRead CMakeLists.txt silent! call SetCMakeOptions()
    autocmd BufNewFile,BufRead *.cmake silent! call SetCMakeOptions()
    autocmd BufNewFile,BufRead COMMIT_EDITMSG silent! call SetCommitOptions()
augroup END

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

function! SetCommitOptions()
    setl filetype=markdown
    setl cc=70
    setl shiftwidth=2
    setl tabstop=2
    setl softtabstop=2
    setl autoindent
    setl smartindent
    setl spell spelllang=
endfunction

function! SetCMakeOptions()
    setl filetype=cmake
    setl commentstring=#\ %s
    setl cc=100
    setl shiftwidth=2
    setl tabstop=2
    setl softtabstop=2
    setl autoindent
    setl smartindent
endfunction
