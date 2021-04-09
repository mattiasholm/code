#!/usr/bin/env bash

subscriptionId="9b184a26-7fff-49ed-9230-d11d484ad51b"
location="WestEurope"
templateFile="main.bicep"

set -e +x

if [[ "$*" == *--pipeline* ]]; then
    az login --service-principal --username "${appId}" --password "${password}" --tenant "${tenant}" &&
        az account set --subscription "${subscriptionId}"
else
    az login &&
        az account set --subscription "${subscriptionId}"
fi

az deployment sub what-if --location "${location}" --template-file "${templateFile}" &&
    az deployment sub create --location "${location}" --template-file "${templateFile}"
# Test