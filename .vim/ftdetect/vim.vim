augroup vim_group
    autocmd!

    function! DoVim()
        setl cc=80
        setl shiftwidth=4
        setl tabstop=4
        setl softtabstop=4
        setl autoindent
        setl smartindent
    endfunction

    autocmd FileType vim call DoVim()
augroup END
