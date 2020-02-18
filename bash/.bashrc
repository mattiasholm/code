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

alias cdgit='cd $(git rev-parse --show-toplevel)'
alias codegit='code $(git rev-parse --show-toplevel)'
alias opengit='open $(git rev-parse --show-toplevel)'

alias gs='git status'
alias gf='git fetch'
alias gp='git pull'
alias gpu='git push'
alias ga='git add .'
alias gco='git commit'
alias gc='git checkout'
alias gcm='git checkout master'
alias gb='git branch'
alias gl='git log --pretty=oneline'
alias gch='git cherry --verbose'
alias gd='git diff'
alias gr='git rev-parse'
alias gt='git tag'
alias gm='git merge'
alias gls='git ls-files'
alias gclean='git clean -d --force'
alias gamend='git commit --amend --no-edit'
alias greset='git reset --hard origin/$(git rev-parse --abbrev-ref HEAD)'

alias cx='chmod +x'

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

export PS1="\[\033[00;32m\]\u@\h\[\033[00m\]:\[\033[00;35m\]\w\[\033[36m\]\$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/')\[\033[00m\] $ "
