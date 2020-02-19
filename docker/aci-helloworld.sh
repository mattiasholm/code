#!/usr/bin/env bash

# Start and expose container on specific port
docker run -p 80:80 -d mcr.microsoft.com/azuredocs/aci-helloworld

# Flags reference:
# -P    --publish-all       Publish all exposed ports to random ports
# -d    --detach            Run container in background and print container ID
# -p    --publish list      Publish a container's port(s) to the host
