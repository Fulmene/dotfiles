colorscheme wal
highlight CursorLine ctermbg=5

" NERDTree Key
nnoremap <leader>n :NERDTreeToggle<CR>

" Neomake
augroup neomake_lint
    autocmd!
    autocmd BufWritePost * Neomake
augroup END

