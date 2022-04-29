#!/usr/bin/env bash

set -e +x
. main.config

az deployment group validate --subscription $subscription --resource-group $resourceGroup --template-file $template --parameters @$parameters
