#!/usr/bin/env bash

set -e
. config.sh

az stack sub create --name holm-bicep --subscription $subscription --location $location --template-file $template --parameters $parameters --deny-settings-mode None --delete-all --yes --output table
