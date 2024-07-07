FROM osrf/ros:noetic-desktop-full

# Add vscode user with same UID and GID as your host system
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && apt-get update \
    && apt-get install -y sudo \
    && echo "$USERNAME ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME

# Add user to video and dialout groups
RUN sudo usermod --append --groups video,dialout,sudo $USERNAME

# Switch to the vscode user
USER $USERNAME

# Update all packages and install necessary dependencies
RUN sudo apt update && sudo apt upgrade -y \
    && sudo apt install -y python3-rosdep python3-rosinstall-generator python3-rosinstall python3-wstool \
    build-essential python3-catkin-tools ros-noetic-rosparam-shortcuts ros-noetic-nmea-msgs ros-noetic-move-base-msgs \
    ros-noetic-behaviortree-cpp-v3 ros-noetic-geographic-msgs libpthread-stubs0-dev libpcap-dev libroscpp-dev nano git

# Install turtlebot3 packages
RUN sudo apt install -y ros-noetic-turtlebot3 ros-noetic-turtlebot3-msgs ros-noetic-turtlebot3-simulations ros-noetic-turtlebot3-navigation


# Rosdep update with debugging ***ONLY ONCE EVER PER MACHINE***
# RUN sudo rosdep init && rosdep update || { echo 'rosdep update failed'; exit 1; }

### This seemed to not work on linux, but it might work on windows
### On linux, I just used this in the devcontainer.json: "containerEnv": {"DISPLAY": "${localEnv:DISPLAY}"}
### it also worked if I ran "echo $DISPLAY" in the host terminal, then used that output in the container ie: "export DISPLAY=:1"
# Export display
#RUN echo "export DISPLAY=host.docker.internal:0.0" >> ~/.bashrc

# Source the ROS setup file
RUN echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> ~/.bashrc

# Export the turtlebot3 model
RUN echo "export TURTLEBOT3_MODEL=burger" >> ~/.bashrc

# Source the correct devel setup.bash for your workspace
RUN echo "source /docker_builds/ros_ws/devel/setup.bash" >> ~/.bashrc

# Debugging information
RUN echo "Dockerfile build step completed successfully"
