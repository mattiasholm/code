set -x PATH /usr/local/sbin $PATH
set -x LSCOLORS cxfxcxdxbxcgcdabagacad
set -x GITHUB_TOKEN (cat ~/.config/gh/token)

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
alias er='echo $status'
alias fc='fish_config'

alias azb='az bicep'
alias azr='az rest'
alias azli='az login'
alias azlo='az logout'
alias azwho='az ad signed-in-user show --query displayName --output tsv'
alias azls='az account list --output table'
alias azsh='az account show --output table'
alias azset='az account set --subscription'
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

alias ipc='ipcalc'
alias pwsh='pwsh -NoLogo'
alias python='python3'

alias gcl='git clone'
alias gf='git fetch'
alias gp='git pull'
alias gs='git status'
alias gsh='git show'
alias gd='git diff'
alias gdo='git diff origin/(git rev-parse --abbrev-ref HEAD)'
alias gdm='git diff (git remote show origin | grep HEAD | cut -d" " -f5)'
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
alias gcm='git checkout (git remote show origin | grep HEAD | cut -d" " -f5)'
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
alias greset='git reset --hard origin/(git rev-parse --abbrev-ref HEAD)'

function fish_prompt
    set branch (git rev-parse --abbrev-ref HEAD 2>/dev/null)
    set suffix '$ '
    echo (set_color green)$USER@$hostname(set_color normal):(set_color magenta)(prompt_pwd)(set_color cyan) \($branch\) (set_color normal)$suffix
end

function .f
    set path ~/repos/code
    cp $path/fish/config.fish ~/.config/fish/config.fish
    source ~/.config/fish/config.fish
end

function ip
    set ip (curl --silent ifconfig.io)
    echo $ip
    echo -n $ip | pbcopy
end

function ipi --argument-names ip
    if not test $ip
        set ip ''
    end

    curl --silent ipinfo.io/$ip
end

function pw --argument-names length count
    if not test $length
        set length 16
    end

    if not test $count
        set count 1
    end

    if test $length -lt 12
        echo 'Password should not be shorter than 12 characters'
        return
    end

    pwgen --capitalize --numerals --symbols --secure --ambiguous $length $count | ghead -c -1 | pbcopy
    echo "$count random password(s) with $length characters added to clipboard"
end

function cpbak --argument-names sourceFile destinationFile
    if test (count $argv) -ne 2
        echo 'usage: cpbak <sourceFile> <destinationFile>'
        return
    end

    if test -e $destinationFile
        mv $destinationFile "$destinationFile.bak"
    end

    cp $sourceFile $destinationFile
end

function gquick --argument-names message
    if not test $message
        set message 'Quick change'
    end
    git add --all
    git commit --message $message
    git push
end

function gba
    switch (count $argv)
        case 0
            set firstBranch (git rev-parse --abbrev-ref HEAD)
            set secondBranch (git remote show origin | grep HEAD | cut -d" " -f5)
        case 1
            set firstBranch (git rev-parse --abbrev-ref HEAD)
            set secondBranch $argv[1]
        case 2
            set firstBranch $argv[1]
            set secondBranch $argv[2]
        case '*'
            echo 'usage: gba [<second-branch> | <first-branch> <second-branch>]'
            return
    end

    echo \nComparing branch \"$firstBranch\" to branch \"$secondBranch\":\n

    echo BEHIND: (git log --oneline $firstBranch..$secondBranch | wc -l)
    echo AHEAD: \t(git log --oneline $secondBranch..$firstBranch | wc -l)

    echo \nCOMMITS BEHIND:
    git log --oneline $firstBranch..$secondBranch

    echo \nCOMMITS AHEAD:
    git log --oneline $secondBranch..$firstBranch

end

function midi --argument-names abcFile transposeSteps
    if not test $abcFile
        echo 'usage: midi <file> [<transpose-steps>]'
        return
    end

    if not test $transposeSteps
        set transposeSteps 0
    end

    set type (grep 'R:' $abcFile --max-count 1 | sed 's/R://')

    switch $type
        case barndance
            set tempo 160
            set tmpFile (echo $abcFile | sed 's/.abc$/.mid/')
            cat $abcFile | sed s/barndance/hornpipe/ >$tmpFile
            set abcFile $tmpFile
        case hornpipe
            set tempo 150
        case jig
            set tempo 160
        case march
            set tempo 160
        case mazurka
            set tempo 160
        case polka
            set tempo 140
        case reel
            set tempo 170
        case slide
            set tempo 200
        case 'slip jig'
            set tempo 170
        case strathspey
            set tempo 140
        case waltz
            set tempo 120
        case '*'
            set tempo 120
            echo (set_color bryellow) WARNING: Tune type \"$type\" not recognized (set_color normal)

    end

    set midiFile (echo $abcFile | sed 's/.abc$/.mid/')
    abc2midi $abcFile -Q $tempo -o $midiFile
    timidity $midiFile -A 300 -K $transposeSteps -Od
    rm $midiFile
end

function lock
    defaults write com.apple.Dock contents-immutable -bool true
    defaults write com.apple.Dock position-immutable -bool true
    defaults write com.apple.Dock size-immutable -bool true
    killall Dock
end

function unlock
    defaults write com.apple.Dock contents-immutable -bool false
    defaults write com.apple.Dock position-immutable -bool false
    defaults write com.apple.Dock size-immutable -bool false
    killall Dock
end
