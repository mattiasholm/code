$ErrorActionPreference = 'Stop'
Login-AzAccount



$Suffix = 'WE-Prod'
$Location = 'WestEurope'
$SubscriptionName = 'TruPayers - Red - Prod'
$TenantDomain = 'trupayers.onmicrosoft.com'



switch ($Suffix.Split('-')[1]) {
    Prod {$Environment = 'Production'}
    Dev {$Environment = 'Development'}
    default {$Environment = 'Unknown'}
}

$TenantId = (Invoke-WebRequest -Uri "https://login.windows.net/$TenantDomain/.well-known/openid-configuration" | ConvertFrom-Json).token_endpoint.Split('/')[3]
$SubscriptionId = (Get-AzSubscription -TenantId $TenantId | Where-Object {$_.Name -eq $SubscriptionName}).Id
Select-AzSubscription -SubscriptionId $SubscriptionId -TenantId $TenantId



# Create Resource Groups

$ResourceGroupNames = `
    'Red', `
    'Blue', `
    'Green'

foreach ($ResourceGroupName in $ResourceGroupNames) {
    New-AzResourceGroup `
        -Name "$ResourceGroupName-$Suffix" `
        -Location $Location `
        -Tag @{Environment = $Environment; SecurityLevel = $ResourceGroupName} `
        -Force
}



$Customer = 'TruPayers'
$ArmPath = 'C:\Users\MattiasHolm\Documents\GitHub\powershell\Azure\ARM Templates'
$FilePath = Join-Path -Path $ArmPath -ChildPath $Customer



# Deploy 'Red_PreDeploy'

$Prefix = $ResourceGroupNames[0]
$TemplateFileName = "$Prefix`_PreDeploy.json"
$ParameterFileName = "$Prefix`_PreDeploy.parameters.json"

New-AzResourceGroupDeployment `
    -ResourceGroupname  "$Prefix-$Suffix" `
    -TemplateFile (Join-Path -Path $FilePath -ChildPath $TemplateFileName) `
    -TemplateParameterFile (Join-Path -Path $FilePath -ChildPath $ParameterFileName) `
    -Prefix $Prefix `
    -Suffix $Suffix `
    -Mode Incremental



# Deploy 'Red'

$Prefix = $ResourceGroupNames[0]
$TemplateFileName = "$Prefix.json"
$ParameterFileName = "$Prefix.parameters.json"

New-AzResourceGroupDeployment `
    -ResourceGroupname  "$Prefix-$Suffix" `
    -TemplateFile (Join-Path -Path $FilePath -ChildPath $TemplateFileName) `
    -TemplateParameterFile (Join-Path -Path $FilePath -ChildPath $ParameterFileName) `
    -Prefix $Prefix `
    -Suffix $Suffix `
    -Mode Incremental