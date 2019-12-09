#Requires -Version 3.0
function Get-MrRCAProtocolLog {
 
<#
.SYNOPSIS
    Identifies and reports which Outlook client versions are being used to access Exchange.
 
.DESCRIPTION
    Get-MrRCAProtocolLog is an advanced PowerShell function that parses Exchange Server RPC
    logs to determine what Outlook client versions are being used to access the Exchange Server.
 
.PARAMETER LogFile
    The path to the Exchange RPC log files.
 
.EXAMPLE
     Get-MrRCAProtocolLog -LogFile 'C:\Program Files\Microsoft\Exchange Server\V15\Logging\RPC Client Access\RCA_20140831-1.LOG'
 
.EXAMPLE
     Get-ChildItem -Path '\\servername\c$\Program Files\Microsoft\Exchange Server\V15\Logging\RPC Client Access\*.log' |
     Get-MrRCAProtocolLog |
     Out-GridView -Title 'Outlook Client Versions'
 
.INPUTS
    String
 
.OUTPUTS
    PSCustomObject
 
.NOTES
    Author:  Mike F Robbins
    Website: http://mikefrobbins.com
    Twitter: @mikefrobbins
#>
 
    [CmdletBinding()]
    param (
        [Parameter(Mandatory,
                   ValueFromPipeline)]
        [ValidateScript({
            Test-Path -Path $_ -PathType Leaf -Include '*.log'
        })]
        [string[]]$LogFile
    )
 
    PROCESS {
        foreach ($file in $LogFile) {
            $Headers = (Get-Content -Path $file -TotalCount 5 | Where-Object {$_ -like '#Fields*'}) -replace '#Fields: ' -split ','
                    
            Import-Csv -Header $Headers -Path $file |
            Where-Object operation -eq 'Connect' |
            Select-Object -Unique -Property @{label='User';expression={$_.'client-name' -replace '^.*cn='}},
                                            @{label='DN';expression={$_.'client-name'}},
                                            client-software,
                                            @{label='Version';expression={$_.'client-software-version'}},
                                            client-mode,
                                            client-ip,
                                            protocol
        }
    }
}

Add-PSSnapin Microsoft.Exchange*

$MailboxServers = Get-MailboxServer | Where-Object {$_.Name -notlike "DGC-GBG-EXH-00*"}
foreach ($MailboxServer in $MailboxServers)
{
Get-ChildItem -Path "\\$($MailboxServer.Name)\c$\Program Files\Microsoft\Exchange Server\V15\Logging\RPC Client Access\*.log" | Get-MrRCAProtocolLog | Format-Table User,client-software,Version | Out-File -Append -FilePath "C:\Temp\OutlookVersionList.txt"
}