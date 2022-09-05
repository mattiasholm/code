#!/usr/bin/env pwsh

$DogClass = New-Object PSObject -Property @{
    Color = $null
    Name  = $null
    Size  = $null
}

$DogClass

$Dog1 = $DogClass

$Dog1.Color = "Brown"
$Dog1.Name = "Daisy"
$Dog1.Size = "Large"

$Dog1


#########################

function New-Dog {
    param (
        [Parameter(Mandatory = $true)]
        [String]$name,

        [Parameter(Mandatory = $false)]
        [string]$color,

        [Parameter(Mandatory = $false)]
        [ValidateSet('Small', 'Medium', 'Large')]
        [String]$size
    )
    $dog = $DogClass.PSObject.Copy()
    $dog.Name = $name
    $dog.Color = $color
    $dog.Size = $size
    $dog
}

$Dog2 = New-Dog -name "Daisy" -color "White" -size "Small"

$Dog2




# Pee Method!

$DogClass | Add-Member -MemberType ScriptMethod -Name "Pee" -Value {
    "A warm refreshing pee trickles out of {0}" -f $this.name
}

$DogClass.Pee()

$dog1.Pee()





##########################

function New-Dog {
    param (
        [Parameter(Mandatory = $true)]
        [string]$Name,

        [Parameter(Mandatory = $false)]
        [ValidateSet('small', 'medium', 'large', $null)]
        [string]$size,
        
        [Parameter(Mandatory = $false)]
        [string]$color
    )
    New-Object psobject -property @{
        Name  = $Name
        Size  = $Size
        Color = $color
    }
}

function Invoke-Pee {
    param (
        [Parameter(Mandatory = $true, Position = 0, ValueFromPipelineByPropertyName = $true)]
        [String]$Name
    )
    PROCESS {
        "A warm refreshing pee trickles out of {0}" -f $Name
    }
}

New-Dog -Name Lucy | Invoke-Pee