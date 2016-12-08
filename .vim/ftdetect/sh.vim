augroup sh_group
    autocmd!

    function! DoSh()
        " setl makeprg=shellcheck\ -e\ 2016\ -f\ gcc\ %
        setl cc=80
        setl shiftwidth=4
        setl tabstop=4
        setl softtabstop=4
        setl autoindent
        setl smartindent
    endfunction

    autocmd FileType sh call DoSh()
augroup END
