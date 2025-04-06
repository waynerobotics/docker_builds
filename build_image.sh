#!/bin/bash

IMAGE_NAME=my-ros2-dev

# Check if the image already exists
if [ "$(docker images -q $IMAGE_NAME)" ]; then
    echo "Removing existing image: $IMAGE_NAME"
    docker rmi -f $IMAGE_NAME
fi

# Build the new image
echo "Building the Docker image: $IMAGE_NAME"
docker build -t $IMAGE_NAME .