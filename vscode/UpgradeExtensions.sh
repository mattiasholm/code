#!/bin/bash

for ext in $(code --list-extensions); do
    code --install-extension "$ext"
done