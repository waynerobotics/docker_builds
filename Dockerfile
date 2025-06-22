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
        ros-${ROS_DISTRO}-gazebo-ros-pkgs \
        ros-${ROS_DISTRO}-gazebo-plugins \
        ros-${ROS_DISTRO}-robot-state-publisher \
        ros-${ROS_DISTRO}-xacro \
        ros-${ROS_DISTRO}-rviz2 \
        ros-${ROS_DISTRO}-tf2-tools \
        ros-${ROS_DISTRO}-joint-state-publisher \
        ros-${ROS_DISTRO}-joint-state-publisher-gui && \
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