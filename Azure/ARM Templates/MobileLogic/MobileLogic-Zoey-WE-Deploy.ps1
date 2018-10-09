$EnvironmentPrefix = 'Zoey-WE'
$Location = 'WestEurope'
$SubscriptionName = 'Zoey (Prod)'
$TenantDomain = 'mobilelogic.se'



$ErrorActionPreference = 'Stop'
Add-AzureRmAccount
# mattias.holm@mobilelogic.se



$TenantId = (Invoke-WebRequest -Uri "https://login.windows.net/$TenantDomain/.well-known/openid-configuration" | ConvertFrom-Json).token_endpoint.Split('/')[3]
$SubscriptionId = (Get-AzureRmSubscription -TenantId $TenantId | Where-Object {$_.Name -eq $SubscriptionName}).Id
Select-AzureRmSubscription -SubscriptionId $SubscriptionId -TenantId $TenantId



# Create Resource Groups

$ResourceGroupNames = `
    'KeyVault', `
    'ServiceFabric', `
    'DataServices', `
    'AppServices', `
    'Backup'

foreach ($ResourceGroupName in $ResourceGroupNames) {
    New-AzureRmResourceGroup `
        -Name "$EnvironmentPrefix-$ResourceGroupName" `
        -Location $Location `
        -Force
}





# Deploy ARM Template "FirstTimeDeploy"

$TemplateFilePath = "C:\Users\MattiasHolm\Documents\GitHub\powershell\Azure\ARM Templates\MobileLogic\MobileLogic-FirstTimeDeploy.json"
$ParameterFilePath = "C:\Users\MattiasHolm\Documents\GitHub\powershell\Azure\ARM Templates\MobileLogic\MobileLogic-$($EnvironmentPrefix).parameters.json"

New-AzureRmResourceGroupDeployment `
    -ResourceGroupname  "$EnvironmentPrefix-KeyVault" `
    -TemplateFile $TemplateFilePath `
    -TemplateParameterFile $ParameterFilePath `
    -Mode Incremental





# # # Manuella steg efter "FirstTimeDeploy":
# Generera SF-certifikat och ladda upp som Secret i KeyVault, uppdatera parameter i JSON-fil
# Generera adminlösenord och ladda upp som Secret i KeyVault, uppdatera parameter i JSON-fil
# Ladda upp P2S-rotcertifikat som Secret i KeyVault, uppdatera parameter i JSON-fil





# Deploy ARM Template

$TemplateFilePath = "C:\Users\MattiasHolm\Documents\GitHub\powershell\Azure\ARM Templates\MobileLogic\MobileLogic.json"
$ParameterFilePath = "C:\Users\MattiasHolm\Documents\GitHub\powershell\Azure\ARM Templates\MobileLogic\MobileLogic-$($EnvironmentPrefix).parameters.json"

New-AzureRmResourceGroupDeployment `
    -ResourceGroupname  "$EnvironmentPrefix-ServiceFabric" `
    -TemplateFile $TemplateFilePath `
    -TemplateParameterFile $ParameterFilePath `
    -Mode Incremental