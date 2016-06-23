if exists("did_load_filetypes")
    finish
endif

augroup filetypedetect
    autocmd!
    autocmd BufNewFile,BufRead *.vim silent! call SetVimOptions()
    autocmd BufNewFile,BufRead *.tex silent! call SetTexOptions()
    autocmd BufNewFile,BufRead *.xml silent! call SetXmlOptions()
    autocmd BufNewFile,BufRead *.html silent! call SetHtmlOptions()
    autocmd BufNewFile,BufRead *.launch silent! call SetXmlOptions()

    autocmd BufNewFile,BufRead *.sh silent! call SetBashOptions()
    autocmd BufNewFile,BufRead *.bash silent! call SetBashOptions()
    autocmd BufNewFile,BufRead *.yaml silent! call SetPythonOptions()
    autocmd BufNewFile,BufRead *.py silent! call SetPythonOptions()

    autocmd BufNewFile,BufRead *.c silent! call SetCPPOptions()
    autocmd BufNewFile,BufRead *.cc silent! call SetCPPOptions()
    autocmd BufNewFile,BufRead *.cx silent! call SetCPPOptions()
    autocmd BufNewFile,BufRead *.cpp silent! call SetCPPOptions()
    autocmd BufNewFile,BufRead *.h silent! call SetCPPOptions()
    autocmd BufNewFile,BufRead *.hpp silent! call SetCPPOptions()

    autocmd BufNewFile,BufRead CMakeLists.txt silent! call SetCMakeOptions()
    autocmd BufNewFile,BufRead *.cmake silent! call SetCMakeOptions()

    autocmd BufNewFile,BufRead BUILD silent! call SetBazelOptions()
    autocmd BufNewFile,BufRead *.bzl silent! call SetBazelOptions()
augroup END

function! SetHtmlOptions()
    setl filetype=html
    setl cc=80
    setl shiftwidth=4
    setl tabstop=4
    setl softtabstop=4
    setl autoindent
    setl smartindent
endfunction

function! SetXmlOptions()
    setl filetype=xml
    setl cc=80
    setl shiftwidth=4
    setl tabstop=4
    setl softtabstop=4
    setl autoindent
    setl smartindent
endfunction

function! SetVimOptions()
    setl filetype=vim
    setl cc=80
    setl shiftwidth=4
    setl tabstop=4
    setl softtabstop=4
    setl autoindent
    setl smartindent
endfunction

function! SetTexOptions()
    setl filetype=tex
    setl cc=120
    setl shiftwidth=2
    setl tabstop=2
    setl softtabstop=2
    setl autoindent
    setl smartindent
    command! Build :!pdflatex % && evince '%:r'.pdf
endfunction

function! SetPythonOptions()
    setl filetype=python
    setl cc=80
    setl shiftwidth=4
    setl tabstop=4
    setl softtabstop=4
    setl autoindent
    setl smartindent
endfunction

function! SetBashOptions()
    setl filetype=sh
    setl cc=80
    setl shiftwidth=4
    setl tabstop=4
    setl softtabstop=4
    setl autoindent
    setl smartindent
endfunction

function! SetBazelOptions()
    setl filetype=python
    setl cc=80
    setl shiftwidth=2
    setl tabstop=2
    setl softtabstop=2
    setl autoindent
    setl smartindent
endfunction

function! SetCMakeOptions()
    setl filetype=cmake
    setl commentstring=#\ %s
    setl cc=100
    setl shiftwidth=2
    setl tabstop=2
    setl softtabstop=2
    setl autoindent
    setl smartindent
endfunction

function! SetCPPOptions()
    setl filetype=cpp
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

