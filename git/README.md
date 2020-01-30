# Cheat Sheet

<br>

## Official docs:
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

## Show currently checked out branch and status of working tree and staging area:
```bash
git status
```

## Show status of working tree in short format:
```bash
git status --short
git status -s
```

## Show status of working tree, exclude any untracked files:
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

## Add only a specific file to staging area:
```bash
git add [file-name]
```

<br><br>

## Commit all changes in staging area:
```bash
git commit --message "[commit-message]"
git commit -m "[commit-message]"
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

## Show all local commits, not yet pushed to origin:
```bash
git cherry --verbose
git cherry --v
```

## Show commit history (both local and remote) in currently checked out branch:
```bash
git log
```

## Show commit history (both local and remote) in all branches:
```bash
git log --all
```

## Show reference log (basically undo history):
```bash
git reflog
```

## Get commit ID of current HEAD:
```bash
git rev-parse HEAD
cat .git/refs/heads/master
```

## Show author and commit ID for each line of a file:
```bash
git blame [file-name]
```

<br><br>

## List currently checked out branch:
```bash
git branch --show-current
cat .git/HEAD
```

## List all local branches:
```bash
git branch
```

## List all remote branches:
```bash
git branch -r
```

## List both local and remote branches:
```bash
git branch --all
git branch -a
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

## Rename currently checked out local branch:
```bash
git branch --move [new-name]
git branch -m [new-name]
```

## Rename a specific local branch:
```bash
git branch --move [branch-name] [new-name]
git branch -m [branch-name] [new-name]
```

## Copy currently checked out local branch:
```bash
git branch --copy [new-name]
git branch -c [new-name]
```

## Copy a specific local branch:
```bash
git branch --copy [branch-name] [new-name]
git branch -c [branch-name] [new-name]
```

## Delete a fully merged branch:
```bash
git branch --delete [branch-name]
git branch -d [branch-name]
```

## Delete branch, even if not merged:
```bash
git branch -D [branch-name]
```

<br><br>

## Amend message of previous commit:
```bash
git commit --amend -m "[commit-message]"
```

## Amend code in previous commit (only safe to do on commits not yet pushed to origin):
```bash
git commit --amend --no-edit
```

## Discard changes to a specific file in working tree (will not touch staging area):
```bash
git restore [file-name]
git checkout [file-name]
```

## Discard changes to all tracked files in working tree (will not touch staging area):
```bash
git restore .
git checkout .
```

## Unstage file for commit:
```bash
git restore [file-name] --staged
git restore [file-name] -S
git reset [file-name]
```

## Unstage all files for commit:
```bash
git restore . --staged
git restore . -S
git reset .
```

## Remove all untracked files from working directory:
```bash
git clean --force
git clean -f
```

## Remove all untracked files and directories from working directory:
```bash
git clean -d --force
git clean -d -f
```

## Discard all local commits and revert back to latest commit in remote master:
```bash
git reset --hard origin/master
```

## Discard all local commits and revert back to a specific local branch or commit:
```bash
git reset --hard [branch-name | commit-ID]
```

## Revert changes made in latest commit:
```bash
git revert HEAD
```

## Revert changes made in the second latest commit:
```bash
git revert HEAD~1
```

## Revert changes made in a specific commit:
```bash
git revert [commit-ID]
```

<br><br>

## Compare working directory to current HEAD:
```bash
git diff
```

## Compare all files in working directory to another branch or commit:
```bash
git diff [branch-name | commit-ID]
```

## Compare all files a specific branch or commit to another branch or commit:
```bash
git diff [branch-name | commit-ID] [branch-name | commit-ID]
```

## Compare a specific directory or file in working directory to another branch or commit:
```bash
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