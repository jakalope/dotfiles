augroup sh_group
    autocmd!
    set makeprg=shellcheck\ -f\ gcc\ %
    au BufWritePost * :silent make | redraw!
augroup END
