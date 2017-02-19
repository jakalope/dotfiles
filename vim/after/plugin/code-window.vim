"""""""""""""" code-window
autocmd VimLeavePre * call s:CleanupCwdFile()
function! s:CleanupCwdFile()
    if exists("v:servername") && !empty(v:servername)
       exec "!rm ~/".v:servername 
    endif
endfunction

