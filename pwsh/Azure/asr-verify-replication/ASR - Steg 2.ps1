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
        $LatestTestFile = (Get-ChildItem -Path $UncFilePath | Sort-Object -Property Name -Descending | Select-Object -First 1).Name
        Write-Host -ForegroundColor Green -Object ("$($Server.ServerName)`t`tSuccessfully found latest test file`t`t$LatestTestFile").Replace('Testfil_','').Replace('.txt','').Replace('.',':')
    }
    else {
        Write-Host -ForegroundColor Red -Object "$($Server.ServerName)`t`tFailed to find test file(s)"
    }
}

Pause