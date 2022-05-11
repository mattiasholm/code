#!/usr/bin/env bash

set -e
. $(basename $0 | sed 's/.sh$/.config/')

if [[ $(az account show --query tenantId --output tsv) != $tenant ]]; then
    echo -e "Not signed in to tenant $tenant.\nRun 'az login' to sign in."
    exit 1
fi

appId=$(az ad app list --display-name $name --query [].appId --output tsv)

if [[ -z $appId ]]; then
    az ad sp create-for-rbac --name $name --role $role --scopes $scopes --output json
    appId=$(az ad app list --display-name $name --query [].appId --output tsv)
fi

owner=$(az ad signed-in-user show --query objectId --output tsv)
az ad app owner add --id $appId --owner-object-id $owner

if [[ $(az ad app permission list --id $appId --query [].resourceAppId --output tsv) != $api ]]; then
    az ad app permission add --id $appId --api $api --api-permissions $permission
fi

az ad app permission grant --id $appId --api $api
az ad app permission admin-consent --id $appId

objectId=$(az ad app list --display-name $name --query [].objectId --output tsv)
uri="https://graph.microsoft.com/beta/applications/$objectId/federatedIdentityCredentials"

for subject in ${subjects[@]}; do
    if [[ ! $(az rest --method GET --uri $uri --query value[].subject[] --output tsv) =~ $subject ]]; then
        name=$(echo $subject | sed 's/^.*://; s/refs\/heads\///')
        az rest --method POST --uri $uri --body "{\"name\":\"$name\",\"issuer\":\"$issuer\",\"subject\":\"$subject\",\"audiences\":[\"$audience\"]}"
    fi
done
