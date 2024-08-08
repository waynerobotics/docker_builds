from launch import LaunchDescription
from launch.actions import ExecuteProcess
from launch_ros.actions import Node
from launch.substitutions import PathJoinSubstitution
from launch_ros.substitutions import FindPackageShare

def generate_launch_description():
    # Path to the RViz config file
    rviz_config_path = PathJoinSubstitution([
        FindPackageShare('test_stuff'),
        'config',
        'gazebo_test_rviz_config.rviz'
    ])

    return LaunchDescription([
        # Launch turtlebot3_world in Gazebo
        ExecuteProcess(
            cmd=['ros2', 'launch', 'turtlebot3_gazebo', 'turtlebot3_world.launch.py'],
            output='screen'
        ),

        # Launch rqt_robot_steering
        ExecuteProcess(
            cmd=['ros2', 'run', 'rqt_robot_steering', 'rqt_robot_steering'],
         #   output='screen'
        ),

        # Launch RViz2 with the specified configuration
        Node(
            package='rviz2',
            executable='rviz2',
            name='rviz2',
            output='screen',
         #   arguments=['-d', rviz_config_path]
        )
    ])
