# Cheat Sheet

<br>

## Start a container from image:
docker run [image-name] [-flags]ls

## Stop a container gracefully:
docker stop [container-ID]

## Start a stopped container
docker start [container-ID]

## Attach to a container:
docker attach [container-ID]

<br><br>

## List active containers:
docker ps
docker container list
docker container ls

## List all containers, including killed:
docker ps -a
docker containers list -a
docker container ls -a

## List local container images:
docker images
docker image ls

<br><br>

## Kill specific container:
docker kill [container-ID]

## Kill all running containers:
docker kill $(docker ps -q)

<br><br>

## Delete specific container:
docker rm [container-ID]

## Delete all stopped containers:
docker container prune
docker rm $(docker ps -a -q)

## Delete specific container image:
docker image rm [image-ID]
docker rmi [image-ID]

## Delete all container images:
docker rmi $(docker images -q)

<br><br>

## Print logs from specific container:
docker logs [container-ID]

## Get verbose information about a specific container:
docker inspect [container-ID]

<br><br>

## Build an image from Dockerfile in pwd:
docker build -t [app-name] .

## Run new image:
docker run [app-name]