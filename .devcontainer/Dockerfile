FROM osrf/ros:noetic-desktop-full

# Add vscode user with same UID and GID as your host system
# (copied from https://code.visualstudio.com/remote/advancedcontainers/add-nonroot-user#_creating-a-nonroot-user)
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && apt-get update \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME
# Switch from root to user
USER $USERNAME

# Add user to video group to allow access to webcam and com ports
RUN sudo usermod --append --groups video $USERNAME
RUN sudo usermod --append --groups dialout $USERNAME

# Update all packages
RUN sudo apt update && sudo apt upgrade -y


RUN sudo apt install -y python3-rosdep  python3-rosinstall-generator  
RUN sudo apt install -y python3-rosinstall
RUN sudo apt install -y python3-rosinstall
RUN sudo apt install -y python3-wstool

# Rosdep update
#####RUN sudo rosdep init  #only once ever on a machine?
RUN rosdep update
RUN sudo apt install -y build-essential
RUN sudo apt install -y python3-catkin-tools
RUN sudo apt install -y ros-noetic-rosparam-shortcuts
RUN sudo apt install -y ros-noetic-nmea-msgs
RUN sudo apt install -y ros-noetic-move-base-msgs
RUN sudo apt install -y ros-noetic-behaviortree-cpp-v3
RUN sudo apt install -y ros-noetic-geographic-msgs
RUN sudo apt install -y libpthread-stubs0-dev
RUN sudo apt install -y libpcap-dev
RUN sudo apt install -y libroscpp-dev
##### NO GEDIT - breaks docker initializing#####   RUN sudo apt install -y gedit
RUN sudo apt install -y nano

# Install Git
RUN sudo apt install -y git

# Export display
RUN echo "export DISPLAY=host.docker.internal:0.0" >> ~/.bashrc

# Source the ROS setup file
RUN echo "source ~/../../opt/ros/${ROS_DISTRO}/setup.bash" >> ~/.bashrc

# Source the correct devel setup.bash for your workspace
RUN echo "source /docker_builds/ros_ws/devel/setup.bash" >> ~/.bashrc
