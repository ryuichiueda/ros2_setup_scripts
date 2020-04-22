#!/bin/bash -e 

sudo apt-get install curl gnupg2
curl http://repo.ros2.org/repos.key |
sudo apt-key add - 

echo "deb [arch=amd64,arm64] http://packages.ros.org/ros2/ubuntu bionic main" | sudo tee /etc/apt/sources.list.d/ros2-latest.list

sudo apt-get update

sudo apt-get install ros-dashing-desktop python3-colcon-common-extensions python3-rosdep python3-argcomplete

sudo rm -f /etc/ros/rosdep/sources.list.d/20-default.list
sudo rosdep init
sudo rosdep fix-permissions

rosdep update

echo "OK!!"
