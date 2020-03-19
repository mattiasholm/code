# Cheat Sheet - git

<br>

## Official docs:
https://git-scm.com/docs

## Oh Shit, Git!?!:
https://ohshitgit.com/

<br><br>

## Check Git version:
```shell
git --version
```

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

## Add a new remote (e.g. `origin` when initiating a new repo or `upstream` when using the forking workflow):
```shell
git remote add <name> <url>
```

## Rename a remote:
```shell
git remote rename <old-name> <new-name>
```

## Remove a remote:
```shell
git remote remove <name>
```

## Show the name of all remotes:
```shell
git remote
```

## Show the name and URL of all remotes:
```shell
git remote --verbose
git remote -v
```

## Show the URL of `origin`:
```shell
git remote get-url origin
````

## Show the URL of a specific remote:
```shell
git remote get-url <remote-name>
````

## Show root directory of the current repository:
```shell
git rev-parse --show-toplevel
```

## Exclude a file pattern from source control:
```shell
cd "$(git rev-parse --show-toplevel)"

vim .gitignore

<pattern>
```

<br><br>

## Fetch metadata from `origin` (will not touch your working tree or current `HEAD`):
```shell
git fetch
git fetch origin
```

## Fetch metadata from branch `master` in remote `upstream` when using the forking workflow (will not touch your working tree or current `HEAD`):
```shell
git fetch upstream master
```

## Fetch metadata from all remotes (will not touch your working tree or current `HEAD`):
```shell
git fetch --all
```

## Pull changes from `origin` (will integrate remote changes into your working tree and current `HEAD`):
```shell
git pull
git pull origin
```

## Pull changes from branch `master`in remote `upstream` when using the forking workflow (will integrate remote changes into your working tree and current `HEAD`):
```shell
git pull upstream master
```

## Pull changes from all remotes (will integrate remote changes into your working tree and current `HEAD`):
```shell
git pull --all
```

## Pull changes from `origin`, but abort if the fast-forward strategy is not possible and decide for yourself if you want to merge or rebase:
```shell
git pull --ff-only
```

## Pull changes from `origin`, force overwrite of local branch:
```shell
git pull --force
git pull -f
```

## Pull changes from `origin`, prune remote-tracking branches no longer on remote:
```shell
git pull --prune
git pull -p
```

## Pull all tags from `origin`:
```shell
git pull --tags
git pull -t
```

<br><br>

## Show currently checked out branch and status of working tree and index (branch-specific staging area):
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

## Stage all modified and untracked files to index (branch-specific staging area):
```shell
git add .
git stage .
```

## Stage only files already tracked to index (branch-specific staging area):
```shell
git add --update
git add -u
git stage --update
git stage -u
```

## Stage all modified, untracked and removed files to index (branch-specific staging area):
```shell
git add --all
git add -A
git stage --all
git stage -A
```

## Stage only a specific file to index (branch-specific staging area):
```shell
git add <file-name>
git stage <file-name>
```

<br><br>

## Remove a file from working tree and index (branch-specific staging area):
```shell
git rm <file-name>
```

<br><br>

## Rename/move a file in working tree and index (branch-specific staging area):
```shell
git mv <file-name> <new-name | destination-path>
```

<br><br>

## List all tracked files in repository:
```shell
git ls-files
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

## List all tracked files that match a specific file pattern:
```shell
git ls-files | grep <pattern>
```

<br><br>

## Commit all changes in index (branch-specific staging area):
```shell
git commit --message "<message>"
git commit -m "<message>"
```

<br><br>

## Push locally committed changes to `origin`:
```shell
git push
```

## Push changes to a new branch that doesn't exist in `origin`:
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
git rev-parse <tag-name>
cat .git/refs/tags/<tag-name>
```

## Create an unannotated tag that will reference the currently checked out branch:
```shell
git tag <tag-name>
```

## Create an unannotated tag that will reference a specific branch, commit or even another tag:
```shell
git tag <tag-name> <branch-name | commit-id | tag-name>
```

## Create an annotated tag that will reference the currently checked out branch:
```shell
git tag --annotate <tag-name> --message <message>
git tag -a <tag-name> -m <message>
```

## Create an annotated tag that will reference a specific branch, commit or even another tag:
```shell
git tag --annotate <tag-name> --message <message> <branch-name | commit-id | tag-name>
git tag -a <tag-name> -m <message> <branch-name | commit-id | tag-name>
```

## Delete a tag:
```shell
git tag -d <tag-name>
```

## Push an unannotated tag to `origin`:
```shell
git push origin <tag-name>
```

## Push all annotated tags to `origin`:
```shell
git push --follow-tags
```

<br><br>

## Show all local commits, not yet pushed to `origin`:
```shell
git cherry --verbose
git cherry -v
```

## Cherry-pick a commit from another branch and add it to currently checked out branch:
```shell
git cherry-pick <branch-name>
```


<br><br>

## Show actual changes in latest commit:
```shell
git show
```

## Show actual changes in a specific branch, commit or tag:
```shell
git show <branch-name | commit-id | tag-name>
```

## Show only log entry for a specific specific branch, commit or tag (i.e. omit displaying actual changes):
```shell
git show <branch-name | commit-id | tag-name> --quiet
git show <branch-name | commit-id | tag-name> -q
git show <branch-name | commit-id | tag-name> --no-patch
git show <branch-name | commit-id | tag-name> -s
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

## Show commit history in one-line-per-commit format, with full commit IDs:
```shell
git log --pretty=oneline
```

## Show commit history in one-line-per-commit format, with commit IDs in short format:
```shell
git log --oneline
```

## Show commit history, with a graphical representation of the branch structure:
```shell
git log --graph
```

## Show commit history, with full reference names (including prefix):
```shell
git log --decorate=full
```

## Show commit history, display insertion/deletion statistics for each commit:
```shell
git log --stat
```

## Show commit history, display actual changes for each commit (basically executes `git show` iteratively):
```shell
git log --patch
git log -p
git log -u
```

## Show commit history, display both statistics and actual changes for each commit:
```shell
git log --patch-with-stat
git log --patch --stat
```

## Show commit history, include only merge commits:
```shell
git log --merges
git log --min-parents=2
```

## Show commit history, exclude merge commits:
```shell
git log --no-merges
git log --max-parents=1
```

## Show commit history, include `n` latest commits:
```shell
git log -<n>
```

## Show commit history for a specific author:
```shell
git log --author "<author-name>"
```

## Show commit history for a specific file:
```shell
git log -- <file-name>
```

## Show commit history, include only commits with a message that match a specific pattern:
```shell
git log --grep="<pattern>"
```

## Show commit history, include only commits that introduce or remove a particular line of code:
```shell
git log -S "<pattern>"
```

## Show commit history, before or after 1 month ago:
```shell
git log [--before | --after] "1 month ago"
```

## Show commit history, before or after 1 week ago:
```shell
git log [--before | --after] "1 week ago"
```

## Show commit history, before or after yesterday (i.e. 1 day ago):
```shell
git log [--before | --after] "yesterday"
```

## Show commit history, before or after a specific date:
```shell
git log [--before | --after] "<YYYY-MM-DD>"
```

## Show commit history, before or after a specific date/time:
```shell
git log [--before | --after] "<YYYY-MM-DD HH:MM:SS>"
```

## Show commit history, include all commits between two specific branches or commits (useful for getting ahead/behind stats between `master` and a feature branch):
```shell
git log <branch-name | commit-id>..<branch-name | commit-id>
```

<br><br>

## Show commits in currently checked out branch, grouped by author:
```shell
git shortlog
```

## Show commits in all branches, grouped by author:
```shell
git shortlog --all
```

## Show commits in currently checked out branch, grouped by author (display email):
```shell
git shortlog --email
git shortlog -e
```

## Show commits in all branches, grouped by author (display email):
```shell
git shortlog --email --all
git shortlog -e --all
```

## Count number of commits in currently checked out branch, grouped by author:
```shell
git shortlog --summary
git shortlog -s
```

## Count number of commits in all branches, grouped by author:
```shell
git shortlog --summary --all
git shortlog -s --all
```

## Count total number of commits in currently checked out branch:
```shell
git log --oneline | wc -l
git log --pretty=oneline | wc -l
```

## Count total number of commits in all branches:
```shell
git log --oneline --all | wc -l
git log --pretty=oneline --all | wc -l
```

<br><br>

## Show reference log (basically undo history):
```shell
git reflog
```

## List commit ID of current `HEAD`:
```shell
git rev-parse HEAD
cat .git/refs/heads/master
```

## List commit ID of `HEAD` for all branches (both local and remote):
```shell
git show-ref
```

## List commit ID of current `HEAD` and for all branches (both local and remote):
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

## List all local branches and their respective `HEAD`:
```shell
git branch --verbose
git branch -v
```

## List all remote branches:
```shell
git branch --remote
git branch -r
```

## List both local and remote branches:
```shell
git branch --all
git branch -a
```

## Create a new branch based on current `HEAD`:
```shell
git branch <branch-name>
```

## Create a new branch based on a specific branch or commit:
```shell
git branch <branch-name> <base-branch | base-commit>
```

## Check out a specific branch:
```shell
git switch <branch-name>
```

## Check out a specific branch, commit or tag:
```shell
git checkout <branch-name | commit-id | tag-name>
```

## Check out a specific file or directory from another branch, commit or tag (effectively discarding the versions in current branch):
```shell
git checkout <branch-name | commit-id | tag-name> <file-name | directory-name>
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
git branch --delete --force <branch-name>
git branch -D <branch-name>
```

## Delete a remote branch in a specific remote:
```shell
git push <remote-name> --delete <branch-name>
```

<br><br>

## Amend message of latest commit:
```shell
git commit --amend --message "<commit-message>"
```

## Amend code in latest commit (only safe to do on commits not yet pushed to `origin`):
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

## Unstage a specific file in index (branch-specific staging area):
```shell
git restore <file-name> --staged
git restore <file-name> -S
git reset <file-name>
```

## Unstage all files in index (branch-specific staging area):
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

## Reset `HEAD`, index and working tree to the second latest local commit, effectively discarding the latest commit (only safe to do on commits not yet pushed to `origin`):
```shell
git reset --hard HEAD~1
```

## Reset `HEAD`, index and working tree to the third latest local commit, effectively discarding the two latest commits (only safe to do on commits not yet pushed to `origin`):
```shell
git reset --hard HEAD~2
```

## Reset `HEAD`, index and working tree to a specific local commit and discard all newer commits (only safe to do on commits not yet pushed to origin):
```shell
git reset --hard <commit-id>
```

## Reset `HEAD`, index and working tree to latest commit in `origin` and discard all local commits:
```shell
git reset --hard origin/<branch-name>
```

## Reset only `HEAD`:
```shell
git reset --soft origin/<branch-name>
```

## Reset `HEAD` and index:
```shell
git reset --mixed origin/<branch-name>
```

## Reset `HEAD`, but keep local changes in working tree:
```shell
git reset --keep origin/<branch-name>
```

<br><br>

## Revert changes made in latest commit (will make a new commit):
```shell
git revert HEAD
```

## Revert changes made in the second latest commit (will make a new commit):
```shell
git revert HEAD~1
```

## Revert changes made in a specific commit (will make a new commit):
```shell
git revert <commit-id>
```

## Revert changes made in a specific commit, without automatically making a new commit:
```shell
git revert <commit-id> --no-commit
```

<br><br>

## Compare all files in working directory to current `HEAD`:
```shell
git diff
git diff HEAD
```

## Compare all files in working directory to latest commit in `origin`:
```shell
git diff origin
```

## Compare a specific directory or file in working directory to current `HEAD`:
```shell
git diff <directory-name | file-name>
```

## Compare all files in working directory to another branch, commit or tag:
```shell
git diff <branch-name | commit-id | tag-name>
```

## Compare a specific directory or file in working directory to another branch, commit or tag:
```shell
git diff <branch-name | commit-id | tag-name> <directory-name | file-name>
```

## Compare all files in a specific branch, commit or tag to another branch, commit or tag:
```shell
git diff <branch-name | commit-id | tag-name> <branch-name | commit-id | tag-name>
```

## Compare a specific directory or file in a specific branch, commit or tag to another branch, commit or tag:
```shell
git diff <branch-name | commit-id | tag-name> <branch-name | commit-id | tag-name> <directory-name | file-name>
```

<br><br>

## Merge a specific branch, commit or tag into currently checked out branch (will make a merge commit automatically):
```shell
git merge <branch-name | commit-id | tag-name> --message "<message>"
git merge <branch-name | commit-id | tag-name> -m "<message>"
```

## Merge a specific branch, commit or tag into currently checked out branch, without automatically making a merge commit:
```shell
git merge <branch-name | commit-id | tag-name> --message "<message>" --no-commit
```

## Merge a specific branch, commit or tag into currently checked out branch, without allowing the fast-forward strategy (i.e. a merge commit will always be created):
```shell
git merge <branch-name | commit-id | tag-name> --message "<message>" --no-ff
```

## Merge a specific branch, commit or tag into currently checked out branch, but abort if the fast-forward strategy is not possible, e.g. if merge conflicts cannot be resolved automatically:
```shell
git merge <branch-name | commit-id | tag-name> --message "<message>" --ff-only
```

## Make a squash merge, i.e. merge changes into working tree, without touching `HEAD` (a manual commit is then made to consolidate multiple commits into a single commit):
```shell
git merge <branch-name | commit-id | tag-name> --squash

git commit --message  --message "<message>"
```

<br><br>

## Abort an ongoing merge (for example if there's a merge conflict that you cannot solve:
```shell
git merge --abort
```

# Fix a merge conflict that cannot be automatically solved:
```shell
git status

vim <conflicting-file>

# Accept current (ours), incoming (theirs) or both changes by removing the conflict markers and updating the file accordingly:

<<<<<<< HEAD
<current-change>
=======
<incoming-change>
>>>>>>> <other-branch>

git add .

git commit --message "<message>"

# Finally, if you want the other branch to include the changes, you also need to make a merge in the opposite direction:

git checkout <other-branch>

git merge <first-branch>
```

## Revert changes made in a specific merge (keep parent side of the merge, i.e. the branch we merged into):
```shell
git revert <merge-commit-id> --mainline 1
git revert <merge-commit-id> -m 1
```

## Revert changes made in a specific merge (keep child side of the merge, i.e. the branch we merged from):
```shell
git revert <merge-commit-id> --mainline 2
git revert <merge-commit-id> -m 2
```

<!--
TO-DO:

Selective merging? Användbart för B3CAf när vi endast vill merga in specifika filer, framförallt exkludera allt i variables mappen!
https://www.haykranen.nl/2011/07/18/git-merging-specific-files-from-another-branch/ + https://help.github.com/en/github/creating-cloning-and-archiving-repositories/duplicating-a-repository + https://gist.github.com/katylava/564416 + https://stackoverflow.com/questions/449541/how-to-selectively-merge-or-pick-changes-from-another-branch-in-git



SKRIV MED ETT REBASE exempel i git README åtminstone!
OBS: Rebase verkar göras mot tracking branch, dvs. origin?! Känns farligt...
Kanske bättre med squash merges som är halvvägs?

# Rebase feature branch onto master (moves entire feature branch onto the tip of the master branch, effectively incorporating all of the new commits in master)
# Instead of using a merge commit, rebasing rewrites the project history by creating brand new commits for each commit in the original branch!
git checkout feature
git rebase master



FLER TIPS ATT SAXA HÄRIFRÅN?
https://ohshitgit.com/
-->