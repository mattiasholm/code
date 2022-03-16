#!/usr/bin/env bash

set -e +x
. main.config

operations=(validate what-if)

for operation in ${operations[@]}; do
    az deployment sub $operation \
        --subscription $subscriptionId \
        --location $location \
        --template-file $templateFile \
        --parameters @$parameterFile
done
