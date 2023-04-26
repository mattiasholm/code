#!/usr/bin/env bash

set -e
. config.sh

az group create --subscription $subscription --name $resourceGroup --location $location --tags ${tags[*]} --output table
