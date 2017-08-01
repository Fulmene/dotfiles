#!/bin/bash

if [[ -n "$@" ]]; then
    target=$@
else
    target=*
fi

for config_dir in $target; do
    if [[ -d $config_dir ]] && [[ -f $config_dir/install.sh ]] && [[ -x $config_dir/install.sh ]]; then
        echo "Installing ${config_dir}..."
        cp common/current_dir.sh $config_dir
        ./$config_dir/install.sh
        rm $config_dir/current_dir.sh
    fi
done

