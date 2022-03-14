#!/usr/bin/env bash

set -e +x
subscriptionId='9b184a26-7fff-49ed-9230-d11d484ad51b'
resourceGroup='rg-holm-bicep-001'
location='WestEurope'
crName='crholmbicep001'
crSku='Basic'

az group create \
    --name $resourceGroup \
    --location $location \
    --subscription $subscriptionId

az acr create \
    --name $crName \
    --resource-group $resourceGroup \
    --sku $crSku
