# **RBE3002-tb3-setup**
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
## Which bash script should I use?

That depends on what status your microSD card is in!

## Turtleboot Lite:
Script name: `turtleboot_lite.bash`

### Features:
- Regenerates ssh keys
- Changes the hostname
- Changes `ROS_DOMAIN_ID`

### Requirements:
- Ubuntu Server 24.04 is installed
- ROS Jazzy Jalisco is already
- Wi-fi connection not required!

### Example:
I want to change my hostname to "hello-there", my `ROS_DOMAIN_ID` to 22 and I do not want to rebuild the turtlebot3_ws.

First make the script executable with:
</br>
`chmod +x scriptname.bash`

Run the script:
</br>
`sudo ./turtleboot.bash "hello-there" "22" false`
