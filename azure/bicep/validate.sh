#!/usr/bin/env bash

set -e
. config.sh

az deployment sub validate --subscription $subscription --location $location --template-file $template --parameters $parameters --no-prompt --output table
