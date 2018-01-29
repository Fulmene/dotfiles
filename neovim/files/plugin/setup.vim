set termguicolors
colorscheme despacio
highlight Normal guibg=none ctermbg=none
highlight NonText guibg=none ctermbg=none
highlight LineNr guibg=none ctermbg=none

let g:airline_theme = 'minimalist'

" NERDTree Key
nnoremap <leader>n :Denite file_rec<CR>

" Neomake
augroup neomake_lint
    autocmd!
    autocmd BufWritePost * Neomake
augroup END

" Deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#omni_patterns = {}
let g:deoplete#omni_patterns.java = '[^. *\t]\.\w*'
let g:deoplete#omni_patterns.groovy = '[^. *\t]\.\w*'
let g:deoplete#sources = {}
let g:deoplete#sources._ = []
let g:deoplete#file#enable_buffer_path = 1

" vim-javacomplete2
autocmd FileType java setlocal omnifunc=javacomplete#Complete

