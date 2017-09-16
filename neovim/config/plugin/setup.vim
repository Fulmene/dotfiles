"set termguicolors
colorscheme ir_black
let g:airline_theme = 'behelit'

" NERDTree Key
nnoremap <leader>n :NERDTreeToggle<CR>

" Neomake
augroup neomake_lint
    autocmd!
    autocmd BufWritePost * Neomake
augroup END

