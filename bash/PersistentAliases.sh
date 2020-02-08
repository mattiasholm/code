#!/bin/bash

echo ". ~/.bashrc" >~/.bash_profile

echo "alias ll='ls -la'" >~/.bashrc
echo "alias k='kubectl'" >>~/.bashrc
echo "alias g='git'" >>~/.bashrc
echo "alias t='terraform'" >>~/.bashrc
echo "alias p='pulumi'" >>~/.bashrc

cat ~/.bashrc
