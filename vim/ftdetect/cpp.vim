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
 
        " Move to the beginning of the next text block.
        nnoremap <buffer> ]] :call search('\n\n\S', 'e')<CR>
        onoremap <buffer> ]] :call search('\n\n\S', 'e')<CR>
        nnoremap <buffer> [[ :call search('\n\n\S', 'be')<CR>
        onoremap <buffer> [[ :call search('\n\n\S', 'be')<CR>
    endfunction

    autocmd FileType cpp call DoCpp()
augroup END
