#!/usr/bin/env bash

set -e +x
. main.config

az deployment group what-if --subscription $subscription --resource-group $resourceGroup --template-file $template --parameters @$parameters --no-prompt --output table
