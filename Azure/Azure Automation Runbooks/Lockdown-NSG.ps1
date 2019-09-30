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
    -Name 'Deny_All_Inbound' `
    -Access Deny `
    -Protocol * `
    -Direction Inbound `
    -Priority 4096 `
    -SourceAddressPrefix * `
    -SourcePortRange * `
    -DestinationAddressPrefix * `
    -DestinationPortRange *

$Rule3 = New-AzNetworkSecurityRuleConfig `
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
    -SecurityRules $Rule1, $Rule2, $Rule3 `
    -Force



$VirtualNetwork = Get-AzVirtualNetwork -Name $VirtualNetworkName -ResourceGroupName $ResourceGroupName
$Subnet = Get-AzVirtualNetworkSubnetConfig -Name $SubnetName -VirtualNetwork $VirtualNetwork
$Subnet.NetworkSecurityGroup = $NetworkSecurityGroup
$VirtualNetwork | Set-AzVirtualNetwork