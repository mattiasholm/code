#!/usr/bin/env bash

set -e +x

for ext in $(code --list-extensions); do
    code --install-extension "${ext}"
done
