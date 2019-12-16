# Cheat Sheet

<br>

## Start a container from image:
docker run [image-name] [-flags]ls

## Stop a container:
docker stop [container-ID]

## Start a stopped container
docker start [container-ID]

## Attach to a container:
docker attach [container-ID]

<br><br>

# List

## List active containers:
docker ps
docker container list

## List all containers, including killed:
docker ps -a
docker containers list -a

## List local container images:
docker images

<br><br>

# Kill

## Kill specific container:
docker kill [container-ID]

## Kill all running containers:
docker kill $(docker ps -q)

<br><br>

# Delete

## Delete specific container:
docker rm [container-ID]

## Delete all stopped containers:
docker container prune
docker container rm $(docker ps -a -q)

## Delete specific container image:
docker rmi [image-ID]

## Delete all container images:
docker rmi $(docker images -q)