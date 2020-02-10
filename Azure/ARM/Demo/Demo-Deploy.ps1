$ErrorActionPreference = 'Stop'
Add-AzAccount
# admin.mattias.holm@b3.se



$EnvironmentPrefix = 'Demo'
$Location = 'WestEurope'
$SubscriptionName = 'B3IT Cloud Services - Test'
$TenantDomain = 'b3.se'



$TenantId = (Invoke-WebRequest -Uri "https://login.windows.net/$TenantDomain/.well-known/openid-configuration" | ConvertFrom-Json).token_endpoint.Split('/')[3]
$SubscriptionId = (Get-AzSubscription -TenantId $TenantId | Where-Object {$_.Name -eq $SubscriptionName}).Id
Select-AzSubscription -SubscriptionId $SubscriptionId -TenantId $TenantId



# Create Resource Group

$ResourceGroupNames = `
    'Core', `
    'VM', `
    'Web', `
    'DB'

foreach ($ResourceGroupName in $ResourceGroupNames) {
    New-AzResourceGroup `
        -Name "$EnvironmentPrefix-$ResourceGroupName" `
        -Location $Location `
        -Force
}



# Deploy ARM Template

$TemplateFilePath = "/Users/mattiasholm/Documents/GitHub/powershell/Azure/ARM templates/Demo/Demo.json"
$ParameterFilePath = "/Users/mattiasholm/Documents/GitHub/powershell/Azure/ARM templates/Demo/Demo.parameters.json"

New-AzResourceGroupDeployment `
    -ResourceGroupname  "$EnvironmentPrefix-$($ResourceGroupNames[0])" `
    -TemplateFile $TemplateFilePath `
    -TemplateParameterFile $ParameterFilePath `
    -Mode Incremental #-Verbose