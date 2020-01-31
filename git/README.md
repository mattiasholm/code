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

## List the most common subcommands, grouped by category:
```shell
git help --man
git help -m
```

## List all available subcommands, sorted alphabetically:
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

## Exclude a file pattern from source control:
```shell
vim .gitignore
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

## Show currently checked out branch and status of working tree and index (staging area):
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

## Stage all modified and untracked files to index (staging area):
```shell
git add .
```

## Stage only files already tracked to index (staging area):
```shell
git add --update
git add -u
```

## Stage all modified, untracked and removed files to index (staging area):
```shell
git add --all
git add -A
```

## Stage only a specific file to index (staging area):
```shell
git add [file-name]
```

<br><br>

## Remove a file from working tree and index (staging area):
```shell
git rm [file-name]
```

<br><br>

## Rename/move a file in working tree and index (staging area):
```shell
git mv [file-name] [new-name | destination-path]
```

<br><br>

## List all tracked files in repository:
```shell
git ls-files
```

## List all tracked files in repository that match a specific file pattern:
```shell
git ls-files | grep .json
```

## List all tracked files that have been modified:
```shell
git ls-files -m
```

## List all tracked files that have been deleted:
```shell
git ls-files -d
```

## List all untracked files (useful for verifying .gitignore):
```shell
git ls-files -o
```

<br><br>

## Commit all changes in index (staging area):
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

<br><br>

## Show changes in latest commit:
```shell
git show
```

## Show changes in a specific commit:
```shell
git show [commit-ID]
```

<br><br>

## Show commit history (both local and remote) for currently checked out branch:
```shell
git log
```

## Show commit history (both local and remote) for all branches:
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
git switch [branch-name | commit-ID]
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

## Force delete branch, even if not merged:
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

<br><br>

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

## Unstage a specific file in index (staging area):
```shell
git restore [file-name] --staged
git restore [file-name] -S
git reset [file-name]
```

## Unstage all files in index (staging area):
```shell
git restore . --staged
git restore . -S
git reset .
```

<br><br>

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

<br><br>

## Reset HEAD, index and working tree to the second latest local commit, effectively discarding the latest commit (only safe to do on commits not yet pushed to origin):
```shell
git reset --hard HEAD~1
```

## Reset HEAD, index and working tree to the third latest local commit, effectively discarding the two latest commits (only safe to do on commits not yet pushed to origin):
```shell
git reset --hard HEAD~2
```

## Reset HEAD, index and working tree to a specific local commit and discard all newer commits:
```shell
git reset --hard [commit-ID]
```

## Reset HEAD, index and working tree to latest commit in origin and discard all local commits:
```shell
git reset --hard origin/[branch-name]
```

<br><br>

## Revert changes made in latest commit (will create a new commit):
```shell
git revert HEAD
```

## Revert changes made in the second latest commit (will create a new commit):
```shell
git revert HEAD~1
```

## Revert changes made in a specific commit (will create a new commit):
```shell
git revert [commit-ID]
```

<br><br>

## Compare all files in working directory to current HEAD:
```shell
git diff
```

## Compare a specific directory or file in working directory to current HEAD:
```shell
git diff [directory-name | file-name]
```

## Compare all files in working directory to another branch or commit:
```shell
git diff [branch-name | commit-ID]
```

## Compare a specific directory or file in working directory to another branch or commit:
```shell
git diff [branch-name | commit-ID] [directory-name | file-name]
```

## Compare all files in a specific branch or commit to another branch or commit:
```shell
git diff [branch-name | commit-ID] [branch-name | commit-ID]
```

## Compare a specific directory or file in a specific branch or commit to another branch or commit:
```shell
git diff [branch-name | commit-ID] [branch-name | commit-ID] [directory-name | file-name]
```

<br><br>

## Merge a specific branch or commit into currently checked out branch:
```shell
git merge [branch-name | commit-ID]
```

## Abort an ongoing merge:
```shell
git merge --abort
```

<br><br>

<br><br>

https://ohshitgit.com/

!!! git tag - named versions for applications! TESTA! git tag --list (git tag -h)
!!! pop stash?
??? rebase ???
??? HUR ANVÄNDA ??? HEAD@{2}:

 "Also, since you're a Git beginner, I highly recommend you read the Pro Git book,""
