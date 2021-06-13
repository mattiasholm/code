#!/usr/bin/env bash

topLevel=$(git rev-parse --show-toplevel)
childPath="arm-ttk\/arm-ttk"
path=$(echo ${topLevel} | sed "s/$(basename ${topLevel})$/${childPath}/")

cd ${path}
./Test-AzTemplate.sh
