#!/usr/bin/env pwsh

param(
    [Parameter(Mandatory = $true, Position = 0)] [String] $TemplateFile
)

$ErrorActionPreference = "Stop"

$SubscriptionId = "9b184a26-7fff-49ed-9230-d11d484ad51b"
$ResourceGroupName = "holm-arm"
$Location = "WestEurope"
$ParameterFile = $TemplateFile.Replace('.json', '.parameters.json')

Login-AzAccount

Set-AzContext -SubscriptionId $SubscriptionId

New-AzResourceGroup `
    -Name $ResourceGroupName `
    -Location $Location `
    -Tag @{Environment = "Lab"; Owner = "Mattias Holm" } `
    -Force

New-AzResourceGroupDeployment `
    -ResourceGroupName $ResourceGroupName `
    -TemplateFile $TemplateFile `
    -TemplateParameterFile $ParameterFile `
    -Mode "Incremental"
