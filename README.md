# **RBE3002-tb3-setup**
Bash scripts to auto install ROS (Jazzy) on a Turtlebot3 at various points of the setup process.

## Which bash script should I use?

That depends on what status your microSD card is in!

`turtleboot.bash` info:
--
### Features:
- Regenerates ssh keys
- Changes the hostname
- Changes `ROS_DOMAIN_ID`

### Requirements:
- Ubuntu Server 24.04 is installed
- ROS Jazzy Jalisco is already
- Wi-fi connection not required

### Example:
I want to change my hostname to "hello-there", my `ROS_DOMAIN_ID` to 22 and I do not want to rebuild the turtlebot3_ws.

First make the script executable with:
</br>
`chmod +x scriptname.bash`

Run the script:
</br>
`sudo ./turtleboot.bash "hello-there" "22" false`
