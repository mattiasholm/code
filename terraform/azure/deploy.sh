#!/usr/bin/env bash

function Initialize() {
    set -e +x

    if [[ "$@" =~ "--pipeline" ]]; then
        runMode="Pipeline"
    else
        runMode="Interactive"
    fi

    subscriptionId="9b184a26-7fff-49ed-9230-d11d484ad51b"
}

function Login() {
    case "${runMode}" in
    "Interactive")
        az login &&
            az account set --subscription "${subscriptionId}"
        ;;
    "Pipeline")
        export ARM_CLIENT_ID="${appId}"
        export ARM_CLIENT_SECRET="${password}"
        export ARM_SUBSCRIPTION_ID="${subscriptionId}"
        export ARM_TENANT_ID="${tenant}"
        ;;
    esac
}

function Deploy() {
    terraform init -input=false
    terraform plan -out=tfplan -input=false
    terraform apply -input=false tfplan
}

function main() {
    Initialize "$@"
    Login
    Deploy
}

main "$@"
