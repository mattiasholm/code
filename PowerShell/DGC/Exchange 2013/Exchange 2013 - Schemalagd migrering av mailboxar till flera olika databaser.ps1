Get-Mailbox -Server don-ex-mb01 | select -First 25 | New-MoveRequest -TargetDatabase DB10v -PrimaryOnly -BadItemLimit 10000 -LargeItemLimit 10000 -AcceptLargeDataLoss -StartAfter "2014-12-08 18:00"

Get-Mailbox -Server don-ex-mb01 | select -Skip 25 -First 25 | New-MoveRequest -TargetDatabase DB11 -PrimaryOnly -BadItemLimit 10000 -LargeItemLimit 10000 -AcceptLargeDataLoss -StartAfter "2014-12-08 18:00"

Get-Mailbox -Server don-ex-mb01 | select -Skip 50 | New-MoveRequest -TargetDatabase DB08v -PrimaryOnly -BadItemLimit 10000 -LargeItemLimit 10000 -AcceptLargeDataLoss -StartAfter "2014-12-08 18:00"

Get-MoveRequest