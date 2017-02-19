augroup bazel_group
    autocmd!
    autocmd BufNewFile,BufRead BUILD setfiletype bazel
    autocmd BufNewFile,BufRead *.bzl setfiletype bazel

    function! OnBazelBufWritePre()
        let view = winsaveview()
        %!buildifier
        call winrestview(view)
    endfunction

    function! DoBazel()
        setl cc=80
        setl shiftwidth=4
        setl tabstop=4
        setl softtabstop=4
        setl autoindent
        setl smartindent
    endfunction

    autocmd BufWritePre BUILD call OnBazelBufWritePre()
    autocmd FileType bazel call DoBazel()
augroup END
