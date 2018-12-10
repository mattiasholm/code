$Uri = 'https://login.b3care.se'
#$Uri = 'https://support.b3.se/foobar'
$LogPath = 'C:\Temp\MonitorHttpEndpoint_login_b3care_se.log'
$Credential = Get-Credential -UserName 'support@b3.se' -Message 'Enter password'


if (!($Credential)) {
    Write-Host -ForegroundColor Red 'No credentials entered'
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



while ($true) {
    
    $StatusCode = GetWebSiteStatusCode -TestUri $Uri
    $Timestamp = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'

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
            -Credential $Credential
    }

    Start-Sleep 5
}