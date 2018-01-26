Class Person
{
[ValidatePattern('^[0-9]{8}\-[0-9]{4}$')]
[string]
$SSN

[ValidateSet('Man','Woman')]
[string]
$Sex

[string]
$FirstName

[string]
$LastName

[ValidateRange(100,250)]
[int]
$Height

[ValidateRange(30,300)]
[int]
$Weight

static
[int]
$NumberOfArms = 2

Person ()
{

}

Person ($SSN,$Sex,$FirstName,$LastName,$Height,$Weight)
{
    $this.SSN = $SSN;
    $this.Sex = $Sex;
    $this.FirstName = $FirstName;
    $this.LastName = $LastName;
    $this.Height = $Height;
    $this.Weight = $Weight;
}

}


$Person1 = [Person]::new()

$Person1.SSN = "19910324-3391"

$Person1.Sex = "Man"

$Person1.FirstName = "Mattias"

$person1.LastName = "Holm"

$person1.Height = "178"

$person1.Weight = "75"

$Person1::NumberOfArms

$person1


[Person]::new("19910324-3391","Man","Mattias","Holm","178","75")





function New-Person
{
    Param (
        [Parameter(Mandatory = $true)]
        [string]
        $SSN


    )
[Person]::new()
}

$Person2 = New-Person -SSN "1991032453391" #FEL INDATA ON PURPOSE!

$Person2


# Skapa hashtabell med flera personer som ett gemensamt register i PowerShell? ALT annan datakälla Table/DB.




# Function output console + Azure Table Storage | Azure DB ?!


<# ### METHOD

class MyClass
{
    DoSomething($x)
    {
        $this._doSomething($x) # method syntax
    }
    private _doSomething($a) {}
}#>