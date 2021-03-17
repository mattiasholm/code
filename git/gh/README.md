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

<br><br>

# Check out pull request in the current branch:
```shell
gh pr checkout <number>
```

<br><br>

# View changes in pull request in the current branch:
```shell
gh pr diff
```

# View changes in a specific pull request:
```shell
gh pr diff <number>
```

<br><br>

# Edit a specific pull request interactively:
```shell
gh pr edit <number>
```

# Add yourself as assignee to a specific pull request:
```shell
gh pr edit <number> --add-assignee @me
```

# Add a specific assignee to a specific pull request:
```shell
gh pr edit <number> --add-assignee <github-account>
```

# Add a specific reviewer to a specific pull request:
```shell
gh pr edit <number> --add-reviewer <github-account>
```

# Remove yourself as assignee from a specific pull request:
```shell
gh pr edit <number> --remove-assignee @me
```

# Remove a specific assignee from a specific pull request:
```shell
gh pr edit <number> --remove-assignee <github-account>
```

# Remove a specific reviewer from a specific pull request:
```shell
gh pr edit <number> --remove-reviewer <github-account>
```

<br><br>

## Mark pull request in the current branch as ready for review:
```shell
gh pr ready
```

## Mark a specific pull request as ready for review:
```shell
gh pr ready <number>
```

<br><br>

## Merge pull request in the current branch:
```shell
gh pr merge --merge
```

## Merge a specific pull request:
```shell
gh pr merge <number> --merge
```

## Automatically merge pull request in the current branch after all requirements are met:
```shell
gh pr merge --merge --auto
```

## Automatically merge a specific pull request after all requirements are met:
```shell
gh pr merge <number> --merge --auto
```



<!-- FORTSÄTT:

gh pr merge

Ändra till mer logisk ordning när väl är klar med alla subcommands!



## 
```shell

```

## 
```shell

```

## 
```shell

```



gh config set -h github.com git_protocol https 
-->