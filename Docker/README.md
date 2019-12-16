# Start a container:
docker run [image-name] [-flags]



# List active containers:
docker ps
docker container list

# List all containers, including killed:
docker ps -a
docker containers list -a

# List local container images:
docker images



# Kill specifik container:
docker kill [container-ID]

# Kill all running containers:
docker container kill $(docker ps -q)



# Delete container:
docker rm

# Delete container image:
docker rmi

# Delete all stopped containers:
docker container prune
docker container rm $(docker ps -a -q)