" Open terminal tabs and splits
nnoremap <leader>tt :tabe<CR>:set nonumber<CR>:terminal<CR>
nnoremap <leader>ts :split<CR>:set nonumber<CR>:terminal<CR>
nnoremap <leader>tv :vsplit<CR>:set nonumber<CR>:terminal<CR>

" Press <Esc> twice to exit to normal mode from terminal
" (Single <Esc> is for Readline's command mode)
tnoremap <Esc><Esc> <C-\><C-n>

