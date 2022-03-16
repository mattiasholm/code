#!/usr/bin/env bash

set -e +x
. main.config
args="--subscription $subscriptionId --location $location --template-file $templateFile --parameters @$parameterFile"

az deployment sub what-if $args
