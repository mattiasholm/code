$Name = 'B3 Göteborg'
$IpAddress = '10.0.60.254'
$PrinterDriver = 'PCL6 V4 Driver for Universal Print'



if (!(Get-Printer | Where-Object { $_.PortName -eq $IpAddress })) {

    if (!(Get-PrinterDriver | Where-Object { $_.Name -eq $PrinterDriver })) {  
        Add-PrinterDriver -Name $PrinterDriver
    }

    Add-Printer -Name $Name -PortName $IpAddress -DriverName $PrinterDriver
}