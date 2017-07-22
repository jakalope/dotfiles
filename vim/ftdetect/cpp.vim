" Move to the beginning of the next text block.
nnoremap <buffer> ]] :call search('\n\n\S', 'e')<CR>
onoremap <buffer> ]] :call search('\n\n\S', 'e')<CR>
nnoremap <buffer> [[ :call search('\n\n\S', 'be')<CR>
onoremap <buffer> [[ :call search('\n\n\S', 'be')<CR>
