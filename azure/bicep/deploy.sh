#!/usr/bin/env bash

function Initialize() {
    set -e +x

    subscriptionId="9b184a26-7fff-49ed-9230-d11d484ad51b"
    location="WestEurope"
    templateFile="main.bicep"
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

function Deploy() {
    operations=("create")

    for operation in ${operations[@]}; do
        az deployment sub $operation \
            --template-file $templateFile \
            --location $location
    done
}

function main() {
    Initialize
    Login
    Deploy
}

main
