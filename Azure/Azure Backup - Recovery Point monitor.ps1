### Updated to use new Az module, run script in PowerShell Core (pwsh)



$ErrorActionPreference = 'Stop'
Login-AzAccount
# mattias.holm@b3itadmin.onmicrosoft.com



$SubscriptionName = 'B3Care - Production'
$TenantDomain = 'b3care.se'
$VaultName = 'B3CARE-NL-BACKUP01'
$ResourceGroupName = 'B3CARE-NL-BAC'
$ThresholdHours = 36



$TenantId = (Invoke-WebRequest -Uri "https://login.windows.net/$TenantDomain/.well-known/openid-configuration" | ConvertFrom-Json).token_endpoint.Split('/')[3]
$SubscriptionId = (Get-AzSubscription -TenantId $TenantId | Where-Object {$_.Name -eq $SubscriptionName}).Id
Select-AzSubscription -SubscriptionId $SubscriptionId -TenantId $TenantId



$Vault = Get-AzRecoveryServicesVault -Name $VaultName -ResourceGroupName $ResourceGroupName

$Containers = Get-AzRecoveryServicesBackupContainer -VaultId $Vault.Id -ContainerType AzureVM


foreach ($Container in $Containers) {
    $LatestRecoveryPoint = (Get-AzRecoveryServicesBackupItem -VaultId $Vault.Id -Container $Container -WorkloadType AzureVM).LatestRecoveryPoint

    if ($LatestRecoveryPoint -lt [System.DateTime]::UtcNow.AddHours(-$ThresholdHours)) {
        Write-Host -ForegroundColor Red "Backup NOK"
    }
    else {
        Write-Host -ForegroundColor Green "Backup OK"
    }
}





# MARS:
$Containers = Get-AzRecoveryServicesBackupContainer -VaultId $Vault.Id -ContainerType Windows -BackupManagementType MARS