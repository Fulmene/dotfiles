#!/usr/bin/env bash

shopt -s dotglob
cp -R neovim/* ~
cp -R bash/.inputrc ~
cp -R tmux/* ~
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
