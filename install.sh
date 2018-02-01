#!/bin/sh

if [ -n "$@" ]; then
    target=$@
else
    target=*
fi

for config_dir in $target; do
    if [ -d $config_dir ]; then
        echo "stow ${config_dir}"
        stow ${config_dir}
    fi
done

