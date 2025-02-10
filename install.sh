#!/bin/sh

if [ -n "$1" ]; then
    target=$@
else
    target=*
fi

for config_dir in $target; do
    if [ -d $config_dir ]; then
        echo "stow --no-folding ${config_dir}"
        stow --no-folding ${config_dir}
    fi
done
