#!/usr/bin/env pwsh

$Uri = 'https://login.b3care.se'
$LogPath = 'C:\Temp\MonitorHttpEndpoint_login_b3care_se.log'
$IntervalSeconds = 5
$TraceTimeout = 60
$ExoCredential = Get-Credential -UserName 'support@b3.se' -Message 'Enter password'
$Hostname = 'netscaler.b3care.se'
$Username = 'nsroot'
$NetScalerPassword = Read-Host -Prompt "Enter nsroot password" -AsSecureString

if (!($ExoCredential) -or $([Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($NetScalerPassword))).Length -eq 0) {
    Write-Host -ForegroundColor Red 'Missing password/credential'
    break
}

function GetWebSiteStatusCode {
    param (
        [string] $TestUri,
        $MaximumRedirection = 5
    )
    $Request = $null
    try {
        $Request = Invoke-WebRequest -Uri $TestUri -MaximumRedirection $MaximumRedirection -ErrorAction SilentlyContinue
    } 
    catch [System.Net.WebException] {
        $Request = $_.Exception.Response

    }
    catch {
        Write-Error $_.Exception
        return $null
    }
    $Request.StatusCode
}

$TraceStarted = $false

while ($true) {
    $StatusCode = $null
    $StatusCode = GetWebSiteStatusCode -TestUri $Uri
    $Timestamp = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'

    if ($TraceStarted -eq $true) {
        $TraceTimeout = $TraceTimeout - $IntervalSeconds
    }

    if ($StatusCode -eq 200) {
        Write-Host -ForegroundColor Green -NoNewline "Site up"
        Write-Host "`t`t$StatusCode`t$Uri`t`t$Timestamp"

        "$Timestamp`tSITE UP`t`t`t$StatusCode`t`t$Uri" | Out-File -Append -FilePath $LogPath   
    }
    else {
        Write-Host -ForegroundColor Red -NoNewline "Site down"
        Write-Host "`t$StatusCode`t$Uri`t`t$Timestamp"

        "$Timestamp`tSITE DOWN`t`t$StatusCode`t$Uri" | Out-File -Append -FilePath $LogPath

        Send-MailMessage `
            -From 'support@b3.se' `
            -To 'm@b3.se' `
            -Subject "Site down - $Uri" `
            -Body "Site down`t`t$StatusCode`t$Uri`t$Timestamp" `
            -SmtpServer 'smtp.office365.com' `
            -Port 587 `
            -UseSsl `
            -Credential $ExoCredential


        if ($TraceStarted -eq $false) {
            $CliCommand = "start nstrace -size 0 -nf 1 -capsslkeys ENABLED"
            plink -ssh $Username@$Hostname -pw $([Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($NetScalerPassword))) $CliCommand
            $TraceStarted = $true
        }
    }

    if ($TraceTimeout -le 0) {
        $CliCommand = "stop nstrace"
        plink -ssh $Username@$Hostname -pw $([Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($NetScalerPassword))) $CliCommand
        break
    }

    Start-Sleep $IntervalSeconds
}