augroup html_group
    autocmd!

    function! DoHtml()
    setl cc=80
    setl shiftwidth=4
    setl tabstop=4
    setl softtabstop=4
    setl autoindent
    setl smartindent
    endfunction

    autocmd FileType html call DoHtml()
augroup END
