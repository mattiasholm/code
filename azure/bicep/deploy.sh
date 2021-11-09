#!/usr/bin/env bash

function SetVariables() {
    set -e +x
    subscriptionId="9b184a26-7fff-49ed-9230-d11d484ad51b"
    location="WestEurope"
    operations=("create")
    templateFile="main.bicep"
}

function Deploy() {
    for operation in ${operations[@]}; do
        az deployment sub $operation \
            --subscription $subscriptionId \
            --location $location \
            --template-file $templateFile
    done
}

function main() {
    SetVariables
    Deploy
}

main
