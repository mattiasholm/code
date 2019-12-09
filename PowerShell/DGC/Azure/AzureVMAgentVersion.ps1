Add-AzureAccount | Out-Null

$subscriptions = Get-AzureSubscription
$LatestVersion = "2.7.1198.735"

foreach($subscription in $subscriptions){

Select-AzureSubscription $subscription.SubscriptionName


$vms = Get-AzureVM | Where-Object {$_.PowerState -eq "Started"}

if($vms)
{
    Write-Host "`n$($subscription.SubscriptionName)"
}

foreach($vm in $vms)
{

if($vm.GuestAgentStatus.Status -ne "Ready")
{
    $color = "Red"
}

    elseif($vm.GuestAgentStatus.GuestAgentVersion -ne $LatestVersion)
    {
        $color = "Yellow"
    }

else
{
    $color = "Green"
}

Write-Host -ForegroundColor $color "$($vm.name)`t`t$($vm.GuestAgentStatus.GuestAgentVersion)`t`t$($vm.GuestAgentStatus.Status)"
}
}

Pause