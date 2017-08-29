if &compatible
    set nocompatible
endif

exec "set runtimepath+=" . expand(pluginpath.'/repos/github.com/Shougo/dein.vim')

if dein#load_state(expand(pluginpath))

    call dein#begin(expand(pluginpath))

    call dein#add(expand(pluginpath . '/repos/github.com/Shougo/dein.vim'))

    call dein#add('dylanaraps/wal.vim')

    call dein#add('scrooloose/nerdtree', {'on_cmd': 'NERDTreeToggle'})

    call dein#add('neomake/neomake')
    call dein#add('tpope/vim-dispatch')
    call dein#add('radenling/vim-dispatch-neovim')

    call dein#add('vim-airline/vim-airline')
    call dein#add('vim-airline/vim-airline-themes')

    call dein#add('tpope/vim-fugitive')
    call dein#add('tpope/vim-rhubarb')

    call dein#end()
    call dein#save_state()

endif

filetype plugin indent on
syntax enable

if dein#check_install()
    call dein#install()
endif

