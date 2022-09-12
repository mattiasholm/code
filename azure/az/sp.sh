#!/usr/bin/env bash

set -e

. $(basename $0 | sed 's/.sh$/.config/')

if [[ $(az account show --query tenantId --output tsv) != $tenantId ]]; then
    echo -e "Not signed in to tenant $tenantId.\nRun 'az login' to sign in."
    exit 1
fi

appId=$(az ad app create --display-name $name --sign-in-audience 'AzureADMyOrg' --query appId --output tsv)

owner=$(az ad signed-in-user show --query id --output tsv)
az ad app owner add --id $appId --owner-object-id $owner

if [[ -z $(az ad sp show --id $appId 2>/dev/null) ]]; then
    az ad sp create --id $appId
fi

id=$(az ad sp show --id $appId --query id --output tsv)
uri="https://graph.microsoft.com/v1.0/servicePrincipals/$id/owners/\$ref"

if [[ ! $(az rest --method GET --uri $uri --query value --output tsv) =~ $owner ]]; then
    az rest --method POST --uri $uri --body "{\"@odata.id\": \"https://graph.microsoft.com/v1.0/users/$owner\"}"
fi

if [[ ! ($(az ad app permission list --id $appId --query [].resourceAppId --output tsv) =~ $api && $(az ad app permission list --id $appId --query [].resourceAccess[].id --output tsv) =~ $permission) ]]; then
    az ad app permission add --id $appId --api $api --api-permissions "$permission=Role"
fi

uri="https://graph.microsoft.com/v1.0/servicePrincipals/$id/appRoleAssignments"
resourceId=$(az ad sp show --id $api --query id --output tsv)

if [[ ! ($(az rest --method GET --uri $uri --query value[].principalId --output tsv) =~ $id && $(az rest --method GET --uri $uri --query value[].resourceId --output tsv) =~ $resourceId && $(az rest --method GET --uri $uri --query value[].appRoleId --output tsv) =~ $permission) ]]; then
    az rest --method POST --uri $uri --body "{\"principalId\": \"$id\",\"resourceId\": \"$resourceId\",\"appRoleId\": \"$permission\"}"
fi

az role assignment create --assignee-object-id $id --assignee-principal-type 'ServicePrincipal' --role $roleName --scope "/subscriptions/$subscriptionId"

if [[ ! $(az ad app credential list --id $appId --query [].displayName --output tsv) =~ $secretName || $secretRotate == true ]]; then
    az ad app credential reset --id $appId --display-name $secretName --years $secretExpiration
fi

for subject in ${subjects[*]}; do
    if [[ ! $(az ad app federated-credential list --id $appId --query [].subject --output tsv) =~ $subject ]]; then
        az ad app federated-credential create --id $appId --parameters "{\"name\": \"$(echo $subject | sed 's/^.*://; s/refs\/heads\///')\",\"issuer\": \"$issuer\",\"subject\": \"$subject\",\"audiences\": [\"$audience\"]}"
    fi
done
