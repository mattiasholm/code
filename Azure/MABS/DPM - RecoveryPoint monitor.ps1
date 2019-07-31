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