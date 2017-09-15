colorscheme wal
highlight CursorLine ctermfg=none ctermbg=238
highlight CursorLineNr ctermfg=none ctermbg=238

" NERDTree Key
nnoremap <leader>n :NERDTreeToggle<CR>

" Neomake
augroup neomake_lint
    autocmd!
    autocmd BufWritePost * Neomake
augroup END

