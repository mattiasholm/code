#!/usr/bin/env bash

subscriptionId="9b184a26-7fff-49ed-9230-d11d484ad51b"
resourceGroupName="holm-arm"
location="WestEurope"
templateFile="./storage.json"
parameterFile="./storage.parameters.json"

# az login

az account set --subscription "${subscriptionId}"

az group create --name "${resourceGroupName}" --location "${location}"

az deployment group create \
    --resource-group "${resourceGroupName}" \
    --template-file "${templateFile}" \
    --parameters "@${parameterFile}" \
    --mode "Incremental"
