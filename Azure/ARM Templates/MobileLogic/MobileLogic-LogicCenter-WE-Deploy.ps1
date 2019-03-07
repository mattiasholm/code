$ErrorActionPreference = 'Stop'
Add-AzureRmAccount
# mattias.holm@mobilelogic.se



$EnvironmentPrefix = 'LogicCenter-WE'
$Location = 'WestEurope'
$SubscriptionName = 'LogicCenter'
$TenantDomain = 'mobilelogic.se'



switch ($EnvironmentPrefix.Split('-')[0]) {
    Zoey {$Environment = 'Production'}
    Leo {$Environment = 'Test'}
    LogicCenter {$Environment = 'Shared'}
    default {$Environment = 'Unknown'}
}

$TenantId = (Invoke-WebRequest -Uri "https://login.windows.net/$TenantDomain/.well-known/openid-configuration" | ConvertFrom-Json).token_endpoint.Split('/')[3]
$SubscriptionId = (Get-AzureRmSubscription -TenantId $TenantId | Where-Object {$_.Name -eq $SubscriptionName}).Id
Select-AzureRmSubscription -SubscriptionId $SubscriptionId -TenantId $TenantId



# Create Resource Groups

$ResourceGroupNames = `
    'KeyVault', `
    'DataServices'

foreach ($ResourceGroupName in $ResourceGroupNames) {
    New-AzureRmResourceGroup `
        -Name "$EnvironmentPrefix-$ResourceGroupName" `
        -Location $Location `
        -Tag @{Environment = $Environment} `
        -Force
}



# Deploy ARM Template "PreDeploy"

$TemplateFilePath = "C:\Users\MattiasHolm\Documents\GitHub\powershell\Azure\ARM Templates\MobileLogic\MobileLogic-LogicCenter_PreDeploy.json"
$ParameterFilePath = "C:\Users\MattiasHolm\Documents\GitHub\powershell\Azure\ARM Templates\MobileLogic\MobileLogic-$($EnvironmentPrefix).parameters.json"

New-AzureRmResourceGroupDeployment `
    -ResourceGroupname  "$EnvironmentPrefix-$($ResourceGroupNames[0])" `
    -TemplateFile $TemplateFilePath `
    -TemplateParameterFile $ParameterFilePath `
    -Mode Incremental



# Deploy ARM Template "PostDeploy"

$TemplateFilePath = "C:\Users\MattiasHolm\Documents\GitHub\powershell\Azure\ARM Templates\MobileLogic\MobileLogic-LogicCenter_PostDeploy.json"
$ParameterFilePath = "C:\Users\MattiasHolm\Documents\GitHub\powershell\Azure\ARM Templates\MobileLogic\MobileLogic-$($EnvironmentPrefix).parameters.json"

New-AzureRmResourceGroupDeployment `
    -ResourceGroupName  "$EnvironmentPrefix-$($ResourceGroupNames[0])" `
    -TemplateFile $TemplateFilePath `
    -TemplateParameterFile $ParameterFilePath `
    -EnvironmentSuffix $EnvironmentSuffix `
    -Mode Incremental