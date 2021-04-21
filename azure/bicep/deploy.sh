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

if [[ "$*" == *--pipeline* ]]; then
    runMode="Pipeline"
else
    runMode="Interactive"
fi

main
