augroup bazel_group
    autocmd!
    autocmd BufNewFile,BufRead BUILD setfiletype bazel
    autocmd BufNewFile,BufRead *.bzl setfiletype bazel
<<<<<<< HEAD:.vim/ftdetect/bazel.vim
=======

	function! Buildify()
		let view = winsaveview()
		%!buildifier
		call winrestview(view)
	endfunction
>>>>>>> 6f21e3aa1469a8476946d2a043f16ffdd5686bed:vim/ftdetect/bazel.vim

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
    autocmd BufWritePre BUILD call Buildify()
augroup END
