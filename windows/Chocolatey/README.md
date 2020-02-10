# Cheat Sheet

<br>

## Install Chocolatey:
https://chocolatey.org/install

## Chocolatey packages:
https://chocolatey.org/packages

<br><br>

## Install package:
```powershell
choco install [package-name]
```

## Uninstall package:
```powershell
choco uninstall [package-name]
```

## Reinstall package:
```powershell
choco install --force [package-name]
```

## List installed packages:
```powershell
choco list --localonly
```

<br><br>

## Upgrade a specific package:
```powershell
choco upgrade [package-name]
```

## Upgrade all installed packages:
```powershell
choco upgrade all
```

<br><br>

## Suppress upgrades for a specific package:
```powershell
choco pin [package-name]
```