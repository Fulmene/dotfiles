set nocompatible
filetype plugin indent on

call plug#begin('~/.local/share/nvim/plugged')

" Colourscheme
Plug 'AlessandroYorba/Despacio'

" File management
Plug 'scrooloose/nerdtree'

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Git
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'airblade/vim-gitgutter'

call plug#end()
