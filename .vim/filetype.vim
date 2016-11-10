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
    autocmd BufNewFile,BufRead *.sdl silent! call SetPythonOptions()

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
    " autocmd BufWrite BUILD silent! !buildifier %
    " autocmd BufWrite *.bzl silent! !buildifier %
    " autocmd BufWrite BUILD silent! we
    " autocmd BufWrite *.bzl silent! we

    autocmd BufNewFile,BufRead *.proto silent! call SetProtoOptions()

    autocmd BufNewFile,BufRead *.pbtxt silent! call SetBashOptions()

    autocmd BufNewFile,BufRead *.md silent! call SetMarkdownOptions()

    autocmd BufNewFile,BufRead COMMIT_EDITMSG silent! call SetCommitOptions()
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
    let g:pymode_python = 'python'
    setl filetype=python
    setl cc=80
    setl shiftwidth=4
    setl tabstop=4
    setl softtabstop=4
    setl autoindent
    setl smartindent
endfunction

function! SetMarkdownOptions()
    setl filetype=markdown
    setl cc=80
    setl shiftwidth=2
    setl tabstop=2
    setl softtabstop=2
    setl autoindent
    setl smartindent
endfunction

function! SetCommitOptions()
    setl filetype=markdown
    setl cc=70
    setl shiftwidth=2
    setl tabstop=2
    setl softtabstop=2
    setl autoindent
    setl smartindent
    setl spell spelllang=
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
    let g:pymode = 0
    setl filetype=python
    setl cc=80
    setl shiftwidth=4
    setl tabstop=4
    setl softtabstop=4
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

function! SetProtoOptions()
    if version < 600
      syntax clear
    elseif exists("b:current_syntax")
      finish
    endif

    syn case match

    syn keyword pbTodo       contained TODO FIXME XXX
    syn cluster pbCommentGrp contains=pbTodo

    syn keyword pbSyntax     syntax import option
    syn keyword pbStructure  package message group oneof
    syn keyword pbRepeat     optional required repeated
    syn keyword pbDefault    default
    syn keyword pbExtend     extend extensions to max reserved
    syn keyword pbRPC        service rpc returns

    syn keyword pbType      int32 int64 uint32 uint64 sint32 sint64
    syn keyword pbType      fixed32 fixed64 sfixed32 sfixed64
    syn keyword pbType      float double bool string bytes
    syn keyword pbTypedef   enum
    syn keyword pbBool      true false

    syn match   pbInt     /-\?\<\d\+\>/
    syn match   pbInt     /\<0[xX]\x+\>/
    syn match   pbFloat   /\<-\?\d*\(\.\d*\)\?/
    syn region  pbComment start="\/\*" end="\*\/" contains=@pbCommentGrp
    syn region  pbComment start="//" skip="\\$" end="$" keepend contains=@pbCommentGrp
    syn region  pbString  start=/"/ skip=/\\./ end=/"/
    syn region  pbString  start=/'/ skip=/\\./ end=/'/

    if version >= 508 || !exists("did_proto_syn_inits")
      if version < 508
        let did_proto_syn_inits = 1
        command -nargs=+ HiLink hi link <args>
      else
        command -nargs=+ HiLink hi def link <args>
      endif

      HiLink pbTodo         Todo

      HiLink pbSyntax       Include
      HiLink pbStructure    Structure
      HiLink pbRepeat       Repeat
      HiLink pbDefault      Keyword
      HiLink pbExtend       Keyword
      HiLink pbRPC          Keyword
      HiLink pbType         Type
      HiLink pbTypedef      Typedef
      HiLink pbBool         Boolean

      HiLink pbInt          Number
      HiLink pbFloat        Float
      HiLink pbComment      Comment
      HiLink pbString       String

      delcommand HiLink
    endif

    let b:current_syntax = "proto"
    setl commentstring=//\ %s
    setl cc=80
    setl shiftwidth=2
    setl tabstop=2
    setl softtabstop=2
    setl autoindent
    setl smartindent
endfunction
