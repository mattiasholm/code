#!/usr/bin/env pwsh

param
(
    [Parameter(Mandatory, HelpMessage = 'Enter the name of the Key Vault to export all secrets from.')]$VaultName
)

$SecretNames = (Get-AzKeyVaultSecret -VaultName $VaultName).Name

foreach ($SecretName in $SecretNames) {
    $SecretValue = Get-AzKeyVaultSecret -VaultName $VaultName -Name $SecretName -AsPlainText
    "`"{0}`": `"{1}`"" -f $SecretName, $SecretValue
}