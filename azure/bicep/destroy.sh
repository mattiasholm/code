#!/usr/bin/env bash

set -e
. config.sh

az stack sub delete --name holm-bicep --subscription $subscription --action-on-unmanage deleteAll --yes --output table
