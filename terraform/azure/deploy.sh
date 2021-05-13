#!/usr/bin/env bash

set -e +x
subscriptionId="9b184a26-7fff-49ed-9230-d11d484ad51b"

export ARM_CLIENT_ID="${appId}"
export ARM_CLIENT_SECRET="${password}"
export ARM_SUBSCRIPTION_ID="${subscriptionId}"
export ARM_TENANT_ID="${tenant}"

terraform init --input=false
terraform plan -out=tfplan -input=false
terraform apply -input=false tfplan
