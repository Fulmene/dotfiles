#!/bin/bash

pushd . > /dev/null
current_dir="${BASH_SOURCE[0]}";
if ([ -h "${current_dir}" ]) then
  while([ -h "${current_dir}" ]) do cd `dirname "$current_dir"`; current_dir=`readlink "${current_dir}"`; done
fi
cd `dirname ${current_dir}` > /dev/null
current_dir=`pwd`;
popd  > /dev/null

