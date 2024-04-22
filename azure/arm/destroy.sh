#!/usr/bin/env bash

set -e
. config.sh

az stack group delete --name holm-arm --subscription $subscription --resource-group $resourceGroup --action-on-unmanage deleteAll --yes --output table
