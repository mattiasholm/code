#!/usr/bin/env bash

set -e +x
. main.config

operations=(create)

for operation in ${operations[@]}; do
    az deployment sub $operation \
        --subscription $subscriptionId \
        --location $location \
        --template-file $templateFile \
        --parameters @$parameterFile
done
