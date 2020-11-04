#!/usr/bin/env pwsh

param(
    [Parameter(Mandatory = $true, Position = 0)] [String] $ArmType,
    [Parameter(Mandatory = $false, Position = 1)] [Int] $ResultSize = 3,
    [Parameter(Mandatory = $false)] [Switch] $Clipboard
)

$ProviderNameSpace = $ArmType.Split('/')[0]
$ResourceTypeName = $ArmType.Replace("$ProviderNameSpace/", '')

switch ($Clipboard) {
    false {
        Write-Host "`nStable API versions for $ArmType`:`n"
        $apiVersion = ((Get-AzResourceProvider -ProviderNamespace $ProviderNamespace).ResourceTypes | Where-Object ResourceTypeName -eq $ResourceTypeName).ApiVersions -notlike '*-preview' | Select-Object -First $ResultSize
        return $apiVersion
    }
    true {
        $apiVersion = ((Get-AzResourceProvider -ProviderNamespace $ProviderNamespace).ResourceTypes | Where-Object ResourceTypeName -eq $ResourceTypeName).ApiVersions -notlike '*-preview' | Select-Object -First $ResultSize
        Set-Clipboard -Value $apiVersion
        return "Latest stable apiVersion copied to clipboard!"
    }
}