#!/bin/bash

source current_dir.sh

if [[ "$#" -gt 1 ]]; then
    echo "Usage: dir_install: install to home"
    echo "       dir_install DIR: install to DIR"
    exit 1
else
    if [[ "$#" -eq 1 ]]; then
        install_dir=$1
    else
        install_dir=$HOME
    fi
fi

shopt -s dotglob
mkdir -p $install_dir
ln -sf $current_dir/files/* $install_dir

