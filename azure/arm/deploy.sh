#!/usr/bin/env bash

if [[ -z "$1" ]]; then
    echo -e "Argument \"templateFile\" missing, exiting script"
    exit 1
else
    templateFile="$1"
fi

set -e +x

subscriptionId="9b184a26-7fff-49ed-9230-d11d484ad51b"
resourceGroupName="holm-arm"
location="WestEurope"
parameterFile="$(echo "${templateFile}" | sed 's/.json$/.parameters.json/')"

az login

az account set --subscription "${subscriptionId}"

az group create \
    --name "${resourceGroupName}" \
    --location "${location}" \
    --tags Environment="Lab" Owner="Mattias Holm"

az deployment group create \
    --resource-group "${resourceGroupName}" \
    --template-file "${templateFile}" \
    --parameters "@${parameterFile}" \
    --mode "Incremental"
