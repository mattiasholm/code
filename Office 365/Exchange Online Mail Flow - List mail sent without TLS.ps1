$MessageTraces = $null
$PageNumber = 1

while ($PageNumber -le 2)
{
    $MessageTracePage = Get-MessageTrace -PageSize 5000 -Page $PageNumber
    $MessageTraces += $MessageTracePage
    $PageNumber++
}


foreach ($MessageTrace in $MessageTraces)
{
    $MessageTraceDetails = $MessageTrace | Get-MessageTraceDetail

    foreach ($MessageTraceDetail in $MessageTraceDetails)
    {
        if ($MessageTraceDetail.Detail -like "Message sent to*" -or $MessageTraceDetail.Detail -like "Message received by:*" -and $MessageTraceDetail.Detail -notlike "*using TLS*")
        {
            $MessageTrace
        }
    }
}