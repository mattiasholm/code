# Cheat Sheet - Docker

<br>

## List your Docker Client and Server versions:
```shell
docker version
```

<br><br>

## Start a container from image:
```shell
docker run <image-name>
```

## Start a container from image and run it interactively:
```shell
docker run --interactive --tty <image-name>
docker run -it <image-name>
```

## Start a container from image on random port and run it in background:
```shell
docker run --publish-all --detach <image-name>
docker run -Pd <image-name>
```

## Start a container from image on a specific port and run it in background:
```shell
docker run --publish <port>:<port> --detach <image-name>
docker run -p <port>:<port> d <image-name>
```

<br<br>>

## Stop a container gracefully:
```shell
docker stop <container-id>
```

## Start a stopped container:
```shell
docker start <container-id>
```

<br<br>>

## Attach to a container:
```shell
docker attach <container-id>
```

## Run command in a specific container:
```shell
docker exec <container-id> <command>
```

## Start an interactive shell in a specific running container:
```shell

docker exec --interactive --tty <container-id> /bin/bash
docker exec -it <container-id> /bin/bash
```

## Start a new container with interactive shell:
```shell
docker run --interactive --tty <image-name> /bin/bash
docker run -it <image-name> /bin/bash
```

## Check public IP used for a specific container:
```shell
docker exec <container-id> curl --silent ifconfig.co
```

<br><br>

## List active containers:
```shell
docker ps
docker container list
docker container ls
```

## List active containers and their size:
```shell
docker container ls --silent
docker container ls -s
```

## List all containers, including killed:
```shell
docker ps --all
docker ps -a
docker container list --all
docker container list -a
docker container ls -a
docker container ls --all
```

## List local container images:
```shell
docker images
docker image ls
```

<br><br>

## Kill specific container:
```shell
docker kill <container-id>
```

## Kill all running containers:
```shell
docker kill $(docker ps --quiet)
docker kill $(docker ps -q)
```

<br><br>

## Delete specific container:
```shell
docker rm <container-id>
```

## Delete all stopped containers:
```shell
docker container prune
docker rm $(docker ps --all --quiet)
docker rm $(docker ps -a -q)
```

## Delete specific container image:
```shell
docker image rm <image-ID>
docker rmi <image-ID>
```

## Delete all dangling images (i.e. layers that have no relationship to any tagged images):
```shell
docker images prune
```

## Delete all container images:
```shell
docker rmi $(docker images --quiet)
docker rmi $(docker images -q)
```

<br><br>

## Print logs from specific container:
```shell
docker logs <container-id>
```

## Get verbose information about a specific container:
```shell
docker inspect <container-id>
```

## Get verbose information about a specific image:
```shell
docker image inspect <image-ID>
```

<br><br>

## Build an image from Dockerfile in working directory:
```shell
docker build --tag <app-name> .
docker build -t <app-name> .
```

## Run new image:
```shell
docker run <app-name>
```

## Tag new image:
```shell
docker tag python <remote-registry>/<app-name>:<image-version>
```

<br><br>

## Log in to remote registry:
```shell
docker login -u=<username>
docker login --username=<username>
```

## Push new image to remote registry:
```shell
docker push <remote-registry>/<app-name>:<image-version>
```

## Pull existing image from remote registry:
```shell
docker pull <remote-registry>/<app-name>:<image-version>
```

<br><br>

## List all Docker contexts:
```shell
docker context ls
```

## Inspect a specific Docker context:
```shell
docker context inspect <name>
```

## Switch Docker context:
```shell
docker context use <name>
```