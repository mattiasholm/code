$ErrorActionPreference = 'Stop'
Add-AzureRmAccount
# mattias.holm@b3itadmin.onmicrosoft.com



$SubscriptionName = 'B3Care - Production'
$TenantDomain = 'b3care.se'
$VaultName = 'B3CARE-NL-BACKUP01'
$ResourceGroupName = 'B3CARE-NL-BAC'



$TenantId = (Invoke-WebRequest -Uri "https://login.windows.net/$TenantDomain/.well-known/openid-configuration" | ConvertFrom-Json).token_endpoint.Split('/')[3]
$SubscriptionId = (Get-AzureRmSubscription -TenantId $TenantId | Where-Object {$_.Name -eq $SubscriptionName}).Id
Select-AzureRmSubscription -SubscriptionId $SubscriptionId -TenantId $TenantId



$Vault = Get-AzureRmRecoveryServicesVault -Name $VaultName -ResourceGroupName $ResourceGroupName

Set-AzureRmRecoveryServicesVaultContext -Vault $Vault

$Containers = Get-AzureRmRecoveryServicesBackupContainer -ContainerType AzureVM


foreach ($Container in $Containers)
{
    $LatestRecoveryPoint = Get-AzureRmRecoveryServicesBackupItem -Container $Container -WorkloadType AzureVM | Select-Object LatestRecoveryPoint
}



$LatestRecoveryPoint