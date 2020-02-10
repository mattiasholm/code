#!/usr/bin/env pwsh

### Favorite color example:

$red = New-Object System.Management.Automation.Host.ChoiceDescription '&Red', 'Favorite color: Red'
$blue = New-Object System.Management.Automation.Host.ChoiceDescription '&Blue', 'Favorite color: Blue'
$yellow = New-Object System.Management.Automation.Host.ChoiceDescription '&Yellow', 'Favorite color: Yellow'

$options = [System.Management.Automation.Host.ChoiceDescription[]]($red, $blue, $yellow)

$title = 'Favorite color'
$message = 'What is your favorite color?'
$result = $host.ui.PromptForChoice($title, $message, $options, 0)

switch ($result) {
    0 { 'Your favorite color is Red' }
    1 { 'Your favorite color is Blue' }
    2 { 'Your favorite color is Yellow' }
}



### More advanced example:

$MenuOptions = "Email statistics", "Mailbox size", "Delegated access"

foreach ($MenuOption in $MenuOptions) {
    New-Variable -Name $MenuOption -Value (New-Object System.Management.Automation.Host.ChoiceDescription "&$MenuOption", $MenuOption) -Force
}

$Caption = 'Create report'
$Message = 'Please choose a report type'
$Choices = Get-Variable $MenuOptions -ValueOnly
$DefaultChoice = 0
$Result = $host.UI.PromptForChoice($Caption, $Message, $Choices, $DefaultChoice)

$Text1 = "Generating $($MenuOptions[$Result].ToLower()) report"


$MenuOptions = "Day", "Week", "Month", "Year"

foreach ($MenuOption in $MenuOptions) {
    New-Variable -Name $MenuOption -Value (New-Object System.Management.Automation.Host.ChoiceDescription "&$MenuOption", $MenuOption) -Force
}

$Caption = 'Create report'
$Message = 'Please choose a time interval'
$Choices = Get-Variable $MenuOptions -ValueOnly
$DefaultChoice = 0
$Result = $host.UI.PromptForChoice($Caption, $Message, $Choices, $DefaultChoice)

$Text2 = "for the last $($MenuOptions[$Result].ToLower())"

Write-Host -ForegroundColor Green "`n$Text1 $Text2"