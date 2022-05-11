#!/usr/bin/env bash

set +e

for ext in $(code --list-extensions); do
    code --install-extension "$ext" --force
done

code --list-extensions --show-versions
