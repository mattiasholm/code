#!/usr/bin/env bash

set -e +x
subscriptionId='9b184a26-7fff-49ed-9230-d11d484ad51b'
resourceGroup='rg-holm-arm-001'
location='WestEurope'
tags=(
    'Application=ARM'
    'Company=Holm'
    'Environment=Dev'
    'Owner=mattias.holm@live.com'
)
operations=('create')
templateFile='main.json'
parameterFile='main.parameters.json'

az group create \
    --name $resourceGroup \
    --location $location \
    --tags ${tags[*]} \
    --subscription $subscriptionId

for operation in ${operations[@]}; do
    az deployment group $operation \
        --subscription $subscriptionId \
        --resource-group $resourceGroup \
        --template-file $templateFile \
        --parameters @$parameterFile
done
