colorscheme wal
highlight CursorLine cterm=bold ctermfg=none ctermbg=0

" NERDTree Key
nnoremap <leader>n :NERDTreeToggle<CR>

" Neomake
augroup neomake_lint
    autocmd!
    autocmd BufWritePost * Neomake
augroup END

