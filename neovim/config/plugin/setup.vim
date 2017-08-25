colorscheme ir_black
highlight CursorLine ctermbg=238

" NERDTree Key
nnoremap <leader>n :NERDTreeToggle<CR>

" Neomake
augroup neomake_lint
  autocmd!
  autocmd BufWritePost * Neomake
augroup END

