#!/usr/bin/env bash

set -e +x

subscriptionId="9b184a26-7fff-49ed-9230-d11d484ad51b"
location="WestEurope"
templateFile="main.bicep"

# az login
az login --service-principal --username "${appId}" --password "${password}" --tenant "${tenant}" &&
    az account set --subscription "${subscriptionId}"

az deployment sub what-if --location "${location}" --template-file "${templateFile}"
az deployment sub create --location "${location}" --template-file "${templateFile}"
