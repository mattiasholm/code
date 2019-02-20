$ErrorActionPreference = 'Stop'
Add-AzureRmAccount
# mattias.holm@b3itadmin.onmicrosoft.com
# # # BYT UT MOT DEDIKERAT ENVIROTAINER-KONTO OM STRUL MED CSP!



$EnvironmentSuffix = 'WEEU-Prod'
$Location = 'WestEurope'
$SubscriptionName = '???'
$TenantDomain = '???'



switch ($EnvironmentSuffix.Split('-')[1])
{
    Prod {$Environment = 'Production'}
    Dev {$Environment = 'Development'}
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



# # # FirstTimeDeploy
# Deploya ARM Template "LogicCenter_PreDeploy" för att skapa upp KeyVault
# Lägg upp önskat adminanvändarnamn som Secret i KeyVault, uppdatera parameter i JSON-fil
# Generera adminlösenord och ladda upp som Secret i KeyVault, uppdatera parameter i JSON-fil
# Ladda upp P2S-rotcertifikat som Secret i KeyVault, uppdatera parameter i JSON-fil
# Ladda upp wildcard-certifikat som Secret i KeyVault, uppdatera parameter i JSON-fil
# Deploya ARM Template "MobileLogic" en första gång
# Deploya ARM Template "LogicCenter_PostDeploy" för att konfigurera klart KeyVault.
# Deploya ARM Template "MobileLogic" en andra gång



# Deploy ARM Template

$TemplateFilePath = "C:\Users\MattiasHolm\Documents\GitHub\powershell\Azure\ARM Templates\MobileLogic\Envirotainer-Portal.json"
$ParameterFilePath = "C:\Users\MattiasHolm\Documents\GitHub\powershell\Azure\ARM Templates\MobileLogic\Envirotainer-Portal-$($EnvironmentSuffix).parameters.json"

New-AzureRmResourceGroupDeployment `
    -ResourceGroupname  "$($ResourceGroupNames[0])-$EnvironmentSuffix" `
    -TemplateFile $TemplateFilePath `
    -TemplateParameterFile $ParameterFilePath `
    -Mode Incremental #-Verbose