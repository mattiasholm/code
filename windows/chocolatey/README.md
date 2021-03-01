# Cheat Sheet - Chocolatey

<br>

## Install Chocolatey:
```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072

Invoke-Expression ((New-Object System.Net.WebClient).DownloadString("https://chocolatey.org/install.ps1"))
```

## Show version:
```powershell
choco --version
choco -v
```

## Upgrade Chocolatey:
```powershell
choco upgrade chocolatey
```

<br>

## Chocolatey packages:
https://chocolatey.org/packages

<br><br>

## Install package:
```powershell
choco install <package-name>
```

## Uninstall package:
```powershell
choco uninstall <package-name>
```

## Reinstall package:
```powershell
choco install --force <package-name>
```

## List installed packages:
```powershell
choco list --localonly
```

<br><br>

## Upgrade a specific package:
```powershell
choco upgrade <package-name>
```

## Upgrade all installed packages:
```powershell
choco upgrade all
```

<br><br>

## Suppress upgrades for a specific package:
```powershell
choco pin <package-name>
```