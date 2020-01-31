# Cheat Sheet

<br>

## Official docs:
https://git-scm.com/docs

## Oh Shit, Git!?!:
https://ohshitgit.com/

<br><br>

## Contextual manual:
```shell
git [subcommand] --help
git help [subcommand]
```

## Contextual syntax help:
```shell
git [subcommand] -h
```

## List all available subcommands:
```shell
git help --all
git help -a
```

## List all available subcommands:
```shell
git help --all
git help -a
```

## Dry run a command:
```shell
git [subcommand] --dry-run
git [subcommand] -n
```

<br><br>

## Enable credential helper to save/cache credentials:

### `Mac`:
```shell
git config --global credential.helper osxkeychain
```

### `Windows`:
```shell
git config --global credential.helper wincred
```

### `Linux`:
```shell
git config --global credential.helper 'cache --timeout=86400'
```

<br>

## Clear saved credentials:
```shell
git config --system --unset credential.helper
```

<br><br>

## Configure global username:
```shell
git config --global user.name "Mattias Holm"
```

## Configure global email address:
```shell
git config --global user.email "mattias.holm@live.com"
```

<br><br>

## Create a new repository in working directory:
```shell
git init
```

## Clone remote repository to working directory:
```shell
git clone [URL]
```

<br><br>

## Fetch metadata from origin (without touching your current HEAD):
```shell
git fetch
```

## Pull changes from origin (will integrate remote changes into your current HEAD):
```shell
git pull
```

<br><br>

## Show currently checked out branch and status of working tree and staging area (index):
```shell
git status
```

## Show status of working tree in short format:
```shell
git status --short
git status -s
```

## Show status of working tree, exclude any untracked files:
```shell
git status --untracked-files=no
git status --u=no
```

<br><br>

## Add all modified and untracked files to staging area:
```shell
git add .
```

## Add only files already tracked to staging area:
```shell
git add --update
git add -u
```

## Add all modified, untracked and removed files to staging area:
```shell
git add --all
git add -A
```

## Add only a specific file to staging area:
```shell
git add [file-name]
```

<br><br>

## Remove a file from working tree and staging area:
```shell
git rm [file-name]
```

<br><br>

## Rename/move a file in working tree and staging area:
```shell
git mv [file-name] [new-name | destination-path]
```

<br><br>

## Commit all changes in staging area:
```shell
git commit --message "[commit-message]"
git commit -m "[commit-message]"
```

<br><br>

## Push locally committed changes to origin:
```shell
git push
```

## Push changes to a new branch that doesn't exist in origin:
```shell
git push --set-upstream origin [branch-name]
```

<br><br>

## Show all local commits, not yet pushed to origin:
```shell
git cherry --verbose
git cherry --v
```

## Show commit history (both local and remote) in currently checked out branch:
```shell
git log
```

## Show commit history (both local and remote) in all branches:
```shell
git log --all
```

## Show reference log (basically undo history):
```shell
git reflog
```

## Get commit ID of current HEAD:
```shell
git rev-parse HEAD
cat .git/refs/heads/master
```

## Show author and commit ID for each line of a file:
```shell
git blame [file-name]
```

<br><br>

## List currently checked out branch:
```shell
git branch --show-current
cat .git/HEAD
```

## List all local branches:
```shell
git branch
```

## List all remote branches:
```shell
git branch -r
```

## List both local and remote branches:
```shell
git branch --all
git branch -a
```

## Create a new branch based on current HEAD:
```shell
git branch [branch-name]
```

## Check out a specific branch or commit:
```shell
git checkout [branch-name | commit-ID]
```

## Create and check out a new branch in a single command:
```shell
git checkout -b [branch-name]
```

## Rename currently checked out local branch:
```shell
git branch --move [new-name]
git branch -m [new-name]
```

## Rename a specific local branch:
```shell
git branch --move [branch-name] [new-name]
git branch -m [branch-name] [new-name]
```

## Copy currently checked out local branch:
```shell
git branch --copy [new-name]
git branch -c [new-name]
```

## Copy a specific local branch:
```shell
git branch --copy [branch-name] [new-name]
git branch -c [branch-name] [new-name]
```

## Delete a fully merged branch:
```shell
git branch --delete [branch-name]
git branch -d [branch-name]
```

## Delete branch, even if not merged:
```shell
git branch -D [branch-name]
```

<br><br>

## Amend message of previous commit:
```shell
git commit --amend -m "[commit-message]"
```

## Amend code in previous commit (only safe to do on commits not yet pushed to origin):
```shell
git commit --amend --no-edit
```

## Discard changes to a specific file in working tree (will not touch staging area):
```shell
git restore [file-name]
git checkout [file-name]
```

## Discard changes to all tracked files in working tree (will not touch staging area):
```shell
git restore .
git checkout .
```

## Unstage file for commit:
```shell
git restore [file-name] --staged
git restore [file-name] -S
git reset [file-name]
```

## Unstage all files for commit:
```shell
git restore . --staged
git restore . -S
git reset .
```

## Remove all untracked files from working directory:
```shell
git clean --force
git clean -f
```

## Remove all untracked files and directories from working directory:
```shell
git clean -d --force
git clean -d -f
```

## Discard all local commits and revert back to latest commit in remote master:
```shell
git reset --hard origin/master
```

## Discard all local commits and revert back to a specific local branch or commit:
```shell
git reset --hard [branch-name | commit-ID]
```

## Revert changes made in latest commit:
```shell
git revert HEAD
```

## Revert changes made in the second latest commit:
```shell
git revert HEAD~1
```

## Revert changes made in a specific commit:
```shell
git revert [commit-ID]
```

<br><br>

## Compare working directory to current HEAD:
```shell
git diff
```

## Compare all files in working directory to another branch or commit:
```shell
git diff [branch-name | commit-ID]
```

## Compare all files a specific branch or commit to another branch or commit:
```shell
git diff [branch-name | commit-ID] [branch-name | commit-ID]
```

## Compare a specific directory or file in working directory to another branch or commit:
```shell
git diff [branch-name | commit-ID] [directory-name | file-name]
```

<br><br>

## Merge a specific branch or commit into currently checked out branch:
git merge [branch-name | commit-ID]

## Abort an ongoing merge:
git merge --abort

<br><br>

<br><br>

## FLER TIPS OCH TRIX ???
https://stackoverflow.com/questions/8358035/whats-the-difference-between-git-revert-checkout-and-reset

https://ohshitgit.com/

!!! git tag - named versions for applications! TESTA! git tag --list (git tag -h)
!!! pop stash?
??? rebase ???
??? HUR ANVÄNDA ??? HEAD@{2}:

 "Also, since you're a Git beginner, I highly recommend you read the Pro Git book,""

 git add
git commit
git ls-files
git status
git mv
git rm
