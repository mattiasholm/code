$SubscriptionId = '18acfa7a-785b-4c49-980d-b0ee07a7364a'
$ResourceGroupName = 'HolmLekstuga2'
$Location = 'WestEurope'



Add-AzureRmAccount

Select-AzureRmSubscription -Subscription $SubscriptionId

New-AzureRmResourceGroup -ResourceGroupName $ResourceGroupName -Location $Location


$webAsg = New-AzureRmApplicationSecurityGroup -ResourceGroupName $ResourceGroupName -Name myAsgWebServers -Location $Location

$mgmtAsg = New-AzureRmApplicationSecurityGroup -ResourceGroupName $ResourceGroupName -Name myAsgMgmtServers -Location $Location


$webRule = New-AzureRmNetworkSecurityRuleConfig `
  -Name "Allow-Web-All" `
  -Access Allow `
  -Protocol Tcp `
  -Direction Inbound `
  -Priority 100 `
  -SourceAddressPrefix Internet `
  -SourcePortRange * `
  -DestinationApplicationSecurityGroupId $webAsg.id `
  -DestinationPortRange 80,443


  $mgmtRule = New-AzureRmNetworkSecurityRuleConfig `
  -Name "Allow-RDP-All" `
  -Access Allow `
  -Protocol Tcp `
  -Direction Inbound `
  -Priority 110 `
  -SourceAddressPrefix Internet `
  -SourcePortRange * `
  -DestinationApplicationSecurityGroupId $mgmtAsg.id `
  -DestinationPortRange 3389


  $nsg = New-AzureRmNetworkSecurityGroup `
  -ResourceGroupName $ResourceGroupName `
  -Location $Location `
  -Name myNsg `
  -SecurityRules $webRule,$mgmtRule

  $nsg