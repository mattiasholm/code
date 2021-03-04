# Cheat Sheet - GitHub CLI

<br>

## GitHub repository:
https://github.com/cli/cli

## Show version:
```shell
gh version
gh --version
```

## Contextual help:
```shell
gh help [<subcommand>]
gh [<subcommand>] --help
gh [<subcommand>] -h
```

<br><br>

## Log in to GitHub:
```shell
gh auth login
```

## Log out from GitHub:
```shell
gh auth logout
```

## Refresh stored authentication credentials:
```shell
gh auth refresh
```

## Show authentication status:
```shell
gh auth status
```

<br><br>

## Show the current repository:
```shell
gh repo view
```

## Show a specific repository:
```shell
gh repo view <repo-name>
```

## Show a specific branch of the current repository:
```shell
gh repo view --branch <branch-name>
gh repo view -b <branch-name>
```

## Open the current repository in a browser:
```shell
gh repo view --web
gh repo view -w
```

## Open a specific branch of the current repository in a browser:
```shell
gh repo view --branch <branch-name> --web
gh repo view -b <branch-name> -w
```


<!-- FORTSÄTT:

gh config set -h github.com git_protocol https 



USAGE
  gh repo <command> [flags]

CORE COMMANDS
  clone:      Clone a repository locally
  create:     Create a new repository
  fork:       Create a fork of a repository
  view:       View a repository



CORE COMMANDS
  gist:       Manage gists
  issue:      Manage issues
  pr:         Manage pull requests
  release:    Manage GitHub releases
  repo:       Create, clone, fork, and view repositories

ADDITIONAL COMMANDS
  alias:      Create command shortcuts
  api:        Make an authenticated GitHub API request
  auth:       Login, logout, and refresh your authentication
  completion: Generate shell completion scripts
  config:     Manage configuration for gh
  help:       Help about any command
  secret:     Manage GitHub secrets
  ssh-key:    Manage SSH keys
-->