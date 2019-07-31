$DpmServerName = "B3CARE-SE-BAC01.ad.b3care.se"

$Table = @()
$DataSources = Get-DPMDatasource -DPMServerName $DpmServerName

foreach ($DataSource in $DataSources) {
    $RecoveryPoints = Get-RecoveryPoint -Datasource $DataSource | Sort-Object -Property BackupTime -Descending | Select-Object -First 1
    $RecoveryPoints += Get-RecoveryPoint -Datasource $DataSource -Online | Sort-Object -Property BackupTime -Descending | Select-Object -First 1

    foreach ($RecoveryPoint in $RecoveryPoints) {
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
}

$Table





<#

#$DiskAlertThresholdHours = 36
#$OnlineAlertThresholdHours = 60



Bättre att göra checkar etc på table med where, istället för en massa if-satser i insamlingen!


elseif ($RecoveryPoint.BackupTime -lt (Get-Date).AddHours(-$DiskAlertThresholdHours)) {

elseif ($RecoveryPoint.BackupTime -lt (Get-Date).AddHours(-$OnlineAlertThresholdHours)) {
#>

#$Table | Export-Csv -Path "C:\Temp\DPM_RecoveryPoint_Monitor_$(Get-Date -Format "yyyy-MM-dd_HH-mm-ss").csv" -Delimiter "," -Encoding Unicode
# Går såklart även att importera med Import-Csv!