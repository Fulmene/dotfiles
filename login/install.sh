#!/bin/bash

source login/current_dir.sh

shopt -s dotglob
ln -sf $current_dir/config/* ~

