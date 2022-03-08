#!/usr/bin/env bash

function SetVariables() {
    set -e +x
    subscriptionId="9b184a26-7fff-49ed-9230-d11d484ad51b"
    location="WestEurope"
    operations=("validate" "what-if")
    templateFile="main.bicep"
    parameterFile="main.parameters.json"
}

function Deploy() {
    for operation in ${operations[@]}; do
        az deployment sub $operation \
            --subscription $subscriptionId \
            --location $location \
            --template-file $templateFile \
            --parameters @$parameterFile
    done
}

function main() {
    SetVariables
    Deploy
}

main
