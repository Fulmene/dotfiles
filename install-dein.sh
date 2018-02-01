#!/bin/sh

plugin_dir=~/.config/nvim/dein

curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > $plugin_dir/install_dein.sh
sh $plugin_dir/install_dein.sh $plugin_dir

