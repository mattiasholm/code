$Conn = Get-AutomationConnection -Name AzureRunAsConnection

Add-AzureRMAccount -ServicePrincipal -Tenant $Conn.TenantID `
-ApplicationID $Conn.ApplicationID -CertificateThumbprint $Conn.CertificateThumbprint

Start-AzureRmVM -Name 'BLA-DR-JH01' -ResourceGroupName 'RG-Management-DR'