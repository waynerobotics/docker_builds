
# ROS2 Noetic Docker Container Setup and Troubleshooting Guide for VS Code on Windows 
This will start a containerized Ubuntu 22.04 machine with ROS2 Humble installed in Docker right in VSCode

## Prerequisites
- Windows machine with Docker installed
- WSL Installed
- Visual Studio Code installed
- Docker extension for VS Code installed
- Dev Containers extension for VS Code installed
- [Xming](https://sourceforge.net/projects/xming/)

## General Setup

1. **Ensure Docker Engine is Running**:
   - Before starting, make sure the Docker engine is active on your system. You can check this by looking for the Docker icon in the system tray.

2. **Clone and Check Out Correct Branch**:
   - Open the Command Prompt from the Start Menu.
   - Clone the repository containing the Docker container setup files:
     ```
     git clone https://github.com/waynerobotics/docker_builds.git
     cd docker_builds
     git checkout ros2_humble_for_windows
     ```

3. **Open Visual Studio Code**:
   - Open the cloned repository folder in VS Code.
   - You should have a .devcontainer folder that contains the files necessary to tell Docker how to build and run your Docker container.
   - You should also be in the root directory of a bare-bones catkin workspace with a single test package called turtle_test.

4. **Start Docker Container**:
   - Press `Ctrl + Shift + P` to open the command palette.
   - Type `Dev Containers: Rebuild and Reopen in Container` and select the option to start the Docker container.
   - Wait for the container to start, checking the status in the Docker extension sidebar.

5. **Begin Work**:
   - Once the container is running, you have a WSL instance accessible thorugh VSCode. Use the top toolbar in VSCode to open new terminals as you need them.
   - Nothing you install with APT will persist unless you modify the dockerfile. This means you can safely experiment and not worry about corrupting your machine
   - The Ubuntu machine will rebiuld good as new every time you restart docker or choose the rebuild container option
   - Only mounted volumes (files folders) can be modified persistently. This configuration mounts only the folder that the .devcontainer folder is placed in (and its subfolders).
  
6. **Launch Xming server**:
   - Run XLaunch from the Start Menu, choose "Multiple windows", set display number to 0, and select "Start no client".
   - Automate the launch of X server by adding a shortcut to VcXsrv in your Startup folder with the appropriate settings saved in a configuration file (.xlaunch file).

7. **Test ROS2 Humble**:
   - Run the following command to check if packages are installed
     ```
     ros2 pkg executables turtlesim
     ```
     - The command should return the following:
     ```
     turtlesim draw_square
     turtlesim mimic
     turtlesim turtle_teleop_key
     turtlesim turtlesim_node
     ```
   - Start the turtlesim with this command
     ```
     ros2 run turtlesim turtlesim_node
     ```
     A new window should appear with the turtlebot
   - Move the turtlebot around using this node
     ```
     ros2 run turtlesim turtle_teleop_key
     ```
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
  - Verify the file path being used. If your error lists a path as "C:\Users\YourUserC:\Users\Yo...", navigate to the devcontainer.json file and adjust the mounts line from
    ```
      "mounts": [
          "source=${localEnv:HOME}${localEnv:USERPROFILE}/.bash_history,target=/home/vscode/.bash_history,type=bind"
      ],
    ```
    To
    ```
      "mounts": [
          "source=${localEnv:USERPROFILE}/.bash_history,target=/home/vscode/.bash_history,type=bind"
      ],
    ```
    
### Connection and Display Issues
- **Connection Problems**:
  - Check if any firewall or antivirus software is blocking the connection. You may need to disable them temporarily.
  - Ensure that the Docker extension is properly connected to the Docker daemon. The connection status is visible in the Docker extension sidebar.
  - Verify that the container’s ports are correctly mapped in the Docker Compose file.
  - Log back in and out of docker without using your email. In command prompt:
    ```
    docker logout
    docker login --username your_username
    ```

- **Display Problems with X Server**:
  - Run XLaunch from the Start Menu, choose "Multiple windows", set display number to 0, and select "Start no client". Ensure "Disable access control" is checked.
  - Consider the security implications of disabling access control, especially on public networks.
  - Automate the launch of X server by adding a shortcut to VcXsrv in your Startup folder with the appropriate settings saved in a configuration file (.xlaunch file).

### Performance
- **Slow Container Performance**:
  - Check the resource allocation for Docker in the Docker settings and adjust if necessary.
  - Ensure your machine meets the minimum system requirements for running Docker containers.

## Conclusion

This guide should help you set up and troubleshoot Docker containers in VS Code on your Windows machine, specifically for running ROS1 Noetic environments. For any unresolved issues, refer to the official documentation or seek community assistance.
