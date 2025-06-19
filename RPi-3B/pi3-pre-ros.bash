#!/bin/bash

set -e # exit on errors

CONFIG_FILE="/home/ubuntu/config.txt"

# Check if config file exists
if [ ! -f "$CONFIG_FILE" ]; then
    echo "SETUP_STATE=init" > "$CONFIG_FILE"
fi

source "$CONFIG_FILE"
echo "Current state: $SETUP_STATE"

if ["$SETUP_STATE" = "init"]
    sudo sed -i 's/APT::Periodic::Update-Package-Lists "0";/APT::Periodic::Update-Package-Lists "1";/' /etc/apt/apt.conf.d/20auto-upgrades
    sudo sed -i 's/APT::Periodic::Unattended-Upgrade "0";/APT::Periodic::Unattended-Upgrade "1";/' /etc/apt/apt.conf.d/20auto-upgrades

    cat /etc/apt/apt.conf.d/20auto-upgrades

    systemctl mask systemd-networkd-wait-online.service
    sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target

    echo "SETUP_STATE=swapfile" > "$CONFIG_FILE"
    echo "State: $SETUP_STATE"

    sudo reboot
fi

if ["$SETUP_STATE" = "swapfile" && $SWAP_FILE=false]

    if [$SWAP_FILE=false]; then
        echo "SETUP_STATE=ros-install" > "$CONFIG_FILE"
    fi

    sudo fallocate -l 2G /swapfile
    sudo chmod 600 /swapfile
    sudo mkswap /swapfile
    sudo swapon /swapfile

    if ! sudo swapon /swapfile; then
        echo "Failed to enable swapfile"
        exit 1
    fi

    # add fstab for consistency after reboots
    echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab

    # verify swap is active, probably can remove these...
    free -h
    swapon --show

    echo "SETUP_STATE=ros-install" > "$CONFIG_FILE"

fi

if []
fi