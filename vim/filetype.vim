if exists("did_load_filetypes")
    finish
endif

augroup filetypedetect
    autocmd!

    autocmd BufNewFile,BufRead *.tex setfiletype tex
    autocmd BufNewFile,BufRead *.launch setfiletype xml
    autocmd BufNewFile,BufRead *.bash setfiletype sh
    autocmd BufNewFile,BufRead *.sdl setfiletype python

    autocmd BufNewFile,BufRead CMakeLists.txt setfiletype cmake
    autocmd BufNewFile,BufRead *.cmake setfiletype cmake

    " Handle all BufWritePre events for specific filetypes.
    " Especially useful for auto-formatting commands.
    autocmd BufWritePre * call OnBufWritePre()
    function! OnBufWritePre()
        if &filetype=='python'
            keepjumps let view = winsaveview()
            keepjumps %!yapf
            keepjumps call winrestview(view)
        elseif &filetype=='c'
            keepjumps let view = winsaveview()
            keepjumps %!clang_format
            keepjumps call winrestview(view)
        elseif &filetype=='cpp'
            keepjumps let view = winsaveview()
            keepjumps %!clang_format
            keepjumps keepjumps call winrestview(view)
        elseif &filetype=='proto'
            keepjumps let view = winsaveview()
            keepjumps %!clang_format
            keepjumps call winrestview(view)
        endif
    endfunction

    autocmd BufNewFile,BufRead CMakeLists.txt silent! call SetCMakeOptions()
    autocmd BufNewFile,BufRead *.cmake silent! call SetCMakeOptions()
    autocmd BufNewFile,BufRead *.md silent! call SetMarkdownOptions()
    autocmd BufNewFile,BufRead COMMIT_EDITMSG silent! call SetCommitOptions()
    autocmd BufNewFile,BufRead *.pbtxt silent! call SetMarkdownOptions()
augroup END

function! SetMarkdownOptions()
    set filetype=markdown
    set cc=80
    set shiftwidth=2
    set tabstop=2
    set softtabstop=2
    set autoindent
    set smartindent
endfunction

function! SetCommitOptions()
    set filetype=markdown
    set cc=70
    set shiftwidth=2
    set tabstop=2
    set softtabstop=2
    set autoindent
    set smartindent
    set spell spelllang=
endfunction

function! SetCMakeOptions()
    set filetype=cmake
    set commentstring=#\ %s
    set cc=100
    set shiftwidth=2
    set tabstop=2
    set softtabstop=2
    set autoindent
    set smartindent
endfunction
