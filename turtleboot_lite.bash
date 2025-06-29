#!/bin/bash

# Reconfiguring the network settings / regenerating SSH Key only after a microSD clone
# Status --> TESTED: Ubuntu Server 24.04.2 VM

# exit on errors
set -e

# variables from cl args
TURTLEBOT_NAME="turtlebot3-clone"
ROS_ID="30"
REBUILD="false"

while [[ $# -gt 0 ]]; do
    case $1 in
        --name|-n)
            TURTLEBOT_NAME="$2"
            shift 2
            ;;
        --ros-id|-id)
            ROS_ID="$2"
            shift 2
            ;;
        --rebuild)
            REBUILD="true"
            shift
            ;;
        --no-rebuild)
            REBUILD="false"
            shift
            ;;
        --help|-h)
            echo "Usage: $0 [--name|-n NAME] [--ros-id|-id ID] [--rebuild|--no-rebuild]"
            exit 0
            ;;
        *)
            echo "Unknown argument: $1"
            exit 1
            ;;
    esac
done

cat << "EOF"
 _____           _   _      ____              _   
|_   _|   _ _ __| |_| | ___| __ )  ___   ___ | |_ 
  | || | | | '__| __| |/ _ \  _ \ / _ \ / _ \| __|
  | || |_| | |  | |_| |  __/ |_) | (_) | (_) | |_ 
  |_| \__,_|_|   \__|_|\___|____/ \___/ \___/ \__|
            L      I       T       E
                   _____     ____
                 /      \  |  o | 
                |        |/ ___\| 
                |_________/     
                |_|_| |_|_|
EOF

echo "Welcome to TurtleBoot Lite!"
echo "developed by @kmhswimgirl"

# confirm args
echo "TurtleBot Name: $TURTLEBOT_NAME"
echo "Rebuild flag: $REBUILD"
echo "ROS Domain ID: $ROS_ID"

# ask for password once
sudo -v
while true; do sudo -n true; sleep 60; done 2>/dev/null &

# delete old ssh key
sudo rm -v /etc/ssh/ssh_host_*

# regen SSH Key
sudo dpkg-reconfigure openssh-server

# restart ssh server
sudo systemctl restart ssh
echo "SSH keys regenerated!"

# cloud-init parameter change
sudo sed -i "15s/.*/preserve_hostname: true/" /etc/cloud/cloud.cfg

# writing in the new hostname
sudo hostnamectl set-hostname $TURTLEBOT_NAME
sudo sed -i "2s/.*/127.0.0.1 $TURTLEBOT_NAME/" /etc/hosts
echo "hostname set to $TURTLEBOT_NAME !"

# cd into turtlebot3_ws
cd ~/turtlebot3_ws/

# rebuild tb3 packages?
if [ -d ~/turtlebot3_ws ]; then
    cd ~/turtlebot3_ws
    if [ "$REBUILD" = true ]; then
        colcon build --symlink-install 
    fi
fi

echo "Reconfiguration Finished!"
exit 0