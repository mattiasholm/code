#!/usr/bin/env bash

set -e +x
crName='crholmbicep001'
modules='modules/'
tag='v1'

for module in $modules*; do
    name=$(basename $module | sed 's/.bicep$//')
    az bicep publish \
        --file $module \
        --target "br:$crName.azurecr.io/$name:$tag"
done
