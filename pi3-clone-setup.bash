#!/bin/bash

# Reconfiguring the network settings / regenerating SSH Key only after a microSD clone
# Status --> UNTESTED

# exit on errors
set -e

# variables from cl args
TURTLEBOT_NAME="${1:-turtlebot}"
REBUILD="${2:-false}" 

# show args
echo "TurtleBot Name: $TURTLEBOT_NAME"
echo "Rebuild flag: $REBUILD"

# delete old ssh key
sudo /bin/rm -v /etc/ssh/ssh_host_*

# regen SSH Key
sudo dpkg-reconfigure openssh-server

# restart ssh server
sudo systemctl restart ssh

# change hostname
hostnamectl set-hostname $TURTLEBOT_NAME
echo "hostname set to $TURTLEBOT_NAME"

# cd into turtlebot3_ws
cd ~/turtlebot3_ws/

# rebuild TB3 packages???
if [ "$REBUILD" = true ]; then
    colcon build --symlink-install 
fi

echo "Network & SSH reconfigured"
exit 0