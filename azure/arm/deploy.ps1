#!/usr/bin/env pwsh

$SubscriptionId = "9b184a26-7fff-49ed-9230-d11d484ad51b"
$ResourceGroupName = "holm-arm"
$Location = "WestEurope"
$TemplateFile = "./storage.json"
$ParameterFile = "./storage.parameters.json"

# Login-AzAccount

Set-AzContext -SubscriptionId $SubscriptionId

New-AzResourceGroup -Name $ResourceGroupName -Location $Location -Force

New-AzResourceGroupDeployment `
    -ResourceGroupName $ResourceGroupName `
    -TemplateFile $TemplateFile `
    -TemplateParameterFile $ParameterFile `
    -Mode "Incremental"
