#!/bin/bash -e
#SPDX-FileCopyrightText: 2022 Ryuichi Ueda ryuichiueda@gmail.com
#SPDX-License-Identifier: BSD-3-Clause

[ "${ROS_VERSION}" = "1" ] && echo ROS1 is set. Please comment out the lines of source for ROS1 on .bashrc and restart a terminal. && exit 1
[ "${ROS_VERSION}" = "2" ] && echo ROS2 is set. Please comment out the lines of source for ROS2 on .bashrc and restart a terminal. && exit 1

sudo apt-get update
sudo apt-get install -y curl gnupg2
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg

UBUNTU_VER=$(lsb_release -sc)
ROS_VER=dashing
[ "$UBUNTU_VER" = "focal" ] && ROS_VER=foxy
[ "$UBUNTU_VER" = "jammy" ] && ROS_VER=humble
[ "$UBUNTU_VER" = "noble" ] && ROS_VER=jazzy

echo "deb [ signed-by=/usr/share/keyrings/ros-archive-keyring.gpg arch=amd64,arm64] http://packages.ros.org/ros2/ubuntu ${UBUNTU_VER} main" |
sudo tee /etc/apt/sources.list.d/ros2-latest.list

#sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys F42ED6FBAB17C654
sudo apt-get update
sudo apt-get install -y ros-${ROS_VER}-desktop python3-colcon-common-extensions python3-rosdep python3-argcomplete 

sudo rm -f /etc/ros/rosdep/sources.list.d/20-default.list
sudo rosdep init
sudo rosdep fix-permissions

echo "source /opt/ros/${ROS_VER}/setup.bash" >> ~/.bashrc

rosdep update

echo '***INSTRUCTION*****************'
echo '* do the following command    *'
echo '* $ source ~/.bashrc          *'
echo '*******************************'
