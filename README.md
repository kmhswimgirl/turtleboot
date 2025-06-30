# **TurtleBoot**
Bash scripts to auto install ROS (Jazzy) and configure the SBC on a Turtlebot3. 
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

## TurtleBoot ROS
