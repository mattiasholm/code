#!/usr/bin/env bash

set -e
. config.sh

az stack group delete --name holm-arm --subscription $subscription --resource-group $resourceGroup --delete-all --yes --output table
