#!/usr/bin/env bash

for ext in $(code --list-extensions); do
    code --uninstall-extension "${ext}"
done
