#!/usr/bin/env bash

set -e
. config.sh

az stack group create --name holm-arm --subscription $subscription --resource-group $resourceGroup --template-file $template --parameters @$parameters --deny-settings-mode None --delete-all --yes --output table
