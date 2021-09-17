export PS1="\[\033[00;32m\]\u@\h\[\033[00m\]:\[\033[00;35m\]\w\[\033[36m\]\$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/')\[\033[00m\] $ "
export PATH="/usr/local/opt/curl/bin:$PATH"

alias .b='. ~/.bashrc'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

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
alias d='dotnet'
alias f='fish'
alias g='git'
alias h='history'
alias k='kubectl'
alias m='midi'
alias p='pulumi'
alias t='terraform'

alias cl='clear'
alias cx='chmod +x'
alias ip='ip=$(curl -s ifconfig.io) && (echo $ip ; echo -n $ip | pbcopy)'

alias azb='az bicep'
alias azli='az login'
alias azlo='az logout'
alias azls='az account list --output table'
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

alias gcl='git clone'
alias gf='git fetch'
alias gp='git pull'
alias gs='git status'
alias gsh='git show'
alias gd='git diff'
alias gdo='git diff origin/$(git rev-parse --abbrev-ref HEAD)'
alias gdm="git diff \"\$(git remote show origin | grep 'HEAD' | cut -d' ' -f5)\""
alias ga='git add $(git rev-parse --show-toplevel)'
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
alias gamend='git commit --amend --no-edit'
alias gclean='git clean -d --force'
alias greset='git reset --hard origin/$(git rev-parse --abbrev-ref HEAD)'

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

    abcFile="$1"
    type=$(grep "R:" "${abcFile}" | sed 's/R://')

    case "${type}" in
    "barndance")
        tempo="160"
        tmpFile=$(echo "${abcFile}" | sed 's/.abc/.mid/')
        cat "${abcFile}" | sed 's/barndance/hornpipe/' >"${tmpFile}"
        abcFile="${tmpFile}"
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
        tempo="90"
        ;;
    *)
        tempo="120"
        echo -e "\033[33;1mWARNING: Tune type \"${type}\" not recognized\033[0m"
        ;;
    esac

    midiFile="$(echo "${abcFile}" | sed 's/.abc$/.mid/')"
    abc2midi "${abcFile}" -o "${midiFile}" -Q ${tempo}
    timidity -f "${midiFile}" -A 300 -K "${transposeSteps}"
    rm "${midiFile}"
}
