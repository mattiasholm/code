#!/usr/bin/env bash

function Initialize() {
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
    templateFile="main.json"
    parameterFile="main.parameters.json"
}

function Login() {
    if [[ $appId && $password && $tenant ]]; then
        az login --service-principal --username $appId --password $password --tenant $tenant
    else
        set +e +x
        az account set --subscription $subscriptionId 2>/dev/null
        currentContext=$(az account show --query id --output tsv 2>/dev/null)
        set -e +x

        if [[ $currentContext != $subscriptionId ]]; then
            az login
        fi
    fi

    az account set --subscription $subscriptionId
}

function CreateResourceGroup() {
    az group create \
        --name $resourceGroup \
        --location $location \
        --tags ${tags[*]}
}

function Deploy() {
    operations=("validate" "what-if" "create")

    for operation in ${operations[@]}; do
        az deployment group $operation \
            --template-file $templateFile \
            --parameters @$parameterFile \
            --resource-group $resourceGroup
    done
}

function main() {
    Initialize
    Login
    CreateResourceGroup
    Deploy
}

main
