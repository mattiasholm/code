#!/usr/bin/env bash

set -e +x
. main.config

az group create --subscription #$subscription --name $resourceGroup --location $location --tags ${tags[*]}
az deployment group validate --subscription $subscription --resource-group $resourceGroup --template-file $template --parameters @$parameters
