$ConfigPath = '.\Config.xml'
[xml]$Config = Get-Content $ConfigPath

$CsvFilePath = $Config.Parameters.CsvFilePath
$TestFilePath = $Config.Parameters.TestFilePath

$ErrorActionPreference = 'SilentlyContinue'

if (Test-Path -Path $CsvFilePath) {
    $Servers = Import-Csv $CsvFilePath
}
else {
    Write-Host -ForegroundColor Red -Object "Failed to find CSV file`t`t$CsvFilePath"
    Pause
    break
}

foreach ($Server in $Servers) {

    $UncRootPath = (Join-Path -Path "\\$($Server.ServerName)" -ChildPath $TestFilePath).Replace(':', '$')

    $FileName = "Testfil_*.txt"

    $UncFilePath = (Join-Path -Path $UncRootPath -ChildPath $FileName)

    if (Test-Path -Path $UncFilePath) {
        Remove-Item -Path $UncFilePath
        
        if (!(Test-Path -Path $UncFilePath)) {
            Write-Host -ForegroundColor Green -Object "$($Server.ServerName)`t`tSuccessfully deleted test file(s)"
        }
    }
    else {
        Write-Host -ForegroundColor Yellow -Object "$($Server.ServerName)`t`tTest file(s) no longer exists"
    }
}

Pause