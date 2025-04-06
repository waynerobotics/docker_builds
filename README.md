# docker_builds

A repository of Docker files and scripts for setting up ROS 2 Humble, Gazebo, and related development tools. This workspace is designed to streamline the process of building, running, and managing Docker containers for ROS 2 development.

## Repository Contents

- **`Dockerfile`**: Defines the Docker image for ROS 2 Humble with additional tools like Gazebo and ROS development utilities.
- **`build_image.sh`**: Script to build the Docker image.
- **`run_humble_docker.sh`**: Script to run the Docker container with ROS 2 Humble.
- **`stop_humble_docker.sh`**: Script to stop and remove the running Docker container.
- **`configureLaptop.sh`**: Script to configure a new Ubuntu 22.04 system for ROS 2 Humble development.
- **`.gitignore`**: Specifies files and directories to be ignored by Git.

## Prerequisites

- Docker installed on your system.
- Ubuntu 22.04 or a compatible Linux distribution.
- Basic familiarity with Docker and ROS 2.

## Usage

### 1. Build the Docker Image

Run the `build_image.sh` script to build the Docker image:

```bash
build_image.sh
```

This will create a Docker image named my-ros2-dev.

2. Run the Docker Container
Use the run_humble_docker.sh script to start the Docker container:

```bash
run_humble_docker.sh
```

This script sets up X11 forwarding for GUI applications and mounts your local ROS 2 workspace (~/ros2_ws/src) into the container.

3. Stop the Docker Container
To stop and remove the running container, execute:

```bash
stop_humble_docker.sh
```

4. Configure a New Laptop
If you're setting up a new Ubuntu 22.04 system for ROS 2 development, you can use the configureLaptop.sh script:

```bash
configureLaptop.sh
```

This script installs ROS 2 Humble, Gazebo, and related tools.

Dockerfile Overview
The Dockerfile is based on the osrf/ros:humble-desktop-full image and includes:

ROS 2 Humble development tools.
Gazebo and ROS 2 Gazebo-related packages.
A non-root user ros with a pre-configured workspace.
Notes
The container uses the humble_ros2_dev_container name by default.
The local ROS 2 workspace (~/ros2_ws/src) is mounted into the container at /home/ros/ros2_ws/src.
License
This repository is licensed under the MIT License. See the LICENSE file for details.