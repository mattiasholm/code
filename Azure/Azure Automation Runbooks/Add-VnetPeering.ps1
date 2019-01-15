# This runbook requires that the module "AzureRM.Network" is manually added to the Azure Automation Account

Param
(
  [Parameter (Mandatory= $true)]
  [String] $VNet1_Name,

  [Parameter (Mandatory= $true)]
  [String] $VNet1_ResourceGroup,
  
  [Parameter (Mandatory= $true)]
  [String] $VNet2_Name,

  [Parameter (Mandatory= $true)]
  [String] $VNet2_ResourceGroup
)



$Conn = Get-AutomationConnection -Name AzureRunAsConnection

Add-AzureRMAccount -ServicePrincipal -Tenant $Conn.TenantID `
-ApplicationID $Conn.ApplicationID -CertificateThumbprint $Conn.CertificateThumbprint

$VNet1 = Get-AzureRmVirtualNetwork -Name $VNet1_Name -ResourceGroupName $VNet1_ResourceGroup
$VNet2 = Get-AzureRmVirtualNetwork -Name $VNet2_Name -ResourceGroupName $VNet2_ResourceGroup

Add-AzureRmVirtualNetworkPeering -Name "$VNet1_Name-to-$VNet2_Name" -VirtualNetwork $VNet1 -RemoteVirtualNetworkId $VNet2.Id
Add-AzureRmVirtualNetworkPeering -Name "$VNet2_Name-to-$VNet1_Name" -VirtualNetwork $VNet2 -RemoteVirtualNetworkId $VNet1.Id