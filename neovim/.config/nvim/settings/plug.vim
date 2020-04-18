call plug#begin('~/.local/share/nvim/plugged')

" Colourscheme
Plug 'AlessandroYorba/Despacio'

" File management
Plug 'scrooloose/nerdtree'
"Plug '/usr/bin/fzf'
"Plug 'junegunn/fzf.vim'
Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Git
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'airblade/vim-gitgutter'

" Autocomplete
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Syntax
Plug 'modille/groovy.vim'
Plug 'neovimhaskell/haskell-vim'

call plug#end()
