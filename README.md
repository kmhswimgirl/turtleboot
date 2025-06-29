# **TurtleBoot**
Bash scripts to auto install ROS (Jazzy) on a Turtlebot3 at various points of the setup process.
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

## Turtleboot Lite:
Script name: `turtleboot_lite.bash`

### Args:
`-h | --help`: Shows information on all args/flags</br>
`-n | --name NAME`: Sets the hostname of the turtlebot [default = _turtleboot_]</br>
`-id | --ros-id ID`: Sets the ROS_DOMAIN_ID environment variable [default = _30_]</br>
`--rebuild`: add this flag to rebuild the `~/turtlebot3_ws` workspace</br>
`--reboot`: Enables auto reboot at the end of the script

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
`sudo bash turtleboot_lite.bash --name shelly --ros-id 22 --reboot`

## Turtleboot ROS:
Script name: `turtleboot_ros.bash`

### Args:
`-h | --help`: Shows information on all args/flags</br>
`-id | --ros-id ID`: Sets the `ROS_DOMAIN_ID` environment variable</br>
`--model`: Sets the `TURTLEBOT3_MODEL` environment variable
`--lidar LIDAR`: Add this flag to rebuild the `~/turtlebot3_ws` workspace </br>
`--reboot`: Add this flag to auto reboot at the end of the script</br>

### Features:
- Installs ROS Jazzy + builds turtlebot3_ws
- Configures the OPEN CR board
- Sets the `ROS_DOMAIN_ID` environment variable
- Sets the LiDAR type [LDS-01 | LDS-02]

### Requirements:
- Ubuntu Server 24.04
- Pre ROS install Steps completed
- Wifi connection
- Open CR Board connected

### Example:
My turtlebot3 burger has a 2nd gen LiDAR, I want the ROS domain ID to be 10, I do not want to reboot.

First make the script executable with:
</br>
`chmod +x turtleboot_ros.bash`

Run the script:
</br>
`sudo bash turtleboot_ros.bash --model burger --lidar 1 --ros-id 10`