#!/usr/bin/env bash

set -e +x
. main.config

az group create \
    --name $resourceGroup \
    --location $location \
    --tags ${tags[*]} \
    --subscription $subscriptionId

az deployment group validate \
    --subscription $subscriptionId \
    --resource-group $resourceGroup \
    --template-file $templateFile \
    --parameters @$parameterFile
