#!/usr/bin/env bash

set -e +x
. main.config

az deployment sub create --subscription $subscription --location $location --template-file $template --parameters @$parameters
