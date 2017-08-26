colorscheme ir_black
highlight CursorLine ctermbg=238

let g:airline_theme='behelit'

" NERDTree Key
nnoremap <leader>n :NERDTreeToggle<CR>

" Neomake
augroup neomake_lint
  autocmd!
  autocmd BufWritePost * Neomake
augroup END

