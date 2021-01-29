$ErrorActionPreference = "Continue"

$LogName = "Custom-Security"
$Source = "Custom-Windows-Security-Auditing"

$SecurityLogName = "Security"
$Minutes = 5

if (!(Get-WinEvent -ListLog $LogName)) {
    $OverflowAction = "OverwriteAsNeeded"
    $MaximumSize = 20480KB

    New-EventLog `
        -LogName $LogName `
        -Source $Source

    Limit-EventLog `
        -LogName $LogName `
        -OverflowAction $OverflowAction `
        -MaximumSize $MaximumSize
}

$SecurityEvents = Get-WinEvent -FilterHashtable @{ LogName = $SecurityLogName; StartTime = ((Get-Date).AddMinutes(-$Minutes)) }
[System.Array]::Reverse($SecurityEvents)

foreach ($SecurityEvent in $SecurityEvents) {
    if (!(Get-EventLog -LogName $LogName -Message "$($SecurityEvent.RecordId)*")) {

        switch ($SecurityEvent.KeywordsDisplayNames) {
            "Audit Success" { $EntryType = "SuccessAudit" }
            "Audit Failure" { $EntryType = "FailureAudit" }
            default { $EntryType = "Information" }
        }

        $Arguments = @{
            LogName   = $LogName
            Source    = $Source
            EventId   = $SecurityEvent.Id
            Category  = $SecurityEvent.Task
            EntryType = $EntryType
            Message   = "$($SecurityEvent.RecordId) - $($SecurityEvent.TimeCreated) - $($SecurityEvent.Message)"
        }

        Write-EventLog @Arguments
    }
}