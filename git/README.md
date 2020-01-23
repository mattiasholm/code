# Cheat Sheet

<br>

## Official documentation:
https://git-scm.com/docs

## Oh Shit, Git!?!:
https://ohshitgit.com/

<br><br>

## Clear saved credentials:
git config --system --unset credential.helper

## Enable credential helper to save/cache credentials:
`Mac` git config --global credential.helper osxkeychain
`Windows` git config --global credential.helper wincred
`Linux` git config --global credential.helper 'cache --timeout=86400'

## Configure global username:
git config --global user.name "Mattias Holm"

## Configure global email address:
git config --global user.email "mattias.holm@live.com"

<br><br>

## Clone repo via HTTP (as opposed to SSH):
git clone [URL]

## Fetch metadata from origin (without touching your current HEAD):
git fetch

## Pull changes from origin (will update your current HEAD with remote changes):
git pull

## Display status of working tree and staging area:
git status

## Add all new and modified files to staging area:
git add .

## Add only files already tracked to staging area:
git add -u

## Add all new, modified and removed files to staging area:
git add --all
git add --A

## Commit changes in staging area:
git commit -m "[commit-message]"

## Push locally committed changes to origin:
git push

## Push changes to a new branch that doesn't exist in origin:
git push --set-upstream origin [branch-name]

## View log:
git log

<br><br>

## Checkout a specific branch or commit ID:
git checkout [branch-name | commit-ID]

## Create a new branch based on origin/master:
git checkout master
git pull
git branch [branch-name]

## Checkout and create a new branch in a single command:
git checkout -b [branch-name]

## List all branches:
git branch

<br><br>

## Restore modified file in working tree from latest commit:
git checkout [file-name]

## Restore all modified files in working tree from latest commit:
git checkout .

## Discard modified file in working tree:
git restore [file-name]

## Discard all modified files in working tree:
git restore .

## Remove modified file from staging area:
git restore --staged [file-name]

## Remove all files from staging area:
git restore --staged .

<br><br>

## FLER TIPS OCH TRIX ???
https://stackoverflow.com/questions/8358035/whats-the-difference-between-git-revert-checkout-and-reset

pop stash?
Fler?
rebase?
--amend