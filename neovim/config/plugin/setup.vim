set termguicolors
colorscheme despacio
highlight Normal guibg=none ctermbg=none
highlight NonText guibg=none ctermbg=none
highlight LineNr guibg=none ctermbg=none

let g:airline_theme = 'ubaryd'

" NERDTree Key
nnoremap <leader>n :NERDTreeToggle<CR>

" Neomake
augroup neomake_lint
    autocmd!
    autocmd BufWritePost * Neomake
augroup END

