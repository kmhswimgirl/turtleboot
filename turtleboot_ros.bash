#!/bin/bash

# ROS Jazzy Jalisco Install Script for Turtlebot 3 + OpenCR Configuration
# status --> UNTESTED

# exit on error
set -e

# Args: swapfile: bool, ROS_DOMAIN_ID: int, lidar type: int
SWAPFILE="true"
ROS_ID="30"
LIDAR="2"

# handling cli args
while [[ $# -gt 0 ]]; do
    case $1 in
        --ros-id|-id)
            ROS_ID="$2"
            shift 2
            ;;
        --lidar|-ld)
            LIDAR="$2"
            shift 2
            ;;
        --no-swapfile|-nsf)
            SWAPFILE="false"
            shift
            ;;
        --help|-h)
            echo "Usage: $0 [--lidar|-ld LIDAR] [--ros-id|-id ID] [--no-swapfile|-nsf]"
            exit 0
            ;;
        *)
            echo "Unknown argument: $1"
            exit 1
            ;;
    esac
done

# fun ascii art :)
cat << "EOF"\
 _____           _   _      ____              _   
|_   _|   _ _ __| |_| | ___| __ )  ___   ___ | |_ 
  | || | | | '__| __| |/ _ \  _ \ / _ \ / _ \| __|
  | || |_| | |  | |_| |  __/ |_) | (_) | (_) | |_ 
  |_| \__,_|_|   \__|_|\___|____/ \___/ \___/ \__|
           R  O  S  /  O  P  E  N  C  R           
                   _____     ____
                 /      \  |  o | 
                |        |/ ___\| 
                |_________/     
                |_|_| |_|_|
EOF
echo "Welcome to TurtleBoot ROS/OPENCV!"
echo "developed by @kmhswimgirl"

if [ "$SWAPFILE" = "true" ]; then
  # make swapfile if RPi has <= 2GB RAM --> ask for bool
  fallocate -l 2G /swapfile
  chmod 600 /swapfile
  mkswap /swapfile
  swapon /swapfile
  echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
  free -h # --> to check for swap memory
  echo "Swapfile sucessfully created!"
fi

# Other required dependencies
apt install -y software-properties-common
add-apt-repository -y universe

#referesh package updates and install curl
apt update && apt install -y curl
export ROS_APT_SOURCE_VERSION=$(curl -s https://api.github.com/repos/ros-infrastructure/ros-apt-source/releases/latest | grep -F "tag_name" | awk -F\" '{print $4}')
curl -L -o /tmp/ros2-apt-source.deb "https://github.com/ros-infrastructure/ros-apt-source/releases/download/${ROS_APT_SOURCE_VERSION}/ros2-apt-source_${ROS_APT_SOURCE_VERSION}.$(. /etc/os-release && echo $VERSION_CODENAME)_all.deb" # If using Ubuntu derivates use $UBUNTU_CODENAME
apt install -y /tmp/ros2-apt-source.deb

# install ROS + dev tools
apt update 
apt install -y ros-dev-tools
apt update 
apt -y upgrade
apt install -y ros-jazzy-ros-base

source ~/.bashrc
source /opt/ros/jazzy/setup.bash

# Turtlebot Dependencies
apt install -y python3-argcomplete python3-colcon-common-extensions libboost-system-dev build-essential
apt install -y ros-jazzy-hls-lfcd-lds-driver
apt install -y ros-jazzy-turtlebot3-msgs
apt install -y ros-jazzy-dynamixel-sdk
apt install -y ros-jazzy-xacro
apt install -y libudev-dev

# make turtlebot workspace
mkdir -p ~/turtlebot3_ws/src
cd ~/turtlebot3_ws/src

# Clone Packages from GitHub
git clone -b jazzy https://github.com/ROBOTIS-GIT/turtlebot3.git
git clone -b jazzy https://github.com/ROBOTIS-GIT/ld08_driver.git

# remove cartographer and nav2 packages
cd ~/turtlebot3_ws/src/turtlebot3
rm -r turtlebot3_cartographer turtlebot3_navigation2
cd ~/turtlebot3_ws/

# add sourcing ros to ~/.bashrc
echo 'source /opt/ros/jazzy/setup.bash' >> ~/.bashrc

# building turtlebot workspace
cd ~/turtlebot3_ws/
colcon build --symlink-install --parallel-workers 1

# configure & source ~/.bashrc
echo 'source ~/turtlebot3_ws/install/setup.bash' >> ~/.bashrc
source ~/.bashrc

# open cr stuff
sudo cp `ros2 pkg prefix turtlebot3_bringup`/share/turtlebot3_bringup/script/99-turtlebot3-cdc.rules /etc/udev/rules.d/
sudo udevadm control --reload-rules
sudo udevadm trigger

# export variables for configuring the turtlebot
echo "export ROS_DOMAIN_ID=$ROS_ID #TURTLEBOT3" >> ~/.bashrc
echo "export LDS_MODEL=LDS-0$LIDAR # lidar config" >> ~/.bashrc
source ~/.bashrc

exit 0