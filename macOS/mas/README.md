## Cheat Sheet - mas-cli

<br>

## GitHub repository:
https://github.com/mas-cli/mas

## Install mas-cli:
```shell
brew install mas
```

## Check mas-cli version:
```shell
mas version
```

## Contextual help:
```shell
mas help [<subcommand>]
```

<br><br>

## Show signed-in Apple ID:
```shell
mas account
```

## Sign in to Mac App Store:
```shell
mas signin <apple-id>
```

## Sign out from Mac App Store:
```shell
mas signout
```

<br><br>

## List all installed apps:
```shell
mas list
```

## Search the Mac App Store:
```shell
mas search <pattern>
```

<br><br>

## Get information about a specific app:
```shell
mas info <app-id>
```

## Open a specific app page in Mac App Store:
```shell
mas open <app-id>
```

## Open a specific app page in a browser:
```shell
mas home <app-id>
```

## Open the vendor's app page in a browser:
```shell
mas vendor <app-id>
```

<br><br>

## Purchase and download a specific app:
```shell
mas purchase <app-id>
```

## Install a specific app:
```shell
mas install <app-id>
```

## Uninstall a specific app:
```shell
mas uninstall <app-id>
```

<br><br>

## List all pending updates from the Mac App Store:
```shell
mas outdated
```

## Upgrade a specific app:
```shell
mas upgrade <app-id>
```

## Upgrade all outdated apps:
```shell
mas upgrade
```

<br><br>

## Reset the Mac App Store:
```shell
mas reset
```