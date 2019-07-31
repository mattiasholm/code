$DiskAlertThresholdHours = 36
$CloudAlertThresholdHours = 60
$DpmServerName = "B3CARE-SE-BAC01.ad.b3care.se"



$Table = @()
$DataSources = Get-DPMDatasource -DPMServerName $DpmServerName

foreach ($DataSource in $DataSources) {
    $RecoveryPoint = Get-RecoveryPoint -Datasource $DataSource | Sort-Object -Property BackupTime -Descending | Select-Object -First 1
    
    if ($null -eq $RecoveryPoint.BackupTime) {
        break
    }
    else {
        $TimeSpan = [Math]::Round((New-TimeSpan -Start $RecoveryPoint.BackupTime -End (Get-Date)).TotalHours)

        $Row = New-Object PSObject
        $Row | Add-Member NoteProperty HoursSinceSuccessfulBackup $TimeSpan
        $Row | Add-Member NoteProperty Location $RecoveryPoint.Location
        $Row | Add-Member NoteProperty ProtectedItem "$($DataSource.Computer)\$($DataSource.Name)"
        $Row | Add-Member NoteProperty RecoveryPointTimestamp $RecoveryPoint.BackupTime
        $Table += $Row
    }

    $RecoveryPoint = Get-RecoveryPoint -Datasource $DataSource -Online | Sort-Object -Property BackupTime -Descending | Select-Object -First 1

    if ($null -eq $RecoveryPoint.BackupTime) {
        break
    }
    else {
        $TimeSpan = [Math]::Round((New-TimeSpan -Start $RecoveryPoint.BackupTime -End (Get-Date)).TotalHours)

        $Row = New-Object PSObject
        $Row | Add-Member NoteProperty HoursSinceSuccessfulBackup $TimeSpan
        $Row | Add-Member NoteProperty Location $RecoveryPoint.Location
        $Row | Add-Member NoteProperty ProtectedItem "$($DataSource.Computer)\$($DataSource.Name)"
        $Row | Add-Member NoteProperty RecoveryPointTimestamp $RecoveryPoint.BackupTime
        $Table += $Row
    }
}

$Table
$Table | Sort-Object -Property HoursSinceSuccessfulBackup -Descending

$Table | Where-Object { $_.Location -eq "Disk" } | Sort-Object -Property HoursSinceSuccessfulBackup -Descending
$Table | Where-Object { $_.Location -eq "Disk" } | Where-Object { $_.HoursSinceSuccessfulBackup -gt $DiskAlertThresholdHours }

$Table | Where-Object { $_.Location -eq "Cloud" } | Sort-Object -Property HoursSinceSuccessfulBackup -Descending
$Table | Where-Object { $_.Location -eq "Cloud" } | Where-Object { $_.HoursSinceSuccessfulBackup -gt $CloudAlertThresholdHours }



$Table | Export-Csv -Path "C:\Temp\DPM_RecoveryPoint_Monitor_$(Get-Date -Format "yyyy-MM-dd_HH-mm-ss").csv" -Delimiter "," -Encoding Unicode -NoTypeInformation