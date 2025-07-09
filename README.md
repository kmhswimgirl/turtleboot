# **TurtleBoot** 

![Ubuntu](https://img.shields.io/badge/Ubuntu-24.04-blue) 
![ROS2](https://img.shields.io/badge/ROS2-Jazzy-blueviolet?logo=ros&logoColor=white)![TurtleBot3](https://img.shields.io/badge/TurtleBot3-🐢_Ready-green?labelColor=black)</br>

Bash scripts to auto install ROS (Jazzy) and configure the SBC on a Turtlebot3. :robot: :turtle: :sparkles:
```
 _____           _   _      ____              _   
|_   _|   _ _ __| |_| | ___| __ )  ___   ___ | |_ 
  | || | | | '__| __| |/ _ \  _ \ / _ \ / _ \| __|
  | || |_| | |  | |_| |  __/ |_) | (_) | (_) | |_ 
  |_| \__,_|_|   \__|_|\___|____/ \___/ \___/ \__|
                   _____     ____
                 /      \  |  o | 
                |        |/ ___\| 
                |_________/     
                |_|_| |_|_|
```
> **Note:** Never run the scripts as root! 
## Table of Contents
(C) = Core Script, (U) = Utility Script
- [TurtleBoot Pre-ROS](#turtleboot-pre-ros) (C)
- [TurtleBoot ROS](#turtleboot-ros) (C)
- [TurtleBoot Lite](#turtleboot-lite) (U)
- [TurtleBoot OPEN CR](#turtleboot-open-cr) (U)
- [References](#looking-for-refs)

## TurtleBoot Pre-ROS
Script name: `turtleboot_preros.bash`

>**Note:** Run this before running `turtleboot_ros.bash`!

### Features:
- Prepares SBC for ROS Jazzy install
- Configures systemctl settings

### Requirements:
- Ubuntu Server 24.04

### Example:
I want to install ROS Jazzy on my turtlebot 3, but I have not completed any of the setup steps yet and am planning on later 

First make the script executable with:
</br>
`chmod +x turtleboot_preros.bash`

Run the script:
</br>
`bash turtleboot_preros.bash` 

## TurtleBoot ROS
Script name: `turtleboot_ros.bash`

>**Note:** Please make sure to run `turtleboot_preros.bash` first before running this script!

### Args:
`-h | --help`: Shows information on all args/flags</br>
`-id | --ros-id ID`: Sets the `ROS_DOMAIN_ID` environment variable</br>
`--lidar | -ld LIDAR`: sets the `LDS_MODEL`environment variable </br>
`--ros-only | -ro` : Only installs ROS, does not configure the OPEN CR board</br>
`--model | -m MODEL`: sets the `TURTLEBOT3_MODEL` environment variable</br>
`--no-swapfile |-ns`: do not create a swapfile before installing ROS</br>

> **Note:** `--no-swapfile` is not recommended on RPi's that have =< 2GB RAM!

### Features:
- Installs ROS Jazzy Jalisco base version + Turtlebot3 dependencies
- Configures OPEN CR board
- Changes the `ROS_DOMAIN_ID`, `TURTLEBOT3_MODEL`, and `LDS_MODEL` environment variable

### Requirements:
- Ubuntu Server 24.04
- Wi-Fi Connection
- [TurtleBoot Pre-ROS](#turtleboot-pre-ros) or equivalent

### Example:
I have a gen 2 LiDAR Turtlebot3 Waffle and want to my `ROS_DOMAIN_ID` to be 8.

First make the script executable with:
</br>
`chmod +x turtleboot_ros.bash`

Run the script:
</br>
`bash turtleboot_ros.bash --lidar 2 --ros-id 8 --model waffle`

## TurtleBoot Lite:
Script name: `turtleboot_lite.bash`

### Args:
`-h | --help`: Shows information on all args/flags</br>
`-n | --name NAME`: Sets the hostname of the turtlebot (default is turtle_boot)</br>
`-id | --ros-id ID`: Sets the ROS_DOMAIN_ID environment variable</br>
`--rebuild`: add this flag to rebuild the `~/turtlebot3_ws` workspace</br>
`--reboot`: add this flag to auto reboot at the end of the script

### Features:
- Regenerates ssh keys
- Changes the hostname
- Changes the `ROS_DOMAIN_ID` environment variable

### Requirements:
- Ubuntu Server 24.04
- ROS Jazzy Jalisco installed + packages built

### Example:
I want to change my hostname to _"shelly"_, my `ROS_DOMAIN_ID` to 22, I do **not** want to rebuild the turtlebot3_ws, and I do want to auto reboot.

First make the script executable with:
</br>
`chmod +x turtleboot_lite.bash`

Run the script:
</br>
`bash turtleboot_lite.bash --name shelly --ros-id 22 --reboot`

## TurtleBoot OPEN CR
Script name: `turtleboot_opencr.bash`

### Features:
- Configures the OPEN CR board

### Requirements:
- Ubuntu Server 24.04
- ROS installed

### Example:
I want to just configure the OPEN CR board on my Turtlebot3.

First make the script executable with:
</br>
`chmod +x turtleboot_opencr.bash`

Run the script:
</br>
`bash turtleboot_opencr.bash`

Looking for Refs?
--
[ROS Jazzy Docs](https://docs.ros.org/en/jazzy/index.html)</br>
[Robotis Quick Start Guide (Turtlebot3)](https://emanual.robotis.com/docs/en/platform/turtlebot3/sbc_setup/)</br>