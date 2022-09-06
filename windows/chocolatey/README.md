# Cheat Sheet - Chocolatey

<br>

## Chocolatey packages:
https://chocolatey.org/packages

<br><br>

## Install Chocolatey:
```pwsh
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072

Invoke-Expression ((New-Object System.Net.WebClient).DownloadString("https://chocolatey.org/install.ps1"))
```

## Show version:
```pwsh
choco --version
choco -v
```

## Upgrade Chocolatey:
```pwsh
choco upgrade chocolatey
```

<br><br>

## Install package:
```pwsh
choco install <package-name>
```

## Uninstall package:
```pwsh
choco uninstall <package-name>
```

## Reinstall package:
```pwsh
choco install --force <package-name>
```

## List installed packages:
```pwsh
choco list --localonly
```

<br><br>

## Upgrade a specific package:
```pwsh
choco upgrade <package-name>
```

## Upgrade all installed packages:
```pwsh
choco upgrade all
```

<br><br>

## Suppress upgrades for a specific package:
```pwsh
choco pin <package-name>
```