if exists("did_load_filetypes")
    finish
endif

augroup filetypedetect
    autocmd!
    autocmd BufNewFile,BufRead *.vim call SetVimOptions()
    autocmd BufNewFile,BufRead *.tex call SetTexOptions()
    autocmd BufNewFile,BufRead *.xml call SetXmlOptions()
    autocmd BufNewFile,BufRead *.html call SetHtmlOptions()
    autocmd BufNewFile,BufRead *.launch call SetXmlOptions()

    autocmd BufNewFile,BufRead *.sh call SetBashOptions()
    autocmd BufNewFile,BufRead *.bash call SetBashOptions()
    autocmd BufNewFile,BufRead *.yaml call SetPythonOptions()
    autocmd BufNewFile,BufRead *.python call SetPythonOptions()

    autocmd BufNewFile,BufRead *.c call SetCPPOptions()
    autocmd BufNewFile,BufRead *.cc call SetCPPOptions()
    autocmd BufNewFile,BufRead *.cx call SetCPPOptions()
    autocmd BufNewFile,BufRead *.cpp call SetCPPOptions()
    autocmd BufNewFile,BufRead *.h call SetCPPOptions()
    autocmd BufNewFile,BufRead *.hpp call SetCPPOptions()

    autocmd BufNewFile,BufRead CMakeLists.txt call SetCMakeOptions()
    autocmd BufNewFile,BufRead *.cmake call SetCMakeOptions()
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
endfunction

