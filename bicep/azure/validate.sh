#!/usr/bin/env bash

set -e
. config.sh

az stack sub validate --subscription $subscription --location $location --template-file $template --parameters $parameters --no-prompt --output table
