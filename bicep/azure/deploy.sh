#!/usr/bin/env bash

set -e
. config.sh

az stack sub create --name $stack --subscription $subscription --location $location --template-file $template --parameters $parameters --deny-settings-mode None --action-on-unmanage deleteAll --yes --output table
