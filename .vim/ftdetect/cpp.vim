augroup cpp_group
    autocmd!
    autocmd BufNewFile,BufRead *.[hCH],*.cc,*.hh,*.[ch]xx setfiletype cpp

    function! DoCpp()
        setl commentstring=//\ %s
        setl cc=80
        setl shiftwidth=2
        setl tabstop=2
        setl softtabstop=2
        setl autoindent
        setl smartindent
        setl cindent
        command! Build :make
        ClangFormatAutoEnable
    endfunction

    autocmd FileType cpp call DoCpp()
augroup END
