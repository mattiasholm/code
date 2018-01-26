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



##### Function to add new car:

function New-Car {
    param(
          [Parameter(Mandatory=$true)]
          [ValidatePattern()
          [String]$vin,
          [Parameter(Mandatory=$false)]
          [ValidateSet(2,4)]
          [int]$numberOfDoors,
          [Parameter(Mandatory=$true)]
          [ValidateSet('Chevy','Volvo','Audi')]
          [String]$model,
          [Parameter(Mandatory=$true)]
          [ValidateRange(1900,2018)]
          [int]$year
    )
    $car = [Car2]::new()

    $car.vin = $vin;
    $car.numberOfDoors = $numberOfDoors
    $car.model = $model
    $car.year = $year
    $car
}


$Car1 = New-Car -vin "ABC-123" -numberOfDoors 2 -model "Audi" -year "2018"

$Car1

$Car2 = New-Car -vin "ABC-123" -model "Audi" -year "2018"

$Car2



### OPTIMERAD CLASS MED VALIDATION
Class Car3
{
    [ValidatePattern('^[A-Z]{3}-[0-9]{3}$')]
    [string]
    $vin
    
    static
    [int]
    $numberOfWheels = 4

    [ValidateSet(2,4)]
    [int]
    $numberOfDoors = 4

    [ValidateRange(1900,2999)]
    [int]
    $year

    [ValidateSet('Audi','Chevy','Ferrari','Volvo')]
    [String]
    $model

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


#[Car3]::new('AA-22',2,2016,"Subaru")

$test = [car3]::new()

$test.model = "Audi"
$test.numberOfDoors = "2"
$test.year = "2018"
$test.vin = "ABC-123"

$test