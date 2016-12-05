augroup xml_group
    autocmd!
    autocmd BufNewFile,BufRead *.launch setfiletype xml

    function! DoXml()
    setl cc=80
    setl shiftwidth=4
    setl tabstop=4
    setl softtabstop=4
    setl autoindent
    setl smartindent
    endfunction

    autocmd FileType xml call DoXml()
augroup END
