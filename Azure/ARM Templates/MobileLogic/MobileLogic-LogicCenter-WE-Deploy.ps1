$ErrorActionPreference = 'Stop'
Add-AzureRmAccount
# mattias.holm@mobilelogic.se



$EnvironmentPrefix = 'LogicCenter-WE'
$Location = 'WestEurope'
$SubscriptionName = 'LogicCenter (Gemensam)'
$TenantDomain = 'mobilelogic.se'



$TenantId = (Invoke-WebRequest -Uri "https://login.windows.net/$TenantDomain/.well-known/openid-configuration" | ConvertFrom-Json).token_endpoint.Split('/')[3]
$SubscriptionId = (Get-AzureRmSubscription -TenantId $TenantId | Where-Object {$_.Name -eq $SubscriptionName}).Id
Select-AzureRmSubscription -SubscriptionId $SubscriptionId -TenantId $TenantId



# Create Resource Groups

$ResourceGroupNames = `
    'KeyVault', `
    'AppServices', `
    'DataServices'

foreach ($ResourceGroupName in $ResourceGroupNames) {
    New-AzureRmResourceGroup `
        -Name "$EnvironmentPrefix-$ResourceGroupName" `
        -Location $Location `
        -Force
}



# Deploy ARM Template

$TemplateFilePath = "C:\Users\MattiasHolm\Documents\GitHub\powershell\Azure\ARM Templates\MobileLogic\MobileLogic-LogicCenter.json"
$ParameterFilePath = "C:\Users\MattiasHolm\Documents\GitHub\powershell\Azure\ARM Templates\MobileLogic\MobileLogic-$($EnvironmentPrefix).parameters.json"

New-AzureRmResourceGroupDeployment `
    -ResourceGroupname  "$EnvironmentPrefix-KeyVault" `
    -TemplateFile $TemplateFilePath `
    -TemplateParameterFile $ParameterFilePath `
    -Mode Incremental