colorscheme ir_black
highlight CursorLine ctermbg=238
highlight LineNr ctermbg=none

let g:airline_theme='behelit'

" NERDTree Key
nnoremap <leader>n :NERDTreeToggle<CR>

" Neomake
augroup neomake_lint
  autocmd!
  autocmd BufWritePost * Neomake
augroup END
" Neomake + Fugitive Gpush and Gfetch
" command! -bang -nargs=* -complete=file Make Neomake! <args>

