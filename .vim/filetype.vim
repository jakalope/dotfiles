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
			let view = winsaveview()
            %!yapf
			call winrestview(view)
        endif
        if &filetype=='cpp'
			let view = winsaveview()
            %!clang-format-3.6
			call winrestview(view)
        endif
    endfunction

    autocmd BufNewFile,BufRead *.sh silent! call SetBashOptions()
    autocmd BufNewFile,BufRead *.bash silent! call SetBashOptions()

    autocmd BufNewFile,BufRead CMakeLists.txt silent! call SetCMakeOptions()
    autocmd BufNewFile,BufRead *.cmake silent! call SetCMakeOptions()

    autocmd BufNewFile,BufRead *.pbtxt silent! call SetBashOptions()
    autocmd BufNewFile,BufRead *.md silent! call SetMarkdownOptions()
    autocmd BufNewFile,BufRead COMMIT_EDITMSG silent! call SetCommitOptions()
augroup END

function! SetMarkdownOptions()
    setl filetype=markdown
    setl cc=80
    setl shiftwidth=2
    setl tabstop=2
    setl softtabstop=2
    setl autoindent
    setl smartindent
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

function! SetBashOptions()
    setl filetype=sh
    setl cc=80
    setl shiftwidth=4
    setl tabstop=4
    setl softtabstop=4
    setl autoindent
    setl smartindent
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
