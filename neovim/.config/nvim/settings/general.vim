augroup startup
    autocmd!
    autocmd BufNewFile,BufReadPost,FilterReadPost,FileReadPost * :set number            " Always show line number on new buffer
augroup end
set nowrap

set nocompatible
filetype plugin indent on
set signcolumn=yes
set nobackup        " Don't use backup file
set nowritebackup

set cursorline
augroup CursorLine
    autocmd!
    autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    autocmd WinLeave * setlocal nocursorline
augroup END

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

set clipboard=unnamed,unnamedplus

let $VISUAL = 'nvr -cc split --remote-wait'         " Split instead of nested editor inside neovim terminal

set ignorecase
set smartcase

set exrc
set secure

augroup filetypedetect
    " Mail
    autocmd BufRead,BufNewFile *mutt-* setfiletype mail
augroup END

autocmd FileType text setlocal wrap

set hidden
set noshowmode

set cmdheight=2

set updatetime=300

set shortmess+=c
