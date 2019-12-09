Add-AzureAccount | Out-Null

$subscriptions = Get-AzureSubscription

foreach($subscription in $subscriptions){
Select-AzureSubscription $subscription.SubscriptionName
Write-Host "`n$($subscription.SubscriptionName)"


[int]$maxVMCores     = (Get-AzureSubscription -current -ExtendedDetails).maxcorecount
[int]$currentVMCores = (Get-AzureSubscription -current -ExtendedDetails).currentcorecount
[int]$availableCores = $maxVMCores - $currentVMCores

[int]$MaxDnsServers = (Get-AzureSubscription -Current -ExtendedDetails).maxdnsservers
[int]$CurrentDnsServers = (Get-AzureSubscription -Current -ExtendedDetails).currentdnsservers
[int]$availableDnsServers = $MaxDnsServers - $CurrentDnsServers

[int]$MaxHostedServices = (Get-AzureSubscription -Current -ExtendedDetails).maxhostedservices
[int]$CurrentHostedServices = (Get-AzureSubscription -Current -ExtendedDetails).currenthostedservices
[int]$availablehostedservices = $MaxHostedServices - $CurrentHostedServices

[int]$MaxLocalNetworkSites = (Get-AzureSubscription -Current -ExtendedDetails).maxlocalnetworksites
[int]$CurrentLocalNetworkSites = (Get-AzureSubscription -Current -ExtendedDetails).currentlocalnetworksites
[int]$availableLocalNetworkSites = $MaxLocalNetworkSites - $CurrentLocalNetworkSites

[int]$MaxVirtualNetworkSites = (Get-AzureSubscription -Current -ExtendedDetails).maxvirtualnetworksites
[int]$CurrentVirtualNetworkSites = (Get-AzureSubscription -Current -ExtendedDetails).currentvirtualnetworksites
[int]$availableVirtualNetworkSites = $MaxVirtualNetworkSites - $CurrentVirtualNetworkSites

[int]$MaxStorageAccounts = (Get-AzureSubscription -Current -ExtendedDetails).maxStorageAccounts
[int]$CurrentStorageAccounts = (Get-AzureSubscription -Current -ExtendedDetails).currentStorageAccounts
[int]$availableStorageAccounts = $MaxStorageAccounts - $CurrentStorageAccounts



if($availableCores -le 10)
{
    $color = "Red"
}

    elseif($availableCores -le 20)
    {
        $color = "Yellow"
    }

else
{
    $color = "Green"
}

Write-Host -ForegroundColor $color "$availableCores cores available"

if($availableDnsServers -le 2)
{
    $color = "Red"
}

    elseif($availableDnsServers -le 5)
    {
        $color = "Yellow"
    }

else
{
    $color = "Green"
}

Write-Host -ForegroundColor $color "$availableDnsServers DNS Servers available"

if($availablehostedservices -le 5)
{
    $color = "Red"
}

    elseif($availablehostedservices -le 10)
    {
        $color = "Yellow"
    }

else
{
    $color = "Green"
}

Write-Host -ForegroundColor $color "$availablehostedservices Cloud Services available"

if($availableLocalNetworkSites -le 5)
{
    $color = "Red"
}

    elseif($availableLocalNetworkSites -le 10)
    {
        $color = "Yellow"
    }

else
{
    $color = "Green"
}

Write-Host -ForegroundColor $color "$availableLocalNetworkSites Local Network Sites available"

if($availableVirtualNetworkSites -le 5)
{
    $color = "Red"
}

    elseif($availableVirtualNetworkSites -le 10)
    {
        $color = "Yellow"
    }

else
{
    $color = "Green"
}

Write-Host -ForegroundColor $color "$availableVirtualNetworkSites Virtual Networks available"

if($availableStorageAccounts -le 5)
{
    $color = "Red"
}

    elseif($availableStorageAccounts -le 10)
    {
        $color = "Yellow"
    }

else
{
    $color = "Green"
}

Write-Host -ForegroundColor $color "$availableStorageAccounts Storage Accounts available"

}
Pause