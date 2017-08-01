#!/bin/bash

# Add $script_dir variable as the script directory
. current_dir.sh

# File paths
source_config_dir=$script_dir
source_init_vim_file=$source_config_dir/init.vim
source_settings_dir=$source_config_dir/settings
source_plugin_dir=$source_config_dir/plugin
dest_config_dir=${XDG_CONFIG_HOME-$HOME/.config}/nvim
dest_init_vim_file=$dest_config_dir/init.vim
dest_settings_dir=$dest_config_dir/settings
dest_plugin_dir=$dest_config_dir/dein

rm -rf $dest_config_dir
rm -rf $dest_settings_dir
rm -rf $dest_plugin_dir

mkdir -p $dest_config_dir
mkdir -p $dest_settings_dir
mkdir -p $dest_plugin_dir

ln -s $source_init_vim_file $dest_init_vim_file
ln -s $source_settings_dir/* $dest_settings_dir
ln -s $source_plugin_dir/* $dest_plugin_dir

. dein.sh

