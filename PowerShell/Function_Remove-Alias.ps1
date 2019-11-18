function Remove-Alias
{
    Param (
        [Parameter(Mandatory = $true)]
        [String]$Name
    )
    $Path = "Alias:\$Name"
    if (Test-Path ($Path)) {
        Remove-Item -Path $Path -Confirm:$false
    }
    else {
        Throw "Alias $Name does not exist."
    }
}