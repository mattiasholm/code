#!/usr/bin/env bash

function Login() {
    if [[ "$*" == *--pipeline* ]]; then
        az login --service-principal --username "${appId}" --password "${password}" --tenant "${tenant}" &&
            az account set --subscription "${subscriptionId}"
    else
        az login &&
            az account set --subscription "${subscriptionId}"
    fi
}

function Deploy() {
    operations=("what-if" "create")

    for operation in ${operations[@]}; do
        az deployment sub "${operation}" \
            --template-file "${templateFile}" \
            --location "${location}"
    done
}

function main() {
    set -e +x

    subscriptionId="9b184a26-7fff-49ed-9230-d11d484ad51b"
    location="WestEurope"
    templateFile="main.bicep"

    Login
    Deploy
}

main
