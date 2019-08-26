$DiskAlertThresholdHours = 36
$CloudAlertThresholdHours = 60
$DpmServerName = "B3CARE-SE-BAC01.ad.b3care.se"



$Table = @()
$DataSources = Get-DPMDatasource -DPMServerName $DpmServerName | Where-Object { $_.Protected -eq $true }

foreach ($DataSource in $DataSources) {

    $RecoveryPoints = @()
    $RecoveryPoints += Get-RecoveryPoint -Datasource $DataSource | Sort-Object -Property BackupTime -Descending | Select-Object -First 1
    $RecoveryPoints += Get-RecoveryPoint -Datasource $DataSource -Online | Sort-Object -Property BackupTime -Descending | Select-Object -First 1
    
    if (!($RecoveryPoints)) {
        $Row = New-Object PSObject
        $Row | Add-Member NoteProperty HoursSinceSuccessfulBackup $null
        $Row | Add-Member NoteProperty Location $null
        $Row | Add-Member NoteProperty BackupType $null
        $Row | Add-Member NoteProperty ServerName $DataSource.Computer
        $Row | Add-Member NoteProperty BackupName $DataSource.Name
        $Row | Add-Member NoteProperty LastBackupSize $null
        $Row | Add-Member NoteProperty LastFullBackupDate $null
        $Table += $Row
    }
    
    foreach ($RecoveryPoint in $RecoveryPoints) {
        $TimeSpan = [Math]::Round((New-TimeSpan -Start $RecoveryPoint.BackupTime -End (Get-Date)).TotalHours)

        switch ($RecoveryPoint.Location) {
            Disk { $BackupType = 2 }
            Cloud { $BackupType = 3 }
            default { $BackupType = $null }
        }

        $RecoveryPointSize = [Math]::Round(($RecoveryPoint.Size) / 1MB, 2)
               
        $Row = New-Object PSObject
        $Row | Add-Member NoteProperty HoursSinceSuccessfulBackup $TimeSpan
        $Row | Add-Member NoteProperty Location $RecoveryPoint.Location
        $Row | Add-Member NoteProperty BackupType $BackupType
        $Row | Add-Member NoteProperty ServerName $DataSource.Computer
        $Row | Add-Member NoteProperty BackupName $DataSource.Name
        $Row | Add-Member NoteProperty LastBackupSize $RecoveryPointSize
        $Row | Add-Member NoteProperty LastFullBackupDate $RecoveryPoint.BackupTime
        $Table += $Row
    }
}

$Table | Format-Table

$Table | Sort-Object -Property HoursSinceSuccessfulBackup | Format-Table

$Table | Export-Csv -Path "C:\Temp\DPM_RecoveryPoint_Monitor_$(Get-Date -Format "yyyy-MM-dd_HH-mm-ss").csv" -Delimiter "," -Encoding Unicode -NoTypeInformation



if ($Table | Where-Object { $_.Location -eq "Disk" } | Where-Object { $_.HoursSinceSuccessfulBackup -gt $DiskAlertThresholdHours }) {
    Write-Host -ForegroundColor Red "Disk backup alert"
}

if ($Table | Where-Object { $_.Location -eq "Cloud" } | Where-Object { $_.HoursSinceSuccessfulBackup -gt $CloudAlertThresholdHours }) {
    Write-Host -ForegroundColor Red "Cloud backup alert"
}