#!/usr/bin/env bash

set -e
. config.sh

az stack group create --name $stack --subscription $subscription --resource-group $resourceGroup --template-file $template --parameters @$parameters --deny-settings-mode None --action-on-unmanage deleteAll --yes --output table
