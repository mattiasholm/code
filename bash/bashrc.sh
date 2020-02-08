#!/bin/bash

if [[ -f ~/.bash_profile ]]; then
    cp ~/.bash_profile ~/.bash_profile.bak
    echo ". ~/.bashrc" >~/.bash_profile
fi

cp ~/.bashrc ~/.bashrc.bak
echo "alias ll='ls -la'" >~/.bashrc
echo "alias k='kubectl'" >>~/.bashrc
echo "alias g='git'" >>~/.bashrc
echo "alias t='terraform'" >>~/.bashrc
echo "alias p='pulumi'" >>~/.bashrc
echo "export PS1=\"\[\033[00;32m\]\u@\h\[\033[00m\]:\[\033[00;35m\]\w\[\033[36m\]\\\$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/')\[\033[00m\] $ \"" >>~/.bashrc

echo "" >>~/.bashrc

cat ~/.bashrc
