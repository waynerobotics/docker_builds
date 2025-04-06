#!/bin/bash

CONTAINER_NAME=humble_ros2_dev_container


HOST_WS=~/ros2_ws/src
CONTAINER_WS=/home/ros/ros2_ws/src

# Setup X11 for GUI apps
XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth

# Generate Xauthority file if it doesn't exist
if [ ! -f $XAUTH ]; then
    touch $XAUTH
    xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -
fi

# Allow X11 connections from localhost
xhost +local:docker

# Stop previous container
if [ "$(docker ps -aq -f name=^/${CONTAINER_NAME}$)" ]; then
    echo "Stopping and removing previous container: $CONTAINER_NAME"
    docker stop $CONTAINER_NAME >/dev/null
    docker rm $CONTAINER_NAME >/dev/null
fi

# Run the container in detached mode
docker run -dit --name $CONTAINER_NAME \
    --net=host \
    --device=/dev/ttyUSB0 \
    --device=/dev/video0 \
    -e DISPLAY=$DISPLAY \
    -e XAUTHORITY=$XAUTH \
    -v "${XSOCK}:${XSOCK}" \
    -v "${XAUTH}:${XAUTH}" \
    -v "${HOST_WS}:${CONTAINER_WS}" \
    -e HOME=/home/ros \
    --user ros \
    my-ros2-dev \
    bash

# Exec into it
# docker exec -it $CONTAINER_NAME bash


# Build the image
# docker build -t my-ros2-dev .

# Custom image
# my-ros2-dev \

# Default image
# osrf/ros:humble-desktop \

