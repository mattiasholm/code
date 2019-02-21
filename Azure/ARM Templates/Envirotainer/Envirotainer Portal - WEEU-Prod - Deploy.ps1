$ErrorActionPreference = 'Stop'
Add-AzureRmAccount



$EnvironmentSuffix = 'WEEU-Prod'
$Location = 'WestEurope'
$SubscriptionName = 'Envirotainer Portal - Prod'
$TenantDomain = 'envirotainer.com'

# # # TEMP # # #
$SubscriptionName = 'B3IT Cloud Services - Test'
$TenantDomain = 'b3.se'
# # # TEMP # # #



switch ($EnvironmentSuffix.Split('-')[1])
{
    Prod {$Environment = 'Production'}
    Dev {$Environment = 'Development'}
    default {$Environment = 'Unknown'}
}

$TenantId = (Invoke-WebRequest -Uri "https://login.windows.net/$TenantDomain/.well-known/openid-configuration" | ConvertFrom-Json).token_endpoint.Split('/')[3]
$SubscriptionId = (Get-AzureRmSubscription -TenantId $TenantId | Where-Object {$_.Name -eq $SubscriptionName}).Id
Select-AzureRmSubscription -SubscriptionId $SubscriptionId -TenantId $TenantId



# Create Resource Groups

$ResourceGroupNames = `
    'Portal', `
    'DryIce', `
    'Notifications', `
    'OrderManagement', `
    'OrderStatistics'

foreach ($ResourceGroupName in $ResourceGroupNames) {
    New-AzureRmResourceGroup `
        -Name "$ResourceGroupName-$EnvironmentSuffix" `
        -Location $Location `
        -Tag @{Environment=$Environment} `
        -Force
}



# Deploy ARM Template

$FilePath = "C:\Users\MattiasHolm\Documents\GitHub\powershell\Azure\ARM Templates\Envirotainer"
$TemplateFileName = "Envirotainer-Portal.json"
$ParameterFileName = "Envirotainer-Portal-$($EnvironmentSuffix).parameters.json"

New-AzureRmResourceGroupDeployment `
    -ResourceGroupname  "$($ResourceGroupNames[0])-$EnvironmentSuffix" `
    -TemplateFile (Join-Path -Path $FilePath -ChildPath $TemplateFileName) `
    -TemplateParameterFile (Join-Path -Path $FilePath -ChildPath $ParameterFileName) `
    -EnvironmentSuffix $EnvironmentSuffix `
    -Mode Incremental