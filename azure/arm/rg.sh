#!/usr/bin/env bash

set -e +x
. main.config

az group create --subscription $subscription --name $resourceGroup --location $location --tags ${tags[*]} --output table
