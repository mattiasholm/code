#!/usr/bin/env pwsh

$Subscriptions = @(
    '<subscription>'
    '<subscription>'
    '<subscription>'
)
$Role = 'Contributor'
$ExpirationDuration = 'PT8H'
$Justification = 'Activated via PowerShell'

foreach ($Subscription in $Subscriptions) {
    $Arguments = @{
        Name                      = New-Guid
        PrincipalId               = (Get-AzADUser -UserPrincipalName (Get-AzContext).Account).Id
        Scope                     = '/subscriptions/{0}/' -f $Subscription
        RoleDefinitionId          = '/subscriptions/{0}/providers/Microsoft.Authorization/roleDefinitions/{1}' -f $Subscription, (Get-AzRoleDefinition -Name $Role).Id
        ScheduleInfoStartDateTime = Get-Date
        ExpirationDuration        = $ExpirationDuration
        Justification             = $Justification
        RequestType               = 'SelfActivate'
        ExpirationType            = 'AfterDuration'
    }

    New-AzRoleAssignmentScheduleRequest @Arguments
}