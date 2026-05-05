#!/usr/bin/env bash

set -e
. config.sh

az stack sub validate --name $stack --subscription $subscription --location $location --template-file $template --parameters $parameters --deny-settings-mode None --action-on-unmanage deleteAll --output table
