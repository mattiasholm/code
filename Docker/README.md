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

## List active containers and their size:
docker container ls -s

## List all containers, including killed:
docker ps -a
docker containers list -a
docker container ls -a

## List local container images:
docker images
docker image ls

## List your Docker Client and Server versions:
docker version

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

## Get verbose information about a specific image:
docker image inspect [image-ID]

<br><br>

## Build an image from Dockerfile in working directory:
docker build -t [app-name] .

## Run new image:
docker run [app-name]

## Tag new image:

docker tag python mattiasholm/python:1.0

## Log in to remote registry:
docker login --username=mattiasholm

## Push new image to remote registry:
docker push [remote-registry]/[app-name]:[image-version]

## Pull existing image from remote registry:
docker pull [remote-registry]/[app-name]:[image-version]