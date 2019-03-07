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

"" LSP
"Plug 'autozimu/LanguageClient-neovim', {
"    \ 'branch': 'next',
"    \ 'do': 'bash install.sh',
"    \ }
"Plug 'w0rp/ale'

" Autocomplete
"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}

" Syntax
Plug 'modille/groovy.vim'
Plug 'neovimhaskell/haskell-vim'

call plug#end()
