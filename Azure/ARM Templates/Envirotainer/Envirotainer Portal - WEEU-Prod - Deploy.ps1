$ErrorActionPreference = 'Stop'
Login-AzAccount
# mholm_adm@envirotainer.com


$EnvironmentSuffix = 'WEEU-Prod'
$Location = 'WestEurope'
$SubscriptionName = 'Envirotainer Portal - Prod'
# # # TEMP # # #
$SubscriptionName = 'MyEnvirotainer'
# # # TEMP # # # 
$TenantDomain = 'envirotainer.com'



switch ($EnvironmentSuffix.Split('-')[1]) {
    Prod {$Environment = 'Production'}
    Dev {$Environment = 'Development'}
    default {$Environment = 'Unknown'}
}

$TenantId = (Invoke-WebRequest -Uri "https://login.windows.net/$TenantDomain/.well-known/openid-configuration" | ConvertFrom-Json).token_endpoint.Split('/')[3]
$SubscriptionId = (Get-AzSubscription -TenantId $TenantId | Where-Object {$_.Name -eq $SubscriptionName}).Id
Select-AzSubscription -SubscriptionId $SubscriptionId -TenantId $TenantId



# Create Resource Groups

$ResourceGroupNames = `
    'Portal', `
    'DryIce', `
    'Notifications', `
    'OrderManagement', `
    'OrderStatistics'

foreach ($ResourceGroupName in $ResourceGroupNames) {
    New-AzResourceGroup `
        -Name "$ResourceGroupName-$EnvironmentSuffix" `
        -Location $Location `
        -Tag @{Environment = $Environment} `
        -Force
}



# Deploy ARM Template

$FilePath = "C:\Users\MattiasHolm\Documents\GitHub\powershell\Azure\ARM Templates\Envirotainer"
$TemplateFileName = "Envirotainer-Portal.json"
$ParameterFileName = "Envirotainer-Portal-$($EnvironmentSuffix).parameters.json"

New-AzResourceGroupDeployment `
    -ResourceGroupname  "$($ResourceGroupNames[0])-$EnvironmentSuffix" `
    -TemplateFile (Join-Path -Path $FilePath -ChildPath $TemplateFileName) `
    -TemplateParameterFile (Join-Path -Path $FilePath -ChildPath $ParameterFileName) `
    -EnvironmentSuffix $EnvironmentSuffix `
    -Mode Incremental