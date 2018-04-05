$Conn = Get-AutomationConnection -Name AzureRunAsConnection

Add-AzureRMAccount -ServicePrincipal -Tenant $Conn.TenantID `
-ApplicationID $Conn.ApplicationID -CertificateThumbprint $Conn.CertificateThumbprint

$vnet1 = Get-AzureRmVirtualNetwork -ResourceGroupName 'RG-NETWORK-DR' -Name 'BLA-NET-DR-ONPREM'
$vnet2 = Get-AzureRmVirtualNetwork -ResourceGroupName 'RG-NETWORK-DR' -Name 'BLA-NET-DR-TEST'

Add-AzureRmVirtualNetworkPeering -Name 'DR-ONPREM-to-DR-TEST' -VirtualNetwork $vnet1 -RemoteVirtualNetworkId $vnet2.Id
Add-AzureRmVirtualNetworkPeering -Name 'DR-TEST-to-DR-ONPREM' -VirtualNetwork $vnet2 -RemoteVirtualNetworkId $vnet1.Id