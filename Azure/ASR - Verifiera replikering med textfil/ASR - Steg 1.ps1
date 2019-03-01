$ConfigPath = '.\Config.xml'
[xml]$Config = Get-Content $ConfigPath

$CsvFilePath = $Config.Parameters.CsvFilePath
$TestFilePath = $Config.Parameters.TestFilePath

$ErrorActionPreference = 'SilentlyContinue'

if (Test-Path -Path $CsvFilePath) {
    $Servers = Import-Csv $CsvFilePath
}
else {
    Write-Host -ForegroundColor Red -Object "Failed to find CSV file - $CsvFilePath"
    Pause
    break
}

foreach ($Server in $Servers) {

    $UncRootPath = (Join-Path -Path "\\$($Server.ServerName)" -ChildPath $TestFilePath).Replace(':', '$')

    if (!(Test-Path -Path $UncRootPath)) {
        New-Item -ItemType Directory -Path $UncRootPath | Out-Null
    }

    $TimeStamp = Get-Date -Format 'yyyy-MM-dd HH.mm.ss'
    $FileName = "Testfil_$TimeStamp.txt"
    $UncFilePath = (Join-Path -Path $UncRootPath -ChildPath $FileName)

    New-Item -ItemType File -Path $UncFilePath -Value "Testfil skapad $TimeStamp" | Out-Null

    if (Test-Path -Path $UncFilePath) {
        Write-Host -ForegroundColor Green -Object "$($Server.ServerName) - Successfully created test file - $FileName"
    }
    else {
        Write-Host -ForegroundColor Red -Object "$($Server.ServerName) - Failed to create test file - $FileName"
    }
}

Pause