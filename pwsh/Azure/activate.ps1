#!/usr/bin/env pwsh

param (
    [String]$Subscription = (az account show --query id --output tsv),

    [ValidateSet('Contributor', 'Owner')]
    [String]$Role = 'Owner',

    [String]$Justification = (Split-Path -Leaf (git remote get-url origin)) -replace '.git$'
)

$ErrorActionPreference = 'Stop'

Set-Location $PSScriptRoot

$Subscription = az account show --subscription $Subscription --query id --output tsv

switch ($Role) {
    Contributor {
        $ExpirationDuration = 'PT8H'
    }
    Owner {
        $ExpirationDuration = 'PT4H'
    }
}

$Method = 'PUT'
$Uri = '/providers/Microsoft.Subscription/subscriptions/{0}/providers/Microsoft.Authorization/roleAssignmentScheduleRequests/{1}?api-version=2020-10-01' -f $Subscription, (New-Guid)
$Body = ConvertTo-Json -Depth 100 @{
    properties = @{
        principalId      = az ad signed-in-user show --query id --output tsv
        roleDefinitionId = az role definition list --name $Role --subscription $Subscription --query [].id --output tsv
        scheduleInfo     = @{
            startDateTime = Get-Date
            expiration    = @{
                duration = $ExpirationDuration
                type     = 'AfterDuration'
            }
        }
        justification    = $Justification
        requestType      = 'SelfActivate'
    }
}

$Body | az rest --method $Method --uri $Uri --body '@-' --output table
