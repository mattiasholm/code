# Cheat Sheet - Winget

<br>

## Winget packages:
https://winget.run/

<br><br>

## Show version:
```pwsh
winget --version
winget -v
```

<br>

## Install package:
```pwsh
winget install <id>
```

## Uninstall package:
```pwsh
winget uninstall <id>
```

## List installed packages:
```pwsh
winget list
```

## Search available packages:
```pwsh
winget search [<pattern>]
```

## Show a specific package:
```pwsh
winget show <id>
```

<br><br>

## List all available upgrades:
```pwsh
winget upgrade
```

## Upgrade a specific package:
```pwsh
winget upgrade <id>
```

## Upgrade all installed packages:
```pwsh
winget upgrade --all
```