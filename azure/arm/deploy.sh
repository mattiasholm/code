#!/usr/bin/env bash

function Login() {
    case "${runMode}" in
    "Interactive")
        az login &&
            az account set --subscription "${subscriptionId}"
        ;;
    "Pipeline")
        az login --service-principal --username "${appId}" --password "${password}" --tenant "${tenant}" &&
            az account set --subscription "${subscriptionId}"
        ;;
    esac
}

function CreateResourceGroup() {
    az group create \
        --name "${rgName}" \
        --location "${location}" \
        --tags ${tags[*]}
}

function Deploy() {
    operations=("what-if" "create")

    for operation in ${operations[@]}; do
        az deployment group "${operation}" \
            --resource-group "${rgName}" \
            --template-file "${templateFile}" \
            --parameters "@${parameterFile}"
    done
}

function main() {
    set -e +x

    subscriptionId="9b184a26-7fff-49ed-9230-d11d484ad51b"
    rgName="rg-holm-arm-001"
    location="WestEurope"
    tags="Company=Holm Environment=Test Application=ARM Owner=mattias.holm@live.com"
    templateFile="main.json"
    parameterFile="main.parameters.json"

    # Login
    CreateResourceGroup
    Deploy
}

if [[ "$*" == *--pipeline* ]]; then
    runMode="Pipeline"
else
    runMode="Interactive"
fi

main
