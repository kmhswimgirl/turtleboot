#!/bin/bash

# Turtleboot Lite v1.0.4
# Reconfiguring the network settings / regenerating SSH Key only after a microSD clone
# Status --> TESTED (On Ubuntu 24.04 VM)

# exit on errors
set -e

# variables from cl args with defaults
TURTLEBOT_NAME="turtleboot"
ROS_ID="30"
REBUILD="false"
REBOOT="false"

# handling cli args
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
        --reboot)
            REBOOT="true"
            shift
            ;;
        --help|-h)
            echo "Usage: $0 [--name|-n NAME] [--ros-id|-id ID] [--rebuild| None] [--reboot| None]"
            exit 0
            ;;
        *)
            echo "Unknown argument: $1"
            exit 1
            ;;
    esac
done

# fun ascii art :)
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

# delete old ssh key
rm -v /etc/ssh/ssh_host_*

# regen SSH Key
dpkg-reconfigure openssh-server

# restart ssh server
systemctl restart ssh
echo "SSH keys regenerated!"

# cloud-init parameter change
sed -i "15s/.*/preserve_hostname: true/" /etc/cloud/cloud.cfg

# writing in the new hostname
hostnamectl set-hostname $TURTLEBOT_NAME
sed -i "2s/.*/127.0.0.1 $TURTLEBOT_NAME/" /etc/hosts
echo "hostname set to $TURTLEBOT_NAME !"

# rebuild tb3 packages set with flag --rebuild
if [ "$REBUILD" = true ]; then
    # cd into turtlebot3_ws
    cd ~/turtlebot3_ws/

    # confirm the correct directory
    if [ -d ~/turtlebot3_ws ]; then
        # rebuild turtlebot3_ws
        colcon build --symlink-install 
    fi
fi

# confirm reconfig status
echo "Reconfiguration Finished!"

# made rebooting after setup optional, REBOOT is set with the --reboot flag
if ["$REBOOT" = true ]; then
    reboot
fi

# warning if --reboot was not chosen in cli args
echo "Please reboot in order to see Turtleboot Lite's changes take effect!"
exit 0