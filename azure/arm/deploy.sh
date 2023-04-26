#!/usr/bin/env bash

set -e
. config.sh

az deployment group create --subscription $subscription --resource-group $resourceGroup --template-file $template --parameters @$parameters --no-prompt --output table
