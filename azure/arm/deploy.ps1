#!/usr/bin/env pwsh

param(
    [Parameter(
        Mandatory,
        Position = 0)]
    [String] $TemplateFile
)

$ErrorActionPreference = "Stop"

$SubscriptionId = "9b184a26-7fff-49ed-9230-d11d484ad51b"
$ResourceGroupName = "holm-arm"
$ResourceGroupLocation = "WestEurope"
$ResourceGroupTags = @{Environment = "Lab"; Owner = "mattias.holm@live.com" }
$ParameterFile = $TemplateFile.Replace('.json', '.parameters.json')

Login-AzAccount

Set-AzContext -SubscriptionId $SubscriptionId

New-AzResourceGroup `
    -Name $ResourceGroupName `
    -Location $ResourceGroupLocation `
    -Tag $ResourceGroupTags `
    -Force

New-AzResourceGroupDeployment `
    -ResourceGroupName $ResourceGroupName `
    -TemplateFile $TemplateFile `
    -TemplateParameterFile $ParameterFile



# OBS: Skriv om skriptet så att det fungerar att köra i pipeline på samma sätt som 'deploy.sh'??? Kan såklart vara bra att ha båda exemplen färdiga som referens!