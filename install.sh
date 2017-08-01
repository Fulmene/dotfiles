#!/bin/bash

for config in ./*; do
    if [[ -d $config ]] && [[ -f $config/install.sh ]] && [[ -x $config/install.sh ]]; then
        cp common/current_dir.sh $config
        $config/install.sh
        rm $config/current_dir.sh
    fi
done

