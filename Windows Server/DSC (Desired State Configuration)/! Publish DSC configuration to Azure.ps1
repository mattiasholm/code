$ConfigurationPath = 'C:\Users\MattiasHolm\Documents\GitHub\powershell\Windows Server\DSC (Desired State Configuration)\Install-IIS.ps1'
$OutputPath = 'C:\Temp'



$OutputArchivePath = Join-Path $OutputPath -ChildPath ((Split-Path -Path $ConfigurationPath -Leaf) + '.zip')

Publish-AzureRmVMDscConfiguration `
-ConfigurationPath $ConfigurationPath `
-OutputArchivePath $OutputArchivePath



<#
Add VM Extension 'PowerShell Desired State Configuration' from the Azure Portal

- Configuration Modules or Script: ZIP-file created in previous step, e.g. "C:\Temp\Install-IIS.ps1.zip"
- Module-qualified Name of Configuration: [DscFileName]\[DscConfigurationName], e.g. Install-IIS.ps1\WebServer
- Version: [Latest version of DSC Extension], e.g. 2.76
- Auto Upgrade Minor Version: Yes
#>