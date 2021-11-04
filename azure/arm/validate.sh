#!/usr/bin/env bash

function SetVariables() {
    set -e +x
    subscriptionId="9b184a26-7fff-49ed-9230-d11d484ad51b"
    resourceGroup="rg-holm-arm-001"
    location="WestEurope"
    tags=(
        "Application=ARM"
        "Company=Holm"
        "Environment=Dev"
        "Owner=mattias.holm@live.com"
    )
    operations=("validate" "what-if")
    templateFile="main.json"
    parameterFile="main.parameters.json"
}

function SetContext() {
    az account set --subscription $subscriptionId
}

function CreateResourceGroup() {
    az group create \
        --name $resourceGroup \
        --location $location \
        --tags ${tags[*]}
}

function Deploy() {
    for operation in ${operations[@]}; do
        az deployment group $operation \
            --resource-group $resourceGroup \
            --template-file $templateFile \
            --parameters @$parameterFile
    done
}

function main() {
    SetVariables
    SetContext
    CreateResourceGroup
    Deploy
}

main
