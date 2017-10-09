" Use spacebar as leader
let mapleader="\<Space>"

" Navigation
nnoremap j gj
nnoremap k gk

" Windows
" Move
nnoremap H <C-w>h
nnoremap J <C-w>j
nnoremap K <C-w>k
nnoremap L <C-w>l

" Maximise
nnoremap <leader>_ <C-w>_
nnoremap <leader>\| <C-w>\|
nnoremap <leader>= <C-w>_<C-w>\|

" Tabs
" Tab navigation
nnoremap <C-h> :tabprevious<CR>
nnoremap <C-l> :tabnext<CR>

" Close tab
nnoremap <leader>q :tabclose<CR>

" Search
" Unhighlight search
nnoremap <leader>h :nohl<CR>

