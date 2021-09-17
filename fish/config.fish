set --export PATH /usr/local/sbin $PATH

# set --export LSCOLORS cxfxcxdxbxcgcdabagacad
set --export LSCOLORS 'di=0;32'

set fish_greeting ''
set fish_prompt_pwd_dir_length 0
# set fish_color_command cyan
set fish_color_command green

# Bättre att sätta prompt hårt nedan??? Har ju redan ändrat lite gott och blandat, känns lite redundant nu!
# Värt att lägga till user@hostname ??? Sitter ju ändå aldrig med SSH mot någon server, endast lokalt på MBP...
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
    set -l last_pipestatus $pipestatus
    set -lx __fish_last_status $status

    if not set -q __fish_git_prompt_show_informative_status
        set -g __fish_git_prompt_show_informative_status 1
    end
    if not set -q __fish_git_prompt_hide_untrackedfiles
        set -g __fish_git_prompt_hide_untrackedfiles 1
    end
    if not set -q __fish_git_prompt_color_branch
        set -g __fish_git_prompt_color_branch magenta
    end
    if not set -q __fish_git_prompt_showupstream
        set -g __fish_git_prompt_showupstream informative
    end
    if not set -q __fish_git_prompt_color_dirtystate
        set -g __fish_git_prompt_color_dirtystate blue
    end
    if not set -q __fish_git_prompt_color_stagedstate
        set -g __fish_git_prompt_color_stagedstate yellow
    end
    if not set -q __fish_git_prompt_color_invalidstate
        set -g __fish_git_prompt_color_invalidstate red
    end
    if not set -q __fish_git_prompt_color_untrackedfiles
        set -g __fish_git_prompt_color_untrackedfiles $fish_color_normal
    end
    if not set -q __fish_git_prompt_color_cleanstate
        set -g __fish_git_prompt_color_cleanstate green --bold
    end

    set -l color_cwd
    set -l suffix
    if functions -q fish_is_root_user; and fish_is_root_user
        if set -q fish_color_cwd_root
            set color_cwd $fish_color_cwd_root
        else
            set color_cwd $fish_color_cwd
        end
        set suffix '#'
    else
        set color_cwd $fish_color_cwd
        set suffix '$'
    end

    set_color $color_cwd
    echo -n (prompt_pwd)
    set_color normal

    printf '%s ' (fish_vcs_prompt)

    set -l status_color (set_color $fish_color_status)
    set -l statusb_color (set_color --bold $fish_color_status)
    set -l prompt_status (__fish_print_pipestatus "[" "]" "|" "$status_color" "$statusb_color" $last_pipestatus)
    echo -n $prompt_status
    set_color normal

    echo -n "$suffix "
end

function gquick --argument-names message
    if not test $message
        set message 'Quick change'
    end
    git add (git rev-parse --show-toplevel)
    git commit --message $message
    git push
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
#         echo -e "usage: gba [<second-branch> | <first-branch> <second-branch>]"
#         return
#         ;;
#     esac

#     echo -e "\nComparing branch \"${firstBranch}\" to branch \"${secondBranch}\":\n"

#     echo -e "BEHIND: $(git log --oneline "${firstBranch}".."${secondBranch}" | wc -l)"
#     echo -e "AHEAD: \t$(git log --oneline "${secondBranch}".."${firstBranch}" | wc -l)"

#     echo -e "\nCOMMITS BEHIND:"
#     git log --oneline "${firstBranch}".."${secondBranch}"

#     echo -e "\nCOMMITS AHEAD:"
#     git log --oneline "${secondBranch}".."${firstBranch}"
#     echo -e ""
# }

# function up() {
#     cd $(eval printf '../'%.0s {1..$1})
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
#         echo -e "usage: genpass [<password-length>]"
#         return
#         ;;
#     esac

#     if [[ ${passwordLength} -lt 8 ]]; then
#         echo -e "Password cannot be shorter than 8 characters"
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

#     echo -e "A random password with ${passwordLength} characters is now in clipboard"
# }

# function midi() {
#     if [[ "$#" == 0 ]]; then
#         echo -e "usage: midi <file> [<transpose-steps>]"
#         return
#     fi

#     if [[ -z "$2" ]]; then
#         transposeSteps="0"
#     else
#         transposeSteps="$2"
#     fi

#     abcFile="$1"
#     type=$(grep "R:" "${abcFile}" | sed 's/R://')

#     case "${type}" in
#     "barndance")
#         tempo="160"
#         tmpFile=$(echo "${abcFile}" | sed 's/.abc/.mid/')
#         cat "${abcFile}" | sed 's/barndance/hornpipe/' >"${tmpFile}"
#         abcFile="${tmpFile}"
#         ;;
#     "hornpipe")
#         tempo="150"
#         ;;
#     "jig")
#         tempo="160"
#         ;;
#     "march")
#         tempo="160"
#         ;;
#     "polka")
#         tempo="140"
#         ;;
#     "reel")
#         tempo="170"
#         ;;
#     "slide")
#         tempo="200"
#         ;;
#     "slip jig")
#         tempo="170"
#         ;;
#     "strathspey")
#         tempo="140"
#         ;;
#     "waltz")
#         tempo="90"
#         ;;
#     *)
#         tempo="120"
#         echo -e "\033[33;1mWARNING: Tune type \"${type}\" not recognized\033[0m"
#         ;;
#     esac

#     midiFile="$(echo "${abcFile}" | sed 's/.abc$/.mid/')"
#     abc2midi "${abcFile}" -o "${midiFile}" -Q ${tempo}
#     timidity -f "${midiFile}" -A 300 -K "${transposeSteps}"
#     rm "${midiFile}"
# }
