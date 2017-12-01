Class Car
{
    [String]$vin
    static [int]$numberOfWheels = 4
    [int]$numberOfDoors
    [datetime]$year
    [String]$model
}

$chevy = New-Object Car

$chevy.model = "test"
$chevy.numberOfDoors = 2
$chevy.vin = "AAA-111"
$chevy.year = [System.DateTime]::UtcNow

$chevy