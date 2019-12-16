# Run

## Start a container:
docker run [image-name] [-flags]

<br>

# List

## List active containers:
docker ps
docker container list

## List all containers, including killed:
docker ps -a
docker containers list -a

## List local container images:
docker images

<br>

# Kill

## Kill specific container:
docker kill [container-ID]

## Kill all running containers:
docker container kill $(docker ps -q)

<br>

# Delete

## Delete container:
docker rm

## Delete container image:
docker rmi

## Delete all stopped containers:
docker container prune
docker container rm $(docker ps -a -q)