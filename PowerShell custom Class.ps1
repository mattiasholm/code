Class Car
{
    [String]$vin
    static [int]$numberOfWheels = 4
    [int]$numberOfDoors
    [datetime]$year
    [String]$model
}
$chevy = New-Object -TypeName Car

$chevy.model = "test"
$chevy.numberOfDoors = 2
$chevy.vin = "AAA-111"
$chevy.year = [System.DateTime]::UtcNow

$chevy

$chevy | Get-Member -Static



####################################################################

Class Car2
{
    [String]$vin
    static [int]$numberOfWheels = 4
    [int]$numberOfDoors
    [datetime]$year
    [String]$model

#Constructors (OverloadDefinitions)
    Car2(){}

    Car2 ([string]$vin)
    {$this.vin = $vin}

    Car2 ([string]$vin, [int]$numberOfDoors)
    {$this.vin = $vin;
    $this.numberOfDoors = $numberOfDoors}

    Car2 ([int]$numberOfDoors,[string]$vin)
    {$this.vin = $vin;
    $this.numberOfDoors = $numberOfDoors}

    Car2 ([string]$vin, [int]$numberOfDoors, [string]$model, [DateTime]$year)
    {$this.vin = $vin;
    $this.numberOfDoors = $numberOfDoors
    $this.model = $model
    $this.year = $year}
}

$chevy2 = New-Object -TypeName Car2 -ArgumentList "BBB-222"

$chevy2.model = "test"
$chevy2.numberOfDoors = 2
$chevy2.year = [System.DateTime]::UtcNow

$chevy3 = [Car2]::new("CCC-333")

$chevy3

$chevy4 = [Car2]::new("DDD-444",3)

$chevy4

$chevy5 = [Car2]::new(4,"DDD-444")

$chevy5

$chevy6 = [Car2]::new("FFF-666",2,"Dodge",[System.DateTime]::UtcNow)

$chevy6


$chevy6::numberOfWheels

[Car2]::numberOfWheels


[Car2]::new.OverloadDefinitions

[Car2]::new

###
New-Variable -Scope Private -Name TS -Value "Tomas"
$TS