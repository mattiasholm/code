$ErrorActionPreference = 'Stop'
$ResourceGroupName = 'Test'
$VirtualNetworkName = "VLan$ResourceGroupName"
$SubnetName = 'default'
$NetworkSecurityGroupName = "VLan$ResourceGroupName-NSG"
$VpnNetworkRange = '172.16.0.0/24'
$Location = 'NorthEurope'



$Conn = Get-AutomationConnection -Name AzureRunAsConnection

Add-AzAccount `
    -ServicePrincipal `
    -Tenant $Conn.TenantID `
    -ApplicationID $Conn.ApplicationID `
    -CertificateThumbprint $Conn.CertificateThumbprint



$Rule1 = New-AzNetworkSecurityRuleConfig `
    -Name 'Allow_VPN_Inbound' `
    -Access Allow `
    -Protocol * `
    -Direction Inbound `
    -Priority 1000 `
    -SourceAddressPrefix $VpnNetworkRange `
    -SourcePortRange * `
    -DestinationAddressPrefix * `
    -DestinationPortRange *

$Rule2 = New-AzNetworkSecurityRuleConfig `
    -Name 'Allow_HTTPS_Inbound' `
    -Access Allow `
    -Protocol Tcp `
    -Direction Inbound `
    -Priority 1100 `
    -SourceAddressPrefix * `
    -SourcePortRange * `
    -DestinationApplicationSecurityGroup (Get-AzApplicationSecurityGroup -Name 'Web' -ResourceGroupName $ResourceGroupName) `
    -DestinationPortRange 443

$Rule3 = New-AzNetworkSecurityRuleConfig `
    -Name 'Deny_All_Inbound' `
    -Access Deny `
    -Protocol * `
    -Direction Inbound `
    -Priority 4096 `
    -SourceAddressPrefix * `
    -SourcePortRange * `
    -DestinationAddressPrefix * `
    -DestinationPortRange *

$Rule4 = New-AzNetworkSecurityRuleConfig `
    -Name 'Allow_HTTP_Outbound' `
    -Access Allow `
    -Protocol Tcp `
    -Direction Outbound `
    -Priority 1000 `
    -SourceAddressPrefix * `
    -SourcePortRange * `
    -DestinationAddressPrefix * `
    -DestinationPortRange 80

$Rule5 = New-AzNetworkSecurityRuleConfig `
    -Name 'Allow_HTTPS_Outbound' `
    -Access Allow `
    -Protocol Tcp `
    -Direction Outbound `
    -Priority 1100 `
    -SourceAddressPrefix * `
    -SourcePortRange * `
    -DestinationAddressPrefix * `
    -DestinationPortRange 443

$Rule6 = New-AzNetworkSecurityRuleConfig `
    -Name 'Allow_DNS_Outbound' `
    -Access Allow `
    -Protocol * `
    -Direction Outbound `
    -Priority 1200 `
    -SourceAddressPrefix * `
    -SourcePortRange * `
    -DestinationAddressPrefix "8.8.8.8", "8.8.4.4" `
    -DestinationPortRange 53

$Rule7 = New-AzNetworkSecurityRuleConfig `
    -Name 'Allow_NTP_Outbound' `
    -Access Allow `
    -Protocol * `
    -Direction Outbound `
    -Priority 1300 `
    -SourceAddressPrefix * `
    -SourcePortRange * `
    -DestinationAddressPrefix * `
    -DestinationPortRange 123

$Rule8 = New-AzNetworkSecurityRuleConfig `
    -Name 'Deny_All_Outbound' `
    -Access Deny `
    -Protocol * `
    -Direction Outbound `
    -Priority 4096 `
    -SourceAddressPrefix * `
    -SourcePortRange * `
    -DestinationAddressPrefix * `
    -DestinationPortRange *



$NetworkSecurityGroup = New-AzNetworkSecurityGroup `
    -Name $NetworkSecurityGroupName `
    -ResourceGroupName $ResourceGroupName `
    -Location $Location `
    -SecurityRules $Rule1, $Rule2, $Rule3, $Rule4, $Rule5, $Rule6, $Rule7, $Rule8 `
    -Force



$VirtualNetwork = Get-AzVirtualNetwork -Name $VirtualNetworkName -ResourceGroupName $ResourceGroupName
$Subnet = Get-AzVirtualNetworkSubnetConfig -Name $SubnetName -VirtualNetwork $VirtualNetwork
$Subnet.NetworkSecurityGroup = $NetworkSecurityGroup
$VirtualNetwork | Set-AzVirtualNetwork