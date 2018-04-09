$Conn = Get-AutomationConnection -Name AzureRunAsConnection

Add-AzureRMAccount -ServicePrincipal -Tenant $Conn.TenantID `
-ApplicationID $Conn.ApplicationID -CertificateThumbprint $Conn.CertificateThumbprint

Stop-AzureRmVM -Name 'BLA-DR-JH01' -ResourceGroupName 'RG-Management-DR' -Force -StayProvisioned