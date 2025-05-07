FROM osrf/ros:humble-desktop-full

# Install ffmpeg
RUN apt-get update && \
    apt-get install -y ffmpeg && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install ros-humble-ament-cmake
RUN apt-get update && apt-get install -y ros-humble-ament-cmake

# Install ROS development tools
RUN apt-get update && apt-get install -y ros-dev-tools

# Install Gazebo and ROS 2 Gazebo-related tools
RUN curl -sSL http://get.gazebosim.org | sh && \
    apt-get update && apt-get install -y \
        ros-humble-gazebo-ros-pkgs \
        ros-humble-gazebo-plugins \
        ros-humble-robot-state-publisher \
        ros-humble-xacro \
        ros-humble-rviz2 \
        ros-humble-tf2-tools \
        ros-humble-joint-state-publisher \
        ros-humble-joint-state-publisher-gui \
        ros-humble-robot-localization && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create a new user 'ros' with home directory and no password
RUN useradd -m -s /bin/bash ros && \
    echo "ros ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Set up the workspace for the 'ros' user
USER ros
WORKDIR /home/ros
RUN mkdir -p /home/ros/ros2_ws/src && \
    echo "alias cdros='cd /home/ros/ros2_ws'" >> /home/ros/.bashrc && \
    echo "source /opt/ros/humble/setup.bash" >> /home/ros/.bashrc && \
    echo "source /home/ros/ros2_ws/install/setup.bash" >> /home/ros/.bashrc

# Switch back to root for any additional setup
USER root
