$ErrorActionPreference = 'Stop'
Add-AzureRmAccount
# mattias.holm@mobilelogic.se



$EnvironmentPrefix = 'Leo-WE'
$Location = 'WestEurope'
$SubscriptionName = 'LogicCenter'
$TenantDomain = 'mobilelogic.se'



$TenantId = (Invoke-WebRequest -Uri "https://login.windows.net/$TenantDomain/.well-known/openid-configuration" | ConvertFrom-Json).token_endpoint.Split('/')[3]
$SubscriptionId = (Get-AzureRmSubscription -TenantId $TenantId | Where-Object {$_.Name -eq $SubscriptionName}).Id
Select-AzureRmSubscription -SubscriptionId $SubscriptionId -TenantId $TenantId



# Create Resource Groups

$ResourceGroupNames = `
    'ServiceFabric', `
    'DataServices', `
    'AppServices'

foreach ($ResourceGroupName in $ResourceGroupNames) {
    New-AzureRmResourceGroup `
        -Name "$EnvironmentPrefix-$ResourceGroupName" `
        -Location $Location `
        -Force
}



# # # Prereqs vid first time deploy:
# Deploya ARM Template "LogicCenter" för att skapa upp KeyVault
# Generera SF-certifikat och ladda upp som Secret i KeyVault, uppdatera parameter i JSON-fil
# Lägg upp önskat adminanvändarnamn som Secret i KeyVault, uppdatera parameter i JSON-fil
# Generera adminlösenord och ladda upp som Secret i KeyVault, uppdatera parameter i JSON-fil
# Ladda upp P2S-rotcertifikat som Secret i KeyVault, uppdatera parameter i JSON-fil
# Ladda upp wildcard-certifikat som Secret i KeyVault, uppdatera parameter i JSON-fil



# Deploy ARM Template

$TemplateFilePath = "C:\Users\MattiasHolm\Documents\GitHub\powershell\Azure\ARM Templates\MobileLogic\MobileLogic.json"
$ParameterFilePath = "C:\Users\MattiasHolm\Documents\GitHub\powershell\Azure\ARM Templates\MobileLogic\MobileLogic-$($EnvironmentPrefix).parameters.json"

New-AzureRmResourceGroupDeployment `
    -ResourceGroupname  "$EnvironmentPrefix-ServiceFabric" `
    -TemplateFile $TemplateFilePath `
    -TemplateParameterFile $ParameterFilePath `
    -Mode Incremental