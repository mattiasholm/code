# Cheat Sheet - Winget

<br>

## Winget packages:
https://winget.run/

<br><br>

## Show version:
```powershell
winget --version
winget -v
```

<br>

## Install package:
```powershell
winget install <id>
```

## Uninstall package:
```powershell
winget uninstall <id>
```

## List installed packages:
```powershell
winget list
```

## Search available packages:
```powershell
winget search [<pattern>]
```

## Show a specific package:
```powershell
winget show <id>
```

<br><br>

## List all available upgrades:
```powershell
winget upgrade
```

## Upgrade a specific package:
```powershell
winget upgrade <id>
```

## Upgrade all installed packages:
```powershell
winget upgrade --all
```