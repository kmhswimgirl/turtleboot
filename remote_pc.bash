#!/bin/bash


# Turtleboot Remote PC v1.0
# Installing all of the ROS Packages to use the turtlebot 3 in simulation

set -e # exit on errors

# Variables
WS_NAME="ros2_ws"
DOMAIN_ID="30"
MODEL="burger"

# update and get dev tools/osrf stuff
sudo apt-get update
sudo apt-get install curl lsb-release gnupg
sudo curl https://packages.osrfoundation.org/gazebo.gpg --output /usr/share/keyrings/pkgs-osrf-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/pkgs-osrf-archive-keyring.gpg] http://packages.osrfoundation.org/gazebo/ubuntu-stable $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/gazebo-stable.list > /dev/null

# install Gazebo Harmonic
sudo apt-get updategit check-ignore -v remote_pc.bashgit check-ignore -v remote_pc.bash
sudo apt-get install gz-harmonic

# cartographer
sudo apt install ros-jazzy-cartographer
sudo apt install ros-jazzy-cartographer-ros

# nav2
sudo apt install ros-jazzy-navigation2
sudo apt install ros-jazzy-nav2-bringup

# confirm workspace directory and move to src folder
source /opt/ros/jazzy/setup.bash

if[! -d ~/$WS_NAME/src]; then
    mkdir -p ~/$WS_NAME/src
fi

cd ~/$WS_NAME/src

# clone Robotis packages
git clone -b jazzy https://github.com/ROBOTIS-GIT/DynamixelSDK.git
git clone -b jazzy https://github.com/ROBOTIS-GIT/turtlebot3_msgs.git
git clone -b jazzy https://github.com/ROBOTIS-GIT/turtlebot3.git
git clone -b jazzy https://github.com/ROBOTIS-GIT/turtlebot3_simulations.git

# install python build tools
sudo apt install python3-colcon-common-extensions

# build the workspace
cd ~/$WS_NAME
colcon build --symlink-install
echo "source ~/$WS_NAME/install/setup.bash" >> ~/.bashrc
source ~/.bashrc

# ENV config
echo "export ROS_DOMAIN_ID=$DOMAIN_ID #TURTLEBOT3" >> ~/.bashrc
echo "export source /opt/ros/jazzy/setup.bash" >> ~/.bashrc
source ~/.bashrc
