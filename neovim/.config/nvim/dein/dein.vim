if &compatible
    set nocompatible
endif

exec "set runtimepath+=" . expand(pluginpath.'/repos/github.com/Shougo/dein.vim')

if dein#load_state(expand(pluginpath))

    call dein#begin(expand(pluginpath))

    call dein#add(expand(pluginpath . '/repos/github.com/Shougo/dein.vim'))

    " Colourscheme
    call dein#add('AlessandroYorba/Despacio')

    " File management
    call dein#add('scrooloose/nerdtree', {'on_cmd': 'NERDTreeToggle'})
    call dein#add('Shougo/denite.nvim', {'on_cmd': 'Denite'})

    " Dispatch
    call dein#add('tpope/vim-dispatch')
    call dein#add('radenling/vim-dispatch-neovim')

    " Lint
    call dein#add('neomake/neomake')

    " Airline
    call dein#add('vim-airline/vim-airline')
    call dein#add('vim-airline/vim-airline-themes')

    " Git
    call dein#add('tpope/vim-fugitive')
    call dein#add('tpope/vim-rhubarb')
    call dein#add('airblade/vim-gitgutter')

    " Syntax
    call dein#add('modille/groovy.vim')
    call dein#add('neovimhaskell/haskell-vim')

    " Autocomplete
    call dein#add('Shougo/deoplete.nvim')

    " Filetype
    call dein#add('Shougo/neco-syntax')
    call dein#add('zchee/deoplete-clang')
    call dein#add('eagletmt/neco-ghc')
    call dein#add('zchee/deoplete-jedi')
    call dein#add('sebastianmarkow/deoplete-rust')
    call dein#add('artur-shaik/vim-javacomplete2')
    call dein#add('dbeniamine/vim-mail', {'on_ft': 'mail'})

    call dein#end()
    call dein#save_state()

endif

filetype plugin indent on
syntax enable

call map(dein#check_clean(), "delete(v:val, 'rf')")
if dein#check_install()
    call dein#install()
endif

