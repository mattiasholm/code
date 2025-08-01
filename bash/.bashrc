export PS1="\[\033[00;32m\]\u@\h\[\033[00m\]:\[\033[00;35m\]\w\[\033[36m\]\$(echo ' ('\$(git rev-parse --abbrev-ref HEAD 2>/dev/null)')' | sed 's/ ()//')\[\033[00m\] $ "
export PATH="/usr/local/sbin:$PATH"
export LSCOLORS='cxfxcxdxbxcgcdabagacad'
export GITHUB_TOKEN=$(cat ~/.config/gh/token)

alias -- -='cd -'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

alias ls='ls -FGh'
alias ll='ls -l'
alias la='ls -la'

alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

alias a='az'
alias b='brew'
alias c='curl'
alias d='docker'
alias e='echo'
alias f='find'
alias g='git'
alias h='history'
alias k='kubectl'
alias l='ll'
alias m='midi'
alias o='open'
alias p='pulumi'
alias t='terraform'
alias u='units'

alias cl='clear'
alias cls='clear'
alias cx='chmod +x'
alias er='echo $?'

alias azb='az bicep'
alias azr='az rest'
alias azli='az login'
alias azlo='az logout'
alias azwho='az ad signed-in-user show --query displayName --output tsv'
alias azls='az account list --output table'
alias azsh='az account show --output table'
alias azset='az account set --subscription'
alias azlog='az monitor activity-log list --correlation-id'

alias cdg='cd $(git rev-parse --show-toplevel)'
alias codeg='code $(git rev-parse --show-toplevel)'
alias openg='open $(git rev-parse --show-toplevel)'

alias extl='code --list-extensions'
alias exti='code --install-extension'
alias extu='code --uninstall-extension'

alias bl='brew list'
alias bi='brew install'
alias bu='brew upgrade'
alias bun='brew uninstall'

alias ipc='ipcalc'
alias pwsh='pwsh -NoLogo'
alias python='python3'

alias gcl='git clone'
alias gf='git fetch'
alias gp='git pull'
alias gs='git status'
alias gsh='git show'
alias gd='git diff'
alias gdo='git diff origin/$(git rev-parse --abbrev-ref HEAD)'
alias gdm="git diff \"\$(git remote show origin | grep 'HEAD' | cut -d' ' -f5)\""
alias ga='git add'
alias gr='git restore'
alias gc='git commit'
alias gpu='git push'
alias gm='git merge'
alias gl='git log --oneline'
alias gla='git log --oneline --all'
alias glog='git log'
alias gsl='git shortlog --summary'
alias gco='git checkout'
alias gcm="git checkout \"\$(git remote show origin | grep 'HEAD' | cut -d' ' -f5)\""
alias gb='git branch'
alias gt='git tag'
alias gch='git cherry --verbose'
alias gchp='git cherry-pick'
alias grem='git remote'
alias gsm='git submodule'
alias gls='git ls-files'
alias grp='git rev-parse'
alias gnr='git name-rev'
alias grev='git revert HEAD'
alias gamend='git commit --amend --no-edit'
alias gclean='git clean -d --force'
alias greset='git reset --hard origin/$(git rev-parse --abbrev-ref HEAD)'

function .b() {
    path=~/repos/code
    cp "$path/macOS/.bash_profile" ~/.bash_profile
    cp "$path/bash/.bashrc" ~/.bashrc
    cp "$path/bash/.inputrc" ~/.inputrc
    source ~/.bash_profile
    source ~/.bashrc
}

function ip() {
    ip="$(curl --silent ifconfig.io)"
    echo "$ip"
    echo -n "$ip" | pbcopy
}

function ipi() {
    curl --silent ipinfo.io/$1
}

function pw() {
    if [[ -z "$1" ]]; then
        length='16'
    else
        length="$1"
    fi

    if [[ -z "$2" ]]; then
        count='1'
    else
        count="$2"
    fi

    if [[ $length -lt 12 ]]; then
        echo 'Password should not be shorter than 12 characters'
        return
    fi

    pwgen --capitalize --numerals --symbols --secure --ambiguous $length $count | ghead -c -1 | pbcopy
    echo "$count random password(s) with $length characters added to clipboard"
}

function cpbak() {
    if [[ "$#" != 2 ]]; then
        echo 'usage: cpbak <sourceFile> <destinationFile>'
        return
    fi

    if [[ -f "$2" ]]; then
        mv "$2" "$2.bak"
    fi

    cp "$1" "$2"
}

function gquick() {
    if [[ -z "$1" ]]; then
        message="Quick change"
    else
        message="$1"
    fi

    git add --all
    git commit --message "$message"
    git push
}

function gba() {
    case "$#" in
    0)
        firstBranch="$(git rev-parse --abbrev-ref HEAD)"
        secondBranch="$(git remote show origin | grep 'HEAD' | cut -d' ' -f5)"
        ;;
    1)
        firstBranch="$(git rev-parse --abbrev-ref HEAD)"
        secondBranch="$1"
        ;;
    2)
        firstBranch="$1"
        secondBranch="$2"
        ;;
    *)
        echo 'usage: gba [<second-branch> | <first-branch> <second-branch>]'
        return
        ;;
    esac

    echo -e "\nComparing branch \"$firstBranch\" to branch \"$secondBranch\":\n"

    echo "BEHIND: $(git log --oneline "$firstBranch".."$secondBranch" | wc -l)"
    echo -e "AHEAD: \t$(git log --oneline "$secondBranch".."$firstBranch" | wc -l)"

    echo -e '\nCOMMITS BEHIND:'
    git log --oneline "$firstBranch".."$secondBranch"

    echo -e '\nCOMMITS AHEAD:'
    git log --oneline "$secondBranch".."$firstBranch"
    echo ''
}

function midi() {
    if [[ "$#" == 0 ]]; then
        echo 'usage: midi <file> [<transpose-steps>]'
        return
    fi

    if [[ -z "$2" ]]; then
        transposeSteps="0"
    else
        transposeSteps="$2"
    fi

    abcFile="$1"
    type=$(grep "R:" "$abcFile" --max-count 1 | sed 's/R://')

    case "$type" in
    "barndance")
        tempo="160"
        tmpFile="$(echo $abcFile | sed 's/.abc$/.mid/')"
        cat "$abcFile" | sed 's/barndance/hornpipe/' >"$tmpFile"
        abcFile="$tmpFile"
        ;;
    "hornpipe")
        tempo="150"
        ;;
    "jig")
        tempo="160"
        ;;
    "march")
        tempo="160"
        ;;
    "mazurka")
        tempo="160"
        ;;
    "polka")
        tempo="140"
        ;;
    "reel")
        tempo="170"
        ;;
    "slide")
        tempo="200"
        ;;
    "slip jig")
        tempo="170"
        ;;
    "strathspey")
        tempo="140"
        ;;
    "waltz")
        tempo="120"
        ;;
    *)
        tempo="120"
        echo -e "\033[33;1mWARNING: Tune type \"$type\" not recognized\033[0m"
        ;;
    esac

    midiFile="$(echo "$abcFile" | sed 's/.abc$/.mid/')"
    abc2midi "$abcFile" -Q $tempo -o "$midiFile"
    timidity "$midiFile" -A 300 -K "$transposeSteps" -Od
    rm "$midiFile"
}

function lock() {
    defaults write com.apple.Dock contents-immutable -bool true
    defaults write com.apple.Dock position-immutable -bool true
    defaults write com.apple.Dock size-immutable -bool true
    killall Dock
}

function unlock() {
    defaults write com.apple.Dock contents-immutable -bool false
    defaults write com.apple.Dock position-immutable -bool false
    defaults write com.apple.Dock size-immutable -bool false
    killall Dock
}
