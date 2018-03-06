set termguicolors
colorscheme despacio
let g:despacio_Sunset = 1
highlight Normal guibg=none ctermbg=none
highlight NonText guibg=none ctermbg=none
highlight LineNr guibg=none ctermbg=none

" Airline
let g:airline_theme = 'minimalist'

" Lint
autocmd! BufWritePost,BufEnter * Neomake
let g:neomake_open_list = 2

" File management
nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <leader>d :Denite file_rec<CR>

" Deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#omni_patterns = {}
let g:deoplete#omni_patterns.java = '[^. *\t]\.\w*'
let g:deoplete#sources = {}
let g:deoplete#sources._ = []
let g:deoplete#file#enable_buffer_path = 1

" Deoplete use tab
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" vim-javacomplete2
autocmd FileType java setlocal omnifunc=javacomplete#Complete
