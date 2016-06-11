if exists("did_load_filetypes")
    finish
endif

augroup filetypedetect
    autocmd!
    autocmd BufNewFile,BufRead,BufEnter *.vim silent! call SetVimOptions()
    autocmd BufNewFile,BufRead,BufEnter *.tex silent! call SetTexOptions()
    autocmd BufNewFile,BufRead,BufEnter *.xml silent! call SetXmlOptions()
    autocmd BufNewFile,BufRead,BufEnter *.html silent! call SetHtmlOptions()
    autocmd BufNewFile,BufRead,BufEnter *.launch silent! call SetXmlOptions()

    autocmd BufNewFile,BufRead,BufEnter *.sh silent! call SetBashOptions()
    autocmd BufNewFile,BufRead,BufEnter *.bash silent! call SetBashOptions()
    autocmd BufNewFile,BufRead,BufEnter *.yaml silent! call SetPythonOptions()
    autocmd BufNewFile,BufRead,BufEnter *.py silent! call SetPythonOptions()

    autocmd BufNewFile,BufRead,BufEnter *.c silent! call SetCPPOptions()
    autocmd BufNewFile,BufRead,BufEnter *.cc silent! call SetCPPOptions()
    autocmd BufNewFile,BufRead,BufEnter *.cx silent! call SetCPPOptions()
    autocmd BufNewFile,BufRead,BufEnter *.cpp silent! call SetCPPOptions()
    autocmd BufNewFile,BufRead,BufEnter *.h silent! call SetCPPOptions()
    autocmd BufNewFile,BufRead,BufEnter *.hpp silent! call SetCPPOptions()

    autocmd BufNewFile,BufRead,BufEnter CMakeLists.txt silent! call SetCMakeOptions()
    autocmd BufNewFile,BufRead,BufEnter *.cmake silent! call SetCMakeOptions()
augroup END

function! SetHtmlOptions()
    set filetype=html
    set cc=80
    set shiftwidth=4
    set tabstop=4
    set softtabstop=4
    set autoindent
    set smartindent
endfunction

function! SetXmlOptions()
    set filetype=xml
    set cc=80
    set shiftwidth=4
    set tabstop=4
    set softtabstop=4
    set autoindent
    set smartindent
endfunction

function! SetVimOptions()
    set filetype=vim
    set cc=80
    set shiftwidth=4
    set tabstop=4
    set softtabstop=4
    set autoindent
    set smartindent
    au bufenter * silent! colorscheme desert
endfunction

function! SetTexOptions()
    set filetype=tex
    set cc=120
    set shiftwidth=2
    set tabstop=2
    set softtabstop=2
    set autoindent
    set smartindent
    command! Build :!pdflatex % && evince '%:r'.pdf
endfunction

function! SetPythonOptions()
    set filetype=python
    set cc=80
    set shiftwidth=4
    set tabstop=4
    set softtabstop=4
    set autoindent
    set smartindent
endfunction

function! SetBashOptions()
    set filetype=sh
    set cc=80
    set shiftwidth=4
    set tabstop=4
    set softtabstop=4
    set autoindent
    set smartindent
    au bufenter * silent! colorscheme desert
endfunction

function! SetCMakeOptions()
    set filetype=cmake
    setlocal commentstring=#\ %s
    set cc=100
    set shiftwidth=2
    set tabstop=2
    set softtabstop=2
    set autoindent
    set smartindent
endfunction

function! SetCPPOptions()
    set filetype=cpp
    setlocal commentstring=//\ %s
    set cc=80
    set shiftwidth=2
    set tabstop=2
    set softtabstop=2
    set autoindent
    set smartindent
    set cindent
    command! Build :make
    ClangFormatAutoEnable
    colorscheme slate
endfunction

