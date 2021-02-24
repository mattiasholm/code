#!/usr/bin/env bash

set -e +x

for ext in $(code --list-extensions); do
    code --uninstall-extension "${ext}"
done

code --list-extensions --show-versions
