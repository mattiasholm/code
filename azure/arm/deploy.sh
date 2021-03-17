#!/usr/bin/env bash

set -e +x

if [[ -z "$1" ]]; then
    echo -e "Argument \"templateFile\" missing, exiting script"
    exit 1
else
    templateFile="$1"
fi

subscriptionId="9b184a26-7fff-49ed-9230-d11d484ad51b"
rgName="holm-arm"
rgLocation="WestEurope"
rgTags="Environment=Lab Owner=mattias.holm@live.com"
parameterFile="$(echo "${templateFile}" | sed 's/.json$/.parameters.json/')"
deployMode="Incremental"

az login

az account set --subscription "${subscriptionId}"

az group create \
    --name "${rgName}" \
    --location "${rgLocation}" \
    --tags ${rgTags[*]}

az deployment group create \
    --resource-group "${rgName}" \
    --template-file "${templateFile}" \
    --parameters "@${parameterFile}" \
    --mode "${deployMode}" \
    --confirm-with-what-if
