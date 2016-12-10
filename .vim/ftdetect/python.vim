augroup python_group
    autocmd!
    autocmd BufNewFile,BufRead *.py setfiletype python

    function! DoPython()
        setl cc=80
        setl shiftwidth=4
        setl tabstop=4
        setl softtabstop=4
        setl autoindent
        setl smartindent
    endfunction

    autocmd FileType python call DoPython()
augroup END
