$Conn = Get-AutomationConnection -Name AzureRunAsConnection

Add-AzureRMAccount -ServicePrincipal -Tenant $Conn.TenantID `
-ApplicationID $Conn.ApplicationID -CertificateThumbprint $Conn.CertificateThumbprint

Remove-AzureRmVirtualNetworkPeering -Name 'DR-ONPREM-to-DR-TEST' -VirtualNetwork 'BLA-NET-DR-ONPREM' -ResourceGroupName 'RG-NETWORK-DR' -Force
Remove-AzureRmVirtualNetworkPeering -Name 'DR-TEST-to-DR-ONPREM' -VirtualNetwork 'BLA-NET-DR-TEST' -ResourceGroupName 'RG-NETWORK-DR' -Force