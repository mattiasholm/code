$ErrorActionPreference = 'Stop'
$ResourceGroupName = 'Test'
$VirtualNetworkName = "VLan$ResourceGroupName"
$SubnetName = 'default'
$NetworkSecurityGroupName = "VLan$ResourceGroupName-NSG"
$Location = 'NorthEurope'



$Conn = Get-AutomationConnection -Name AzureRunAsConnection

Add-AzAccount `
    -ServicePrincipal `
    -Tenant $Conn.TenantID `
    -ApplicationID $Conn.ApplicationID `
    -CertificateThumbprint $Conn.CertificateThumbprint


    
$ApplicationSecurityGroup = New-AzApplicationSecurityGroup -Name 'Web' -ResourceGroupName $ResourceGroupName



<#





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


#>