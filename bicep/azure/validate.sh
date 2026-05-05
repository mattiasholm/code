#!/usr/bin/env bash

set -e
. config.sh

# az stack sub validate --subscription $subscription --location $location --template-file $template --parameters $parameters --no-prompt --output table
# az stack sub validate --name $stack --subscription $subscription --location $location --template-file $template --parameters $parameters --deny-settings-mode None --action-on-unmanage deleteAll --yes --output table
az stack sub validate --name $stack --location $location --deny-settings-mode None --action-on-unmanage deleteAll --yes --output table
