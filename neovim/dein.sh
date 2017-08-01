#!/bin/bash

curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > $dest_plugin_dir/install_dein.sh
sh $dest_plugin_dir/install_dein.sh $dest_plugin_dir

