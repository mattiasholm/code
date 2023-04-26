#!/usr/bin/env bash

set -e
. config.sh

az deployment sub create --subscription $subscription --location $location --template-file $template --parameters $parameters --no-prompt --output table
