FROM osrf/ros:humble-desktop-full

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
#add user to dialout, sudo, audio, and plugdev groups
RUN sudo usermod -a -G dialout $USERNAME
RUN sudo usermod -a -G sudo $USERNAME
RUN sudo usermod -a -G audio $USERNAME
RUN sudo usermod -a -G plugdev $USERNAME

# Update all packages
RUN sudo apt update && sudo apt upgrade -y

# install misc tools 
RUN sudo apt install -y nautilus nano gedit
RUN sudo apt install -y python3-rosdep  python3-rosinstall-generator  
RUN sudo apt install -y python3-rosinstall
RUN sudo apt install -y python3-rosinstall
RUN sudo apt install -y python3-wstool

# Install ROS packages
RUN sudo apt install -y \
    ros-humble-navigation2 \
    ros-humble-nav2-bringup \
    ros-humble-turtlebot3 \
    #cros-humble-turtlebot3-navigation2 \
    #ros-humble-turtlebot3-slam \
    ros-humble-turtlebot3-gazebo \
    ros-humble-turtlebot3-simulations 

#RUN sudo apt update && apt install -y \
#    ros-humble-turtlebot3-navigation

#RUN sudo apt update && apt install -y \
#    ros-humble-turtlebot3-slam



# Rosdep update
#####RUN sudo rosdep init  #only once ever on a machine? #############
RUN rosdep update
RUN sudo apt install -y build-essential

RUN sudo apt install -y libpthread-stubs0-dev
RUN sudo apt install -y libpcap-dev
RUN sudo apt install -y libroscpp-dev
##### NO GEDIT - breaks docker initializing#####   RUN sudo apt install -y gedit
RUN sudo apt install -y nano

# Install Git
RUN sudo apt install -y git

# Install tmux
RUN sudo apt install -y tmux


# Export display 
#### UNCOMMENT FOR UBUNTU? RUN echo "export DISPLAY=host.docker.internal:0.0" >> ~/.bashrc

# Source the ROS setup file
RUN echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc
RUN echo "source /docker_builds/ros_ws/install/setup.bash" >> ~/.bashrc

#export turtlebot3 model
RUN echo "export TURTLEBOT3_MODEL=waffle" >> ~/.bashrc
RUN echo "export GAZEBO_AUDIO=false" >> ~/.bashrc
RUN echo "export GAZEBO_MODEL_PATH=$GAZEBO_MODEL_PATH:/opt/ros/humble/share/turtlebot3_gazebo/models" >> ~/.bashrc

# make executable and run the start_script.sh script
#RUN echo "sudo chmod +x sudo chmod +x /docker_builds/start_script.sh" >> ~/.bashrc
#RUN echo "/docker_builds/start_script.sh" >> ~/.bashrc
#CMD ["./start_script.sh"]

RUN echo "echo 'run the following to test: ros2 launch turtlebot3_gazebo turtlebot3_world.launch.py'" >> ~/.bashrc   
RUN echo "echo 'run the following to test: ros2 launch test_stuff gazebo_test.launch.py'" >> ~/.bashrc
RUN echo "echo 'Don't forget to run XLaunch if you're on a windows machine - see readme.md'" >> ~/.bashrc