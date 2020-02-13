# Cheat Sheet

<br>

## Official docs:
https://git-scm.com/docs

## Oh Shit, Git!?!:
https://ohshitgit.com/

<br><br>

## Contextual manual:
```shell
git <subcommand> --help

git help <subcommand>
```

## Contextual syntax help:
```shell
git <subcommand> -h
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
git <subcommand> --dry-run

git <subcommand> -n
```

<br><br>

## Enable credential helper to save/cache credentials globally:

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

## Configure username globally:
```shell
git config --global user.name "<name>"
```

## Configure email address globally:
```shell
git config --global user.email "<email>"
```

## Force case-sensitivity globally:
```shell
git config --global --unset-all core.ignorecase &&
    git config --global core.ignorecase false
```

## Remove a specific configuration key globally:
```shell
git config --global --unset-all <key>
```

## List global configuration (all repositores):
```shell
git config --global --list

git config --global -l
```

## List local configuration (only current repository):
```shell
git config --local --list

git config --local -l
```

## Edit the global config directly in `vim`:
```shell
git config --global --edit
```

<br><br>

## Create a new repository in working directory:
```shell
git init
```

## Clone remote repository to working directory:
```shell
git clone <URL>
```

## Show the remote URL for the current repository:
```shell
git remote --verbose

git remote -v
```

## Show root directory of the current repository:
```shell
git rev-parse --show-toplevel
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

git stage .
```

## Stage only files already tracked to index (staging area):
```shell
git add --update

git add -u

git stage --update

git stage -u
```

## Stage all modified, untracked and removed files to index (staging area):
```shell
git add --all

git add -A

git stage --all

git stage -A
```

## Stage only a specific file to index (staging area):
```shell
git add <file-name>

git stage <file-name>
```

<br><br>

## Remove a file from working tree and index (staging area):
```shell
git rm <file-name>
```

<br><br>

## Rename/move a file in working tree and index (staging area):
```shell
git mv <file-name> <new-name | destination-path>
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
git commit --message "<message>"

git commit -m "<message>"
```

<br><br>

## Push locally committed changes to origin:
```shell
git push
```

## Push changes to a new branch that doesn't exist in origin:
```shell
git push --set-upstream origin <branch-name>

git push -u origin <branch-name>
```

<br><br>

## Stash changes in working directory away, in order to get a clean working tree:
```shell
git stash
```

## Pop back changes stashed away:
```shell
git stash pop
```

## List all stashes:
```shell
git stash list
```

## Show changes in stash:
```shell
git stash show
```

<br><br>

## List all tags:
```shell
git tag
```

## List the commit ID that a specific tag references to:
```shell
cat .git/refs/tags/<tag-name>
```

## Create a new tag that will reference the currently checked out branch or commit:
```shell
git tag <tag-name>
```

## Create a new tag that will reference a specific branch, commit or even another tag:
```shell
git tag <tag-name> <branch-name | commit-ID>
```

## Delete a tag:
```shell
git tag -d <tag-name>
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
git show <commit-ID>
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

## Show commit history in one-line-per-commit format:
```shell
git log --pretty=oneline
```

## Count total number of commits:
```shell
git log --pretty=oneline | wc -l
```


## Show reference log (basically undo history):
```shell
git reflog
```

## List commit ID of current HEAD:
```shell
git rev-parse HEAD

cat .git/refs/heads/master
```

## List commit ID of HEAD for all branches (both local and remote):
```shell
git show-ref
```

## List commit ID of current HEAD and for all branches (both local and remote):
```shell
git show-ref --heads
```

## Show author and commit ID for each line of a file:
```shell
git blame <file-name>
```

<br><br>

## List currently checked out branch:
```shell
git branch --show-current

git rev-parse --abbrev-ref HEAD

git symbolic-ref --short -q HEAD

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
git branch <branch-name>
```

## Create a new branch based on a specific branch or commit:
```shell
git branch <branch-name> <base-branch>
```

## Check out a specific branch:
```shell
git switch <branch-name>
```

## Check out a specific branch or commit:
```shell
git checkout <branch-name | commit-ID>
```

## Switch back to the previously checked out branch or commit:
```shell
git checkout -

git switch -
```

## Create and check out a new branch in a single command:
```shell
git checkout -b <branch-name> [<base-branch>]

git switch --create <branch-name> [<base-branch>]

git switch -c <branch-name> [<base-branch>]
```

## Rename currently checked out local branch:
```shell
git branch --move <new-name>

git branch -m <new-name>
```

## Rename a specific local branch:
```shell
git branch --move <branch-name> <new-name>

git branch -m <branch-name> <new-name>
```

## Copy currently checked out local branch:
```shell
git branch --copy <new-name>

git branch -c <new-name>
```

## Copy a specific local branch:
```shell
git branch --copy <branch-name> <new-name>

git branch -c <branch-name> <new-name>
```

## Delete a fully merged branch:
```shell
git branch --delete <branch-name>

git branch -d <branch-name>
```

## Force delete branch, even if not merged:
```shell
git branch -D <branch-name>
```

<br><br>

## Amend message of previous commit:
```shell
git commit --amend -m "<commit-message>"
```

## Amend code in previous commit (only safe to do on commits not yet pushed to origin):
```shell
git commit --amend --no-edit
```

<br><br>

## Discard changes to a specific file in working tree (will not touch staging area):
```shell
git restore <file-name>

git checkout <file-name>
```

## Discard changes to all tracked files in working tree (will not touch staging area):
```shell
git restore .

git checkout .
```

## Unstage a specific file in index (staging area):
```shell
git restore <file-name> --staged

git restore <file-name> -S

git reset <file-name>
```

## Unstage all files in index (staging area):
```shell
git restore . --staged

git restore . -S

git reset .
```

<br><br>

## Remove all untracked files from working tree:
```shell
git clean --force

git clean -f
```

## Remove all untracked files and directories from working tree:
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

## Reset HEAD, index and working tree to a specific local commit and discard all newer commits (only safe to do on commits not yet pushed to origin):
```shell
git reset --hard <commit-ID>
```

## Reset HEAD, index and working tree to latest commit in origin and discard all local commits:
```shell
git reset --hard origin/<branch-name>
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
git revert <commit-ID>
```

<br><br>

## Compare all files in working directory to current HEAD:
```shell
git diff
```

## Compare all files in working directory to latest commit in origin:
```shell
git diff origin
```

## Compare a specific directory or file in working directory to current HEAD:
```shell
git diff <directory-name | file-name>
```

## Compare all files in working directory to another branch or commit:
```shell
git diff <branch-name | commit-ID
```

## Compare a specific directory or file in working directory to another branch or commit:
```shell
git diff <branch-name | commit-ID> <directory-name | file-name>
```

## Compare all files in a specific branch or commit to another branch or commit:
```shell
git diff <branch-name | commit-ID> <branch-name | commit-ID>
```

## Compare a specific directory or file in a specific branch or commit to another branch or commit:
```shell
git diff <branch-name | commit-ID> <branch-name | commit-ID> <directory-name | file-name>
```

<br><br>

## Merge a specific branch or commit into currently checked out branch:
```shell
git merge <branch-name | commit-ID> --message "<message>"

git merge <branch-name | commit-ID> -m "<message>"
```

## Abort an ongoing merge:
```shell
git merge --abort
```

<br>

<!--

## TO-DO:

??? REVERT MERGE:
git revert --mainline 1
git revert -m 1
TESTA DOCK INNAN LÄGGER TILL!

<br>

FLER TIPS ATT SAXA HÄRIFRÅN?
https://ohshitgit.com/

<br>

GOOLGLA GIT CHEAT SHEET FÖR IDÈER - dock ingen idé att kopiera saker rakt av utan att testa ordentligt - vill bara ha med saker jag faktiskt känner att jag kommer att ha användning av!

-->