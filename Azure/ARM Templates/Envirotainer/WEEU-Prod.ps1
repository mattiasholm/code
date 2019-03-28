$ErrorActionPreference = 'Stop'
Login-AzAccount



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
    'OrderStatistics', `
    'Content'

foreach ($ResourceGroupName in $ResourceGroupNames) {
    New-AzResourceGroup `
        -Name "$ResourceGroupName-$EnvironmentSuffix" `
        -Location $Location `
        -Tag @{Environment = $Environment} `
        -Force
}



$Customer = 'Envirotainer'
$ArmPath = 'C:\Users\MattiasHolm\Documents\GitHub\powershell\Azure\ARM Templates'
$FilePath = Join-Path -Path $ArmPath -ChildPath $Customer



# Deploy 'Portal'

$Module = $ResourceGroupNames[0]
$TemplateFileName = "$Module.json"
$ParameterFileName = "$Module.parameters.json"

New-AzResourceGroupDeployment `
    -ResourceGroupname  "$Module-$EnvironmentSuffix" `
    -TemplateFile (Join-Path -Path $FilePath -ChildPath $TemplateFileName) `
    -TemplateParameterFile (Join-Path -Path $FilePath -ChildPath $ParameterFileName) `
    -EnvironmentSuffix $EnvironmentSuffix `
    -Module $Module `
    -Mode Incremental



# Deploy 'DryIce'

$Module = $ResourceGroupNames[1]
$TemplateFileName = "$Module.json"
$ParameterFileName = "$Module.parameters.json"

New-AzResourceGroupDeployment `
    -ResourceGroupname  "$Module-$EnvironmentSuffix" `
    -TemplateFile (Join-Path -Path $FilePath -ChildPath $TemplateFileName) `
    -TemplateParameterFile (Join-Path -Path $FilePath -ChildPath $ParameterFileName) `
    -EnvironmentSuffix $EnvironmentSuffix `
    -Module $Module `
    -Mode Incremental



# Deploy 'Notifications'

$Module = $ResourceGroupNames[2]
$TemplateFileName = "$Module.json"
$ParameterFileName = "$Module.parameters.json"

New-AzResourceGroupDeployment `
    -ResourceGroupname  "$Module-$EnvironmentSuffix" `
    -TemplateFile (Join-Path -Path $FilePath -ChildPath $TemplateFileName) `
    -TemplateParameterFile (Join-Path -Path $FilePath -ChildPath $ParameterFileName) `
    -EnvironmentSuffix $EnvironmentSuffix `
    -Module $Module `
    -Mode Incremental



# Deploy 'OrderManagement'

$Module = $ResourceGroupNames[3]
$TemplateFileName = "$Module.json"
$ParameterFileName = "$Module.parameters.json"

New-AzResourceGroupDeployment `
    -ResourceGroupname  "$Module-$EnvironmentSuffix" `
    -TemplateFile (Join-Path -Path $FilePath -ChildPath $TemplateFileName) `
    -TemplateParameterFile (Join-Path -Path $FilePath -ChildPath $ParameterFileName) `
    -EnvironmentSuffix $EnvironmentSuffix `
    -Module $Module `
    -Mode Incremental



# Deploy 'OrderStatistics'

$Module = $ResourceGroupNames[4]
$TemplateFileName = "$Module.json"
$ParameterFileName = "$Module.parameters.json"

New-AzResourceGroupDeployment `
    -ResourceGroupname  "$Module-$EnvironmentSuffix" `
    -TemplateFile (Join-Path -Path $FilePath -ChildPath $TemplateFileName) `
    -TemplateParameterFile (Join-Path -Path $FilePath -ChildPath $ParameterFileName) `
    -EnvironmentSuffix $EnvironmentSuffix `
    -Module $Module `
    -Mode Incremental



# Deploy 'Content'
    
$Module = $ResourceGroupNames[5]
$TemplateFileName = "$Module.json"
$ParameterFileName = "$Module.parameters.json"
    
New-AzResourceGroupDeployment `
    -ResourceGroupname  "$Module-$EnvironmentSuffix" `
    -TemplateFile (Join-Path -Path $FilePath -ChildPath $TemplateFileName) `
    -TemplateParameterFile (Join-Path -Path $FilePath -ChildPath $ParameterFileName) `
    -EnvironmentSuffix $EnvironmentSuffix `
    -Module $Module `
    -Mode Incremental