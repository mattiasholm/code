#!/usr/bin/env bash

set -e
. config.sh

az deployment sub create --subscription $subscription --location $location --template-file $template --no-prompt --output table
