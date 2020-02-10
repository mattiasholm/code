#!/usr/bin/env pwsh

$lowercase = ("a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "m", "n", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z")
$uppercase = ("A", "B", "C", "D", "E", "F", "G", "H", "J", "K", "L", "M", "N", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z")
$symbols = ("!", "#", "@", "%")
$p1 = Get-Random $lowercase
$p2 = Get-Random -Minimum 1 -Maximum 9
$p3 = Get-Random $uppercase
$p4 = Get-Random $symbols
$p5 = Get-Random $lowercase
$p6 = Get-Random -Minimum 1 -Maximum 9
$p7 = Get-Random $uppercase
$p8 = Get-Random $symbols
$p9 = Get-Random $lowercase
$p10 = Get-Random -Minimum 1 -Maximum 9
$p11 = Get-Random $uppercase
$p12 = Get-Random $symbols
$p13 = Get-Random $lowercase
$p14 = Get-Random -Minimum 1 -Maximum 9
$p15 = Get-Random $uppercase
$p16 = Get-Random $symbols

$Password = "$p1$p2$p3$p4$p5$p6$p7$p8$p9$p10$p11$p12$p13$p14$p15$p16"

if (Get-Command Set-Clipboard) {
    Set-Clipboard -Value $Password
    Write-Host 'Generated password copied to clipboard.'
}
else {
    Write-Host "Generated password: `n$Password"
}