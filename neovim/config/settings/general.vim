augroup startup
    autocmd BufNewFile,BufReadPost,FilterReadPost,FileReadPost * :set number            " Always show line number on new buffer
augroup end
set nowrap

set nobackup        " Don't use backup file

set cursorline

" Tab
set tabstop=4
set shiftwidth=0
set softtabstop=-1
set expandtab

" UTF-8
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8

" Scrolling
set scrolloff=5
set sidescrolloff=5
set lazyredraw

set magic             " Regular expressions

set autoread

