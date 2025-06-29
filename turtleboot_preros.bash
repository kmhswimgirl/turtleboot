#!/bin/bash
set -e # exit on errors
cat << "EOF"\
 _____           _   _      ____              _   
|_   _|   _ _ __| |_| | ___| __ )  ___   ___ | |_ 
  | || | | | '__| __| |/ _ \  _ \ / _ \ / _ \| __|
  | || |_| | |  | |_| |  __/ |_) | (_) | (_) | |_ 
  |_| \__,_|_|   \__|_|\___|____/ \___/ \___/ \__|
              P  R  E  -  R  O  S            
                   _____     ____
                 /      \  |  o | 
                |        |/ ___\| 
                |_________/     
                |_|_| |_|_|
EOF
echo "Welcome to TurtleBoot pre-ros!"
echo "developed by @kmhswimgirl"

 # change automatic update settings
  sed -i "1s/.*/APT::Periodic::Update-Package-Lists "0";/" /etc/apt/apt.conf.d/20auto-upgrades
  sed -i "2s/.*/APT::Periodic::Unattended-Upgrade "0";/" /etc/apt/apt.conf.d/20auto-upgrades

  # prevent boot-up delay
  systemctl mask systemd-networkd-wait-online.service
  systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target

  # reboot
  reboot