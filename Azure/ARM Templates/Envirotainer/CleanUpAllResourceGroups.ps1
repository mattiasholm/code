$ErrorActionPreference = 'Stop'
Add-AzureRmAccount



$EnvironmentSuffix = 'WEEU-Prod'
$SubscriptionName = 'B3IT Cloud Services - Test'
$TenantDomain = 'b3.se'



$TenantId = (Invoke-WebRequest -Uri "https://login.windows.net/$TenantDomain/.well-known/openid-configuration" | ConvertFrom-Json).token_endpoint.Split('/')[3]
$SubscriptionId = (Get-AzureRmSubscription -TenantId $TenantId | Where-Object {$_.Name -eq $SubscriptionName}).Id
Select-AzureRmSubscription -SubscriptionId $SubscriptionId -TenantId $TenantId



# Remove Resource Groups

$ResourceGroupNames = `
    'Portal', `
    'DryIce', `
    'Notifications', `
    'OrderManagement', `
    'OrderStatistics'

foreach ($ResourceGroupName in $ResourceGroupNames) {
    Remove-AzureRmResourceGroup `
        -Name "$ResourceGroupName-$EnvironmentSuffix" `
        -Force
}