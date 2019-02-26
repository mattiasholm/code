$ErrorActionPreference = 'Stop'
Login-AzAccount
# mholm_adm@envirotainer.com



$EnvironmentSuffix = 'WEEU-Prod'
$SubscriptionName = 'Envirotainer Portal - Prod'
# # # TEMP # # #
$SubscriptionName = 'MyEnvirotainer'
# # # TEMP # # # 
$TenantDomain = 'envirotainer.com'



$TenantId = (Invoke-WebRequest -Uri "https://login.windows.net/$TenantDomain/.well-known/openid-configuration" | ConvertFrom-Json).token_endpoint.Split('/')[3]
$SubscriptionId = (Get-AzSubscription -TenantId $TenantId | Where-Object {$_.Name -eq $SubscriptionName}).Id
Select-AzSubscription -SubscriptionId $SubscriptionId -TenantId $TenantId



# Remove Resource Groups

$ResourceGroupNames = `
    'Portal', `
    'DryIce', `
    'Notifications', `
    'OrderManagement', `
    'OrderStatistics'

foreach ($ResourceGroupName in $ResourceGroupNames) {
    Remove-AzResourceGroup `
        -Name "$ResourceGroupName-$EnvironmentSuffix" `
        -Force
}