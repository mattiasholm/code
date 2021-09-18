set --export PATH /usr/local/sbin $PATH
set --export LSCOLORS cxfxcxdxbxcgcdabagacad

set fish_greeting ''
set fish_prompt_pwd_dir_length 0
set __fish_git_prompt_color_untrackedfiles cyan
set __fish_git_prompt_color_dirtystate cyan

abbr -- - 'cd -'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

alias a='az'
alias b='brew'
alias c='curl'
alias d='dotnet'
alias e='echo'
alias f='fish'
alias g='git'
alias h='history'
alias k='kubectl'
alias l='ll'
alias m='midi'
alias p='pulumi'
alias t='terraform'

alias cl='clear'
alias cx='chmod +x'
alias ip='curl -s ifconfig.io' # Add pbcopy support
alias fc='fish_config'

alias azb='az bicep'
alias azli='az login'
alias azlo='az logout'
alias azls='az account list --output table'
alias azlog='az monitor activity-log list --correlation-id'

alias cdg='cd (git rev-parse --show-toplevel)'
alias codeg='code (git rev-parse --show-toplevel)'
alias openg='open (git rev-parse --show-toplevel)'

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
alias gdo='git diff origin/(git rev-parse --abbrev-ref HEAD)'
alias gdm='git diff (git remote show origin | grep HEAD | cut -d" " -f5)'
alias ga='git add (git rev-parse --show-toplevel)'
alias gr='git restore'
alias gc='git commit'
alias gpu='git push'
alias gm='git merge'
alias gl='git log --oneline'
alias gla='git log --oneline --all'
alias glog='git log'
alias gsl='git shortlog --summary'
alias gco='git checkout'
alias gcm='git checkout (git remote show origin | grep HEAD | cut -d" " -f5)'
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
alias greset='git reset --hard origin/(git rev-parse --abbrev-ref HEAD)'

function .f
    set path ~/repos/code
    cp $path/fish/config.fish ~/.config/fish/config.fish
    source ~/.config/fish/config.fish
end

function fish_prompt
    set branch \((git rev-parse --abbrev-ref HEAD 2> /dev/null)\)
    set suffix '$ '
    echo (set_color green)$USER@$hostname(set_color normal):(set_color magenta)(prompt_pwd)(set_color cyan) $branch (set_color normal)$suffix
end

function gquick --argument-names message
    if not test $message
        set message 'Quick change'
    end
    git add (git rev-parse --show-toplevel)
    git commit --message $message
    git push
end

function midi --argument-names abcFile transposeSteps
    if not test $abcFile
        echo "usage: midi <file> [<transpose-steps>]"
        return
    end

    if not test $transposeSteps
        set transposeSteps 0
    end

    set type (grep "R:" $abcFile | sed 's/R://')
    echo $type

    switch $type
        case barndance
            set tempo 160
            set tmpFile (echo $abcFile | sed 's/.abc/.mid/')
            cat $abcFile | sed s/barndance/hornpipe/ >$tmpFile
            set abcFile $tmpFile
        case hornpipe
            set tempo 150
        case jig
            set tempo 160
        case march
            set tempo 160
        case polka
            set tempo 140
        case reel
            set tempo 170
        case slide
            set tempo 200
        case slip jig
            set tempo 170
        case strathspey
            set tempo 140
        case waltz
            set tempo 90
        case '*'
            set tempo 120
            echo (set_color bryellow) WARNING: Tune type \"$type\" not recognized (set_color normal)

    end

    set midiFile (echo $abcFile | sed 's/.abc$/.mid/')
    abc2midi $abcFile -o $midiFile -Q $tempo
    timidity -f $midiFile -A 300 -K $transposeSteps
    rm $midiFile
end

# function gba() {
#     case "$#" in
#     0)
#         firstBranch="$(git rev-parse --abbrev-ref HEAD)"
#         secondBranch="$(git remote show origin | grep 'HEAD' | cut -d' ' -f5)"
#         ;;
#     1)
#         firstBranch="$(git rev-parse --abbrev-ref HEAD)"
#         secondBranch="$1"
#         ;;
#     2)
#         firstBranch="$1"
#         secondBranch="$2"
#         ;;
#     *)
#         echo "usage: gba [<second-branch> | <first-branch> <second-branch>]"
#         return
#         ;;
#     esac

#     echo -e "\nComparing branch \"${firstBranch}\" to branch \"${secondBranch}\":\n"

#     echo "BEHIND: $(git log --oneline "${firstBranch}".."${secondBranch}" | wc -l)"
#     echo -e "AHEAD: \t$(git log --oneline "${secondBranch}".."${firstBranch}" | wc -l)"

#     echo -e "\nCOMMITS BEHIND:"
#     git log --oneline "${firstBranch}".."${secondBranch}"

#     echo -e "\nCOMMITS AHEAD:"
#     git log --oneline "${secondBranch}".."${firstBranch}"
#     echo ""
# }

# function cpbak() {
#     if [[ -f "$2" ]]; then
#         mv "$2" "$2.bak"
#     fi

#     cp "$1" "$2"
# }

# function pw() {
#     case "$#" in
#     0)
#         passwordLength=16
#         ;;
#     1)
#         passwordLength="$1"
#         ;;
#     *)
#         echo "usage: genpass [<password-length>]"
#         return
#         ;;
#     esac

#     if [[ ${passwordLength} -lt 8 ]]; then
#         echo "Password cannot be shorter than 8 characters"
#         return
#     fi

#     chars='@#$%&_+='
#     {
#         LC_ALL=C grep </dev/urandom -ao '[A-Za-z0-9]' |
#             head -n $(expr $passwordLength - 4)
#         echo ${chars:$((RANDOM % ${#chars})):1}
#         echo ${chars:$((RANDOM % ${#chars})):1}
#         echo ${chars:$((RANDOM % ${#chars})):1}
#         echo ${chars:$((RANDOM % ${#chars})):1}
#     } |
#         shuf |
#         tr -d '\n' |
#         pbcopy

#     echo "A random password with ${passwordLength} characters is now in clipboard"
# }
