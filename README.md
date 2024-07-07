
# ROS1 Noetic Docker Container Setup and Troubleshooting Guide for VS Code on Ubuntu 
This will start a containerized Ubuntu 20.04 machine with ROS Noetic installed in Docker right in VSCode

## Prerequisites
- Ubuntu machine with Docker installed
- Visual Studio Code installed
- Docker extension for VS Code installed

## General Setup

1. **Ensure Docker Engine is Running**:
   - Before starting, make sure the Docker engine is active on your system. You can check this by with: sudo systemctl status docker
   - If Docker is not running, start it with: sudo systemctl start docker
   - To enable Docker to start on boot: sudo systemctl enable docker
   - Run a simple Docker command to ensure Docker is installed and functioning correctly: sudo docker run hello-world
   - You should see a "Hello from Docker!" message if everything is working correctly.

2. **Set Up Environment for Docker GUI Applications**:
   - xhost +local:docker
   - To make this change permanent, add the command to your .bashrc: echo "xhost +local:docker" >> ~/.bashrc


3. **Clone and Check Out Correct Branch**:
   - Open the Command Prompt from the Start Menu.
   - Clone the repository containing the Docker container setup files:
     ```
     git clone https://github.com/waynerobotics/docker_builds.git
     cd docker_builds
     git checkout ros1_noetic_for_ubuntu
     ```

4. **Open Visual Studio Code**:
   - Open the cloned repository folder in VS Code.
   - You should have a .devcontainer folder that contains the files necessary to tell Docker how to build and run your Docker container.
   - You should also be in the root directory of a bare-bones catkin workspace with a single test package called turtle_test.

5. **Start Docker Container**:
   - Click the Remote - Containers icon (a blue square with an icon) in the lower left corner of the VS Code window.
   - Select Reopen in Container.
   - Wait for the container to start, checking the status in the Docker extension sidebar.

6. **Begin Work**:
   - Once the container is running, you have an Ubuntu machine running right. Use the top toolbar in vscode to open new terminals as you need them.
   - Nothing you install with APT will persist unless you modify the dockerfile. This means you can safely experiment and not worry about corrupting your machine
   - The containered Ubuntu machine will rebuild good as new every time you restart docker or choose the rebuild container option
   - Only mounted volumes (files folders) can be modified persistently. This configuration mounts only the folder that the .devcontainer folder is placed in (and its subfolders).

7. **Build Workspace Test ROS1 Noetic**:
   - After opening the cloned repository in VS Code, checkout the specific ROS1 Noetic branch:
     ```
     cd /docker_builds/ros_ws
     catkin build
     source /docker_builds/ros_ws/devel/setup.bash
     roslaunch turtle_test turtle_test.launch
     ```
   - The `turtlesim_node` should start, and the turtle should start driving itself forward a little.
   - You can also control the turtle with the `rqt_robot_steering` GUI app.
   - If GUI apps aren't opening, refer to troubleshooting section below.

### Extend to Another Workspace
- If everything works as expected, copy the `.devcontainer` folder to the root of another ROS1 workspace, open that folder in VS Code, and select 'Open in Container' from the command palette.
- Modify .devcontainer/Dockerfile to source the correct ROS workspace. For example the last line of the Dockerfile currently reads:
    ```
    RUN echo "source /docker_builds/ros_ws/devel/setup.bash" >> ~/.bashrc
    ```
  But if you copy the .devcontainer folder to the root of karina_ws, then you'll change it to:    
    ```
    RUN echo "source /karina_ws/devel/setup.bash" >> ~/.bashrc
    ```

## Troubleshooting

### Container Issues
- **Container Not Starting**:
  - Verify that the Docker Compose file is correctly configured and check for syntax errors or missing dependencies.
  - Review any errors in the Docker extension output by clicking on the Docker icon in the sidebar.

### Connection and Display Issues
- **Connection Problems**:
  - Check if any firewall or antivirus software is blocking the connection. You may need to disable them temporarily.
  - Ensure that the Docker extension is properly connected to the Docker daemon. The connection status is visible in the Docker extension sidebar.
  - Verify that the container’s ports are correctly mapped in the Docker Compose file.

- **Display Problems / GUI apps not running**:
  - Run the following command to allow Docker containers to connect to the host machines X server: xhost +local:docker
  - To make this change permanent, add the command to your .bashrc or .profile file: echo "xhost +local:docker" >> ~/.bashrc
  - Make sure your DISPLAY environment variable are the same on host and container
    - On your host machine, check the current DISPLAY variable: echo $DISPLAY
    - In the Docker container, check the DISPLAY variable: echo $DISPLAY
    - If mismatched, manually set the DISPLAY variable to match the host's DISPLAY variable: export DISPLAY=:1  (replace:1 with actual output from your host machine)


### Performance
- **Slow Container Performance**:
  - Check the resource allocation for Docker in the Docker settings and adjust if necessary.
  - Ensure your machine meets the minimum system requirements for running Docker containers.

## Conclusion

This guide should help you set up and troubleshoot Docker containers in VS Code on your Windows machine, specifically for running ROS1 Noetic environments. For any unresolved issues, refer to the official documentation or seek community assistance.
