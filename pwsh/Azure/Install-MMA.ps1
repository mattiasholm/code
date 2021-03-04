$WorkspaceId = ""
$WorkspaceKey = ""

$ErrorActionPreference = 'Stop'
$MMADownloadURL = 'https://go.microsoft.com/fwlink/?LinkId=828603'
$MMADownloadFileName = 'MMASetup-AMD64.exe'
$MMADownloadPath = 'C:\Temp'
$MMADownloadFullPath = "$MMADownloadPath\$MMADownloadFileName"
$ExtractedDirectoryName = $MMADownloadFileName.Replace('.exe', '')
$ExtractedDirectoryFullPath = "$MMADownloadPath\$ExtractedDirectoryName"
$ExtractedMsiFilename = 'MOMAgent.msi'
$ExtractedMsiFullPath = "$ExtractedDirectoryFullPath\$ExtractedMsiFilename"
$ArgumentList1 = "/Q /T:$ExtractedDirectoryFullPath /C"
$ArgumentList2 = "/qn NOAPM=1 ADD_OPINSIGHTS_WORKSPACE=1 OPINSIGHTS_WORKSPACE_AZURE_CLOUD_TYPE=0 OPINSIGHTS_WORKSPACE_ID=`"$WorkspaceId`" OPINSIGHTS_WORKSPACE_KEY=`"$WorkspaceKey`" AcceptEndUserLicenseAgreement=1"

New-Item -Path $MMADownloadPath -ItemType 'Directory' -Force | Out-Null
Invoke-WebRequest -Uri $MMADownloadURL -OutFile $MMADownloadFullPath

Start-Process -FilePath $MMADownloadFullPath -ArgumentList $ArgumentList1 -Wait
Start-Process -FilePath $ExtractedMsiFullPath -ArgumentList $ArgumentList2 -Wait

while (Get-Process -Name 'msiexec' -ErrorAction 'SilentlyContinue') {
    Start-Sleep -Seconds 5
}

Start-Service -Name 'HealthService'

Remove-Item $MMADownloadFullPath
Remove-Item $ExtractedDirectoryFullPath -Recurse