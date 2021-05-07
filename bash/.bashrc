alias ls='ls -FGh'
alias l='ls'
alias la='ls -A'
alias ll='ls -la'

alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

alias a='az'
alias b='brew'
alias c='curl'
alias cl='clear'
alias g='git'
alias k='kubectl'
alias m='midi'
alias p='pulumi'
alias t='terraform'

alias cx='chmod +x'
alias .b='. ~/.bashrc'
alias ip='curl -s ifconfig.io'

alias azls='az account list --output table'
alias azlog='az monitor activity-log list --correlation-id'

alias cdg='cd $(git rev-parse --show-toplevel)'
alias codeg='code $(git rev-parse --show-toplevel)'
alias openg='open $(git rev-parse --show-toplevel)'

alias gs='git status'
alias gf='git fetch'
alias gp='git pull'
alias gpu='git push'
alias gcl='git clone'
alias ga='git add $(git rev-parse --show-toplevel)'
alias gc='git commit'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gcm="git checkout \"\$(git remote show origin | grep 'HEAD' | cut -d' ' -f5)\""
alias gb='git branch'
alias gl='git log --oneline'
alias gla='git log --oneline --all'
alias gsl='git shortlog --summary'
alias gch='git cherry --verbose'
alias gchp='git cherry-pick'
alias gd='git diff'
alias gdo='git diff origin/$(git rev-parse --abbrev-ref HEAD)'
alias gdm="git diff \"\$(git remote show origin | grep 'HEAD' | cut -d' ' -f5)\""
alias gsh='git show'
alias gr='git remote'
alias grp='git rev-parse'
alias gres='git restore'
alias gt='git tag'
alias gm='git merge'
alias gls='git ls-files'
alias gclean='git clean -d --force'
alias gamend='git commit --amend --no-edit'
alias greset='git reset --hard origin/$(git rev-parse --abbrev-ref HEAD)'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias .......='cd ../../../../../..'

function up() {
    cd $(eval printf '../'%.0s {1..$1})
}

function cpbak() {
    if [[ -f "$2" ]]; then
        mv "$2" "$2.bak"
    fi

    cp "$1" "$2"
}

function pw() {
    case "$#" in
    0)
        passwordLength=16
        ;;
    1)
        passwordLength="$1"
        ;;
    *)
        echo -e "usage: genpass [<password-length>]"
        return
        ;;
    esac

    if [[ ${passwordLength} -lt 8 ]]; then
        echo -e "Password cannot be shorter than 8 characters"
        return
    fi

    chars='@#$%&_+='
    {
        LC_ALL=C grep </dev/urandom -ao '[A-Za-z0-9]' |
            head -n $(expr $passwordLength - 4)
        echo ${chars:$((RANDOM % ${#chars})):1}
        echo ${chars:$((RANDOM % ${#chars})):1}
        echo ${chars:$((RANDOM % ${#chars})):1}
        echo ${chars:$((RANDOM % ${#chars})):1}
    } |
        shuf |
        tr -d '\n' |
        pbcopy

    echo -e "A random password with ${passwordLength} characters is now in clipboard"
}

function gquick() {
    if [[ -z "$1" ]]; then
        message="Quick change"
    else
        message="$1"
    fi

    git add $(git rev-parse --show-toplevel)
    git commit --message "${message}"
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
        echo -e "usage: gba [<second-branch> | <first-branch> <second-branch>]"
        return
        ;;
    esac

    echo -e "\nComparing branch \"${firstBranch}\" to branch \"${secondBranch}\":\n"

    echo -e "BEHIND: $(git log --oneline "${firstBranch}".."${secondBranch}" | wc -l)"
    echo -e "AHEAD: \t$(git log --oneline "${secondBranch}".."${firstBranch}" | wc -l)"

    echo -e "\nCOMMITS BEHIND:"
    git log --oneline "${firstBranch}".."${secondBranch}"

    echo -e "\nCOMMITS AHEAD:"
    git log --oneline "${secondBranch}".."${firstBranch}"
    echo -e ""
}

function azapi() {
    if [[ "$#" == 0 ]]; then
        echo -e "usage: azapi <type>"
        return
    fi

    scriptPath=~/repos/code/pwsh/Azure/azapi.ps1
    chmod +x "${scriptPath}"
    "${scriptPath}" "$1" 1 -Clipboard
}

function midi() {
    if [[ "$#" == 0 ]]; then
        echo -e "usage: midi <file> [<transpose-steps>]"
        return
    fi

    if [[ -z "$2" ]]; then
        transposeSteps="0"
    else
        transposeSteps="$2"
    fi

    midiFile="$(echo ".$1" | sed 's/.abc$/.mid/')"
    abc2midi "$1" -o "${midiFile}"
    timidity -A100 -K"${transposeSteps}" -f "${midiFile}"
    rm "${midiFile}"
}

export PS1="\[\033[00;32m\]\u@\h\[\033[00m\]:\[\033[00;35m\]\w\[\033[36m\]\$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/')\[\033[00m\] $ "
export PATH="/usr/local/opt/curl/bin:$PATH"
