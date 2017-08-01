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

" Maximize
nnoremap <leader>_ <C-w>_
nnoremap <leader>\| <C-w>\|
nnoremap <leader>= <C-w>_<C-w>\|

" Tabs
" Tab navigation
nnoremap <C-h> :tabprevious<CR>
nnoremap <C-l> :tabnext<CR>

" Close tab
nnoremap <leader>q :tabclose<CR>

" Neovim terminal
" Open terminal tabs and splits
nnoremap <leader>tt :tabe<CR>:set nonumber<CR>:terminal<CR>
nnoremap <leader>ts :split<CR>:set nonumber<CR>:terminal<CR>
nnoremap <leader>tv :vsplit<CR>:set nonumber<CR>:terminal<CR>

" Press <Esc> twice to exit to normal mode from terminal
" (Single <Esc> is for Readline's command mode)
tnoremap <Esc><Esc> <C-\><C-n>

