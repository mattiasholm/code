# Cheat Sheet

<br>

## Official documentation:
https://git-scm.com/docs

## Oh Shit, Git!?!:
https://ohshitgit.com/

<br><br>

## Contextual manual:
```bash
git [subcommand] --help
```

## Contextual syntax help:
```bash
git [subcommand] -h
```

## Dry run a command:
```bash
git [subcommand] --dry-run
git [subcommand] -n
```

<br><br>

## Enable credential helper to save/cache credentials:

### `Mac`:
```bash
git config --global credential.helper osxkeychain
```

### `Windows`:
```bash
git config --global credential.helper wincred
```

### `Linux`:
```bash
git config --global credential.helper 'cache --timeout=86400'
```

<br>

## Clear saved credentials:
```bash
git config --system --unset credential.helper
```

<br><br>

## Configure global username:
```bash
git config --global user.name "Mattias Holm"
```

## Configure global email address:
```bash
git config --global user.email "mattias.holm@live.com"
```

<br><br>

## Create a new repository in working directory:
```bash
git init
```

## Clone remote repository to working directory:
```bash
git clone [URL]
```

<br><br>

## Fetch metadata from origin (without touching your current HEAD):
```bash
git fetch
```

## Pull changes from origin (will integrate remote changes into your current HEAD):
```bash
git pull
```

<br><br>

## Display currently checked out branch and status of working tree and staging area:
```bash
git status
```

## Display status of working tree in short format:
```bash
git status --short
git status -s
```

## Display status of working tree, exclude any untracked files:
```bash
git status --untracked-files=no
git status --u=no
```

<br><br>

## Add all modified and untracked files to staging area:
```bash
git add .
```

## Add only files already tracked to staging area:
```bash
git add --update
git add -u
```

## Add all modified, untracked and removed files to staging area:
```bash
git add --all
git add -A
```

<br><br>

## Commit changes in staging area:
```bash
git commit --message "[commit-message]"
git commit -m "[commit-message]"
```

## Amend message of previous commit:
```bash
git commit --amend -m "[commit-message]"
```

## Amend code in previous commit:
```bash
git commit --amend --no-edit
```

<br><br>

## Push locally committed changes to origin:
```bash
git push
```

## Push changes to a new branch that doesn't exist in origin:
```bash
git push --set-upstream origin [branch-name]
```

<br><br>

## Display commit history log for currently checked out branch:
```bash
git log
```

## Display commit history log for all branches:
```bash
git log --all
```

## Display reference log (basically undo history):
```bash
git reflog
```

## Get commit ID of current HEAD:
```bash
git rev-parse HEAD
```

<br><br>

## List all branches:
```bash
git branch
```

## Create a new branch based on current HEAD:
```bash
git branch [branch-name]
```

## Check out a specific branch or commit:
```bash
git checkout [branch-name | commit-ID]
```

## Create and check out a new branch in a single command:
```bash
git checkout -b [branch-name]
```

## Delete a branch:
```bash
git branch --delete [branch-name]
git branch -d [branch-name]
```

<br><br>

## Restore modified file in working tree from latest commit:
```bash
git checkout [file-name] ???
```

## Restore all modified files in working tree from latest commit:
```bash
git checkout .
```

## Discard modified file in working tree:
```bash
git restore [file-name]
```

## Discard all modified files in working tree:
```bash
git restore .
```

## Remove modified file from staging area:
```bash
git restore --staged [file-name]
```

## Remove all files from staging area:
```bash
git restore --staged .
```

## Remove all untracked files from working directory:
```bash
git clean --force
git clean -f
```

<br><br>

## FLER TIPS OCH TRIX ???
https://stackoverflow.com/questions/8358035/whats-the-difference-between-git-revert-checkout-and-reset

pop stash?
Fler?
rebase?
reflog

## Also, since you're a Git beginner, I highly recommend you read the Pro Git book,"