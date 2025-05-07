#   This script captures the commands Blaine runs on his laptop for setting up a new Ubuntu 22.04 system.

# #################################
# ROS 2.0 Humble Install
# From https://docs.ros.org/en/humble/Installation/Ubuntu-Install-Debs.html
# #################################

# Set locale
locale  # check for UTF-8
sudo apt update && sudo apt install -y locales
sudo locale-gen en_US en_US.UTF-8
sudo update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
export LANG=en_US.UTF-8
locale  # verify settings

# Add ROS 2 repository
sudo apt install -y software-properties-common curl
sudo add-apt-repository universe
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null

# Update and install ROS 2
sudo apt update && sudo apt upgrade -y
sudo apt install -y ros-humble-desktop ros-dev-tools

# #################################
# Gazebo and ROS 2 Tools Install
# https://classic.gazebosim.org/tutorials?tut=install_ubuntu
# #################################

# Install Gazebo
curl -sSL http://get.gazebosim.org | sh

# Install ROS 2 Gazebo and related tools
sudo apt install -y \
  ros-humble-gazebo-ros-pkgs \
  ros-humble-gazebo-plugins \
  ros-humble-robot-state-publisher \
  ros-humble-xacro \
  ros-humble-rviz2 \
  ros-humble-tf2-tools \
  ros-humble-joint-state-publisher \
  ros-humble-joint-state-publisher-gui \
  ros-humble-robot-localization

# #################################
# Driver Support
# #################################

# This is needed for the unilidar sensor
sudo usermod -a -G dialout "$(logname)"

# #################################
# Source ROS 2 in user's .bashrc
# #################################

USER_HOME=$(eval echo ~$(logname))
BASHRC_FILE="$USER_HOME/.bashrc"

echo "Adding ROS 2 sourcing to $BASHRC_FILE"
echo "source /opt/ros/humble/setup.bash" >> "$BASHRC_FILE"
echo "source ~/ros2_ws/install/setup.bash" >> "$BASHRC_FILE"
