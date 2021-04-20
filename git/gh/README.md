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

## Show currently configured git protocol:
```shell
gh config get git_protocol
```

## Show currently configured text editor:
```shell
gh config get editor
```

<br><br>

## Configure git protocol:
```shell
gh config set git_protocol <protocol>
```

## Configure text editor:
```shell
gh config set editor <editor>
```

<br><br>

## List all repositories in the current GitHub account:
```shell
gh repo list
```

## List all repositories in a specific GitHub account:
```shell
gh repo list <github-account>
```

## List private repositories in the current GitHub account:
```shell
gh repo list --private
```

## List public repositories in the current GitHub account:
```shell
gh repo list --public
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

## Clone a specific repository from a specific GitHub account:
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

## Show pull request in the current branch:
```shell
gh pr view
```

## Show pull request in the current branch in a browswer:
```shell
gh pr view --web
gh pr view -w
```

## Show pull request for a specific branch:
```shell
gh pr view <branch-name>
```

## Show a specific pull request:
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

## Approve a specific pull request:
```shell
gh pr review <number> --approve
gh pr review <number> -a
```

## Approve pull request in the current branch with a comment:
```shell
gh pr review --approve --body '<comment>'
gh pr review -a -c '<comment>'
```

## Request changes in pull request in the current branch:
```shell
gh pr review --request-changes --body '<comment>'
gh pr review -r -b '<comment>'
```

## Leave a review comment for pull request in the current branch:
```shell
gh pr review --comment --body '<comment>'
gh pr review -c -b '<comment>'
```

<br><br>

## Check out pull request in the current branch:
```shell
gh pr checkout <number>
```

<br><br>

## Show changes in pull request in the current branch:
```shell
gh pr diff
```

## Show changes in a specific pull request:
```shell
gh pr diff <number>
```

<br><br>

## Edit pull request in the current branch interactively:
```shell
gh pr edit
```

## Edit a specific pull request interactively:
```shell
gh pr edit <number>
```

## Add yourself as assignee to pull request in the current branch:
```shell
gh pr edit --add-assignee @me
```

## Add a specific assignee to pull request in the current branch:
```shell
gh pr edit --add-assignee <github-account>
```

## Add a specific reviewer to pull request in the current branch:
```shell
gh pr edit --add-reviewer <github-account>
```

## Remove yourself as assignee from pull request in the current branch:
```shell
gh pr edit --remove-assignee @me
```

## Remove a specific assignee from pull request in the current branch:
```shell
gh pr edit --remove-assignee <github-account>
```

## Remove a specific reviewer from pull request in the current branch:
```shell
gh pr edit --remove-reviewer <github-account>
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
gh pr merge -m
```

## Merge a specific pull request:
```shell
gh pr merge <number> --merge
gh pr merge <number> -m
```

## Squash merge pull request in the current branch:
```shell
gh pr merge --squash
gh pr merge -s
```

## Rebase pull request in the current branch:
```shell
gh pr merge --rebase
gh pr merge -r
```

## Merge pull request in the current branch and delete both local and remote branch afterwards:
```shell
gh pr merge --merge --delete-branch
gh pr merge -m -d
```

## Enable auto-merge for pull request in the current branch:
```shell
gh pr merge --merge --auto
gh pr merge -m --auto
```

## Disable auto-merge for pull request in the current branch:
```shell
gh pr merge --merge --disable-auto
gh pr merge -m --disable-auto
```

<br><br>

## List enabled GitHub Actions workflows in the current repository:
```shell
gh workflow list
```

## List enabled GitHub Actions workflows in a specific repository:
```shell
gh workflow list --repo <github-account>/<repo-name>
gh workflow list -R <github-account>/<repo-name>
```

## List all GitHub Actions workflows in the current repository:
```shell
gh workflow list --all
gh workflow list -a
```

<br><br>

## Show a specific GitHub Actions workflow:
```shell
gh workflow view <id | name | filename>
```

## Show a specific GitHub Actions workflow in YAML:
```shell
gh workflow view <id | name | filename> --yaml
gh workflow view <id | name | filename> -y
```

## Show a specific GitHub Actions workflow in a browser:
```shell
gh workflow view <id | name | filename> --web
gh workflow view <id | name | filename> -w
```

<br><br>

## Enable a specific GitHub Actions workflow:
```shell
gh workflow enable <id | name | filename>
```

## Disable a specific GitHub Actions workflow:
```shell
gh workflow disable <id | name | filename>
```

<br><br>

## Run a specific GitHub Actions workflow:
```shell
gh workflow run <id | name | filename>
```

## Run a specific GitHub Actions workflow in a specific branch or tag:
```shell
gh workflow run <id | name | filename> --ref <branch-name | tag-name>
gh workflow run <id | name | filename> -r <branch-name | tag-name>
```

<br><br>

## List runs for all GitHub Actions workflows in the current repository:
```shell
gh run list
```

## List runs for all GitHub Actions workflows in a specific repository:
```shell
gh run list --repo <github-account>/<repo-name>
gh run list -R <github-account>/<repo-name>
```

## List runs for a specific GitHub Actions workflow:
```shell
gh run list --workflow <id | name | filename>
gh run list -w <id | name | filename>
```

<br><br>

## Show a specific GitHub Actions run:
```shell
gh run view <run-id>
```

## Show a specific GitHub Actions run in a browser:
```shell
gh run view <run-id> --web
gh run view <run-id> -w
```

<br><br>

## Rerun a failed GitHub Actions run:
```shell
gh run rerun <run-id>
```

## Watch an in-progress GitHub Actions run:
```shell
gh run watch <run-id>
```