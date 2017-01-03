augroup bazel_group
    autocmd!
    autocmd BufNewFile,BufRead BUILD setfiletype bazel
    autocmd BufNewFile,BufRead *.bzl setfiletype bazel

    function! DoBazel()
        " setl filetype=python
        setl cc=80
        setl shiftwidth=4
        setl tabstop=4
        setl softtabstop=4
        setl autoindent
        setl smartindent
    endfunction

    autocmd FileType bazel call DoBazel()
augroup END
