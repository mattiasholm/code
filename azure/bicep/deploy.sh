#!/usr/bin/env bash

set -e +x

subscriptionId="9b184a26-7fff-49ed-9230-d11d484ad51b"
location="WestEurope"
bicepFile="main.bicep"
buildPath=".bicep"
jsonFile="$(echo $bicepFile | sed 's/.bicep$/.json/')"

mkdir -p "${buildPath}"

bicep build "${bicepFile}"
mv "${jsonFile}" "${buildPath}"

az login
az account set --subscription "${subscriptionId}"
az deployment sub what-if --location "${location}" --template-file "${buildPath}/${jsonFile}"
az deployment sub create --location "${location}" --template-file "${buildPath}/${jsonFile}"
