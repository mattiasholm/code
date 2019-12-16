#!/bin/bash

docker run -Pd nginxdemos/hello

# Flags reference:
# -P    --publish-all       Publish all exposed ports to random ports
# -d    --detach            Run container in background and print container ID