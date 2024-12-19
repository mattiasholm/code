#!/usr/bin/env pwsh

Class Person {

    # LÄGG TILL UNIKT ID SOM AUTOMATISKT SKAPAS BASERAT PÅ CMDLET "New-Guid"

    [ValidatePattern('^[0-9]{8}\-[0-9]{4}$')]
    [string]
    $SSN

    [ValidateSet('Man', 'Woman')]
    [string]
    $Sex

    [ValidateNotNullOrEmpty()]
    [string]
    $FirstName

    [ValidateNotNullOrEmpty()]
    [string]
    $LastName

    [ValidateRange(30, 300)]
    [int]
    $Height

    [ValidateRange(30, 300)]
    [int]
    $Weight

    [ValidateLength(3, 3)]
    [string]
    $Nationality

    static
    [int]
    $NumberOfArms = 2

    Person () {

    }

    Person ($SSN, $Sex, $FirstName, $LastName, $Height, $Weight, $Nationality) {
        $this.SSN = $SSN;
        $this.Sex = $Sex;
        $this.FirstName = $FirstName;
        $this.LastName = $LastName;
        $this.Height = $Height;
        $this.Weight = $Weight;
        $this.Nationality = $Nationality
    }

}


$Person1 = [Person]::new()

$Person1.SSN = "19910324-1111"

$Person1.Sex = "Man"

$Person1.FirstName = "Mattias"

$person1.LastName = "Holm"

$person1.Height = "178"

$person1.Weight = "75"

$person1.Nationality = "SWE"

$Person1::NumberOfArms

$Person1



$Person2 = [Person]::new("19910324-1111", "Man", "Mattias", "Holm", "178", "75", "SWE")

$Person2



function New-Person {
    param (
        #[Parameter(Mandatory = $true)]
        [string]
        $SSN,

        [string]
        $Sex
        
    )
    [Person]::new()
}

$Person2 = New-Person -SSN "1991032453391" #FEL INDATA ON PURPOSE!

$Person2


# Skapa hashtabell med flera personer som ett gemensamt register i PowerShell? ALT annan datakälla Table/DB.




# Function output console + Azure Table Storage | Azure DB ?!


<# ### METHOD
TESTA EXEMPELVIS SayName() som finns nedan
STATIC METHODS?

class MyClass
{
    DoSomething($x)
    {
        $this._doSomething($x) # method syntax
    }
    private _doSomething($a) {}
}#>



# # # CHILD CLASSES: http://overpoweredshell.com/Introduction-to-PowerShell-Classes/#this
# # # LÄS HELA OCH TESTA ORDENTLIGT!
