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

## Show authentication status:
```shell
gh auth status
```

<br><br>

## Show the current repository:
```shell
gh repo view
```

## Open the current repository in a browser:
```shell
gh repo view --web
gh repo view -w
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

<br><br>

## Clone a specific repository from the current GitHub account:
```shell
gh repo clone <repo-name> [<path>]
```

## Clone a specific repository from an arbitrary GitHub account:
```shell
gh repo clone <github-account>/<repo-name> [<path>]
```

<br><br>

## Create a new GitHub repository from working directory:
```shell
gh repo create
```

<br><br>

## Fork the current repository to the current GitHub account:
```shell
gh repo fork
```

<br><br>

## Show status of pull request in the current branch:
```shell
gh pr status
```

<br><br>

## List open pull requests:
```shell
gh pr list
```

## List open pull requests in a browser:
```shell
gh pr list --web
gh pr list -w
```

## List closed pull requests:
```shell
gh pr list --state 'closed'
gh pr list -s 'closed'
```

<br><br>

## View pull request in the current branch:
```shell
gh pr view
```

## View pull request in the current branch in a browswer:
```shell
gh pr view --web
gh pr view -w
```

## View pull request for a specific branch:
```shell
gh pr view <branch-name>
```

## View a specific pull request:
```shell
gh pr view <number>
```

<br><br>

## Create a new pull request from the current branch into the default branch:
```shell
gh pr create
```

## Create a new pull request from a specific branch into another branch:
```shell
gh pr create --head <source-branch> --base <destination-branch>
gh pr create -H <source-branch> -B <destination-branch>
```

<br><br>

## Add a comment to pull request in the current branch:
```shell
gh pr comment --body '<comment>'
gh pr comment -b '<comment>'
```

<br><br>

## Close a specific pull request:
```shell
gh pr close <number>
```

## Close a specific pull request and delete both local and remote branch:
```shell
gh pr close <number> --delete-branch
gh pr close <number> -d
```

<br><br>

## Reopen a closed pull request:
```shell
gh pr reopen <number>
```

<br><br>

## Approve pull request in the current branch:
```shell
gh pr review --approve
gh pr review -a
```

## Approve pull request in the current branch with a comment:
```shell
gh pr review --approve --body '<comment>'
gh pr review -a -c '<comment>'
```

## Approve a specific pull request:
```shell
gh pr review <number> --approve
gh pr review <number> -a
```

## Request changes in pull request in the current branch:
```shell
gh pr review --request-changes --body '<comment>'
gh pr review -r -b '<comment>'
```

## Request changes in a specific pull request:
```shell
gh pr review <number> --request-changes --body '<comment>'
gh pr review <number> -r -b '<comment>'
```

# Leave a review comment for pull request in the current branch:
```shell
gh pr review --comment --body '<comment>'
gh pr review -c -b '<comment>'
```

<!--

gh pr checkout
gh pr diff
gh pr edit
gh pr merge
gh pr ready


## 
```shell

```

## 
```shell

```
-->



<!-- FORTSÄTT:

Work with GitHub pull requests

USAGE
  gh pr <command> [flags]

CORE COMMANDS
  checkout:   Check out a pull request in git
  checks:     Show CI status for a single pull request
  close:      Close a pull request
  comment:    Create a new pr comment
  create:     Create a pull request
  diff:       View changes in a pull request
  edit:       Edit a pull request
  list:       List and filter pull requests in this repository
  merge:      Merge a pull request
  ready:      Mark a pull request as ready for review
  reopen:     Reopen a pull request
  review:     Add a review to a pull request
  status:     Show status of relevant pull requests
  view:       View a pull request

FLAGS
  -R, --repo [HOST/]OWNER/REPO   Select another repository using the [HOST/]OWNER/REPO format

INHERITED FLAGS
  --help   Show help for command

ARGUMENTS
  A pull request can be supplied as argument in any of the following formats:
  - by number, e.g. "123";
  - by URL, e.g. "https://github.com/OWNER/REPO/pull/123"; or
  - by the name of its head branch, e.g. "patch-1" or "OWNER:patch-1".

EXAMPLES
  $ gh pr checkout 353
  $ gh pr create --fill
  $ gh pr view --web

LEARN MORE
  Use 'gh <command> <subcommand> --help' for more information about a command.
  Read the manual at https://cli.github.com/manual



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


  gh config set -h github.com git_protocol https 
-->