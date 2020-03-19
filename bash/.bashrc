alias ls='ls -FGh'
alias l='ls'
alias la='ls -A'
alias ll='ls -la'

alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

alias g='git'
alias k='kubectl'
alias p='pulumi'
alias t='terraform'

alias cdg='cd $(git rev-parse --show-toplevel)'
alias codeg='code $(git rev-parse --show-toplevel)'
alias openg='open $(git rev-parse --show-toplevel)'

alias gs='git status'
alias gf='git fetch'
alias gp='git pull'
alias gpu='git push'
alias ga='git add .'
alias gc='git commit'
alias gco='git checkout'
alias gcm='git checkout master'
alias gb='git branch'
alias gl='git log --oneline --graph'
alias gla='git log --oneline --graph --all'
alias gch='git cherry --verbose'
alias gd='git diff'
alias gdo='git diff origin'
alias gdm='git diff master'
alias gsh='git show'
alias gr='git rev-parse'
alias gt='git tag'
alias gm='git merge'
alias gls='git ls-files'
alias gclean='git clean -d --force'
alias gamend='git commit --amend --no-edit'
alias greset='git reset --hard origin/$(git rev-parse --abbrev-ref HEAD)'

alias cx='chmod +x'
alias .b='. ~/.bashrc'

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

export PS1="\[\033[00;32m\]\u@\h\[\033[00m\]:\[\033[00;35m\]\w\[\033[36m\]\$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/')\[\033[00m\] $ "
