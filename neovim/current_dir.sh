#!/bin/bash

pushd . > /dev/null
script_dir="${BASH_SOURCE[0]}";
if ([ -h "${script_dir}" ]) then
  while([ -h "${script_dir}" ]) do cd `dirname "$script_dir"`; script_dir=`readlink "${script_dir}"`; done
fi
cd `dirname ${script_dir}` > /dev/null
script_dir=`pwd`;
popd  > /dev/null

