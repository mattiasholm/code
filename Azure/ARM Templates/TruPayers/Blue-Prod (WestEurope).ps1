$ErrorActionPreference = 'Stop'
Login-AzAccount



$ResourceGroupName = "Blue-WE-Prod"
$Location = 'WestEurope'
$SubscriptionName = 'TruPayers - Blue - Prod'
$TenantDomain = 'trupayers.onmicrosoft.com'



$TenantId = (Invoke-WebRequest -Uri "https://login.windows.net/$TenantDomain/.well-known/openid-configuration" | ConvertFrom-Json).token_endpoint.Split('/')[3]
$SubscriptionId = (Get-AzSubscription -TenantId $TenantId | Where-Object {$_.Name -eq $SubscriptionName}).Id
Select-AzSubscription -SubscriptionId $SubscriptionId -TenantId $TenantId

switch ($ResourceGroupName.Split('-')[2]) {
    Prod {$Environment = 'Production'}
    Dev {$Environment = 'Development'}
    default {$Environment = 'Unknown'}
}



# Create Resource Group

New-AzResourceGroup `
    -Name $ResourceGroupName `
    -Location $Location `
    -Tag @{Environment = $Environment; SecurityLevel = $ResourceGroupName.Split('-')[0]} `
    -Force



$Customer = 'TruPayers'
$ArmPath = 'C:\Users\MattiasHolm\Documents\GitHub\powershell\Azure\ARM Templates'
$FilePath = Join-Path -Path $ArmPath -ChildPath $Customer
$FilePrefix = $ResourceGroupName.Replace("$($ResourceGroupName.Split('-')[1])-", '')



# PreDeploy

$TemplateFileName = "$FilePrefix`_PreDeploy.json"
$ParameterFileName = "$FilePrefix`_PreDeploy.parameters.json"

New-AzResourceGroupDeployment `
    -ResourceGroupname  $ResourceGroupName `
    -TemplateFile (Join-Path -Path $FilePath -ChildPath $TemplateFileName) `
    -TemplateParameterFile (Join-Path -Path $FilePath -ChildPath $ParameterFileName) `
    -Mode Incremental



# Deploy

$TemplateFileName = "$FilePrefix.json"
$ParameterFileName = "$FilePrefix.parameters.json"

New-AzResourceGroupDeployment `
    -ResourceGroupname  $ResourceGroupName `
    -TemplateFile (Join-Path -Path $FilePath -ChildPath $TemplateFileName) `
    -TemplateParameterFile (Join-Path -Path $FilePath -ChildPath $ParameterFileName) `
    -Mode Incremental