#!/bin/bash

# make turtlebot workspace
mkdir -p ~/turtlebot3_ws/src
cd ~/turtlebot3_ws/src

# check for duplicate dir or accidental root owned dir
if [ -d "turtlebot3" ]; then
  echo "Removing existing turtlebot3 directory (may be root-owned or incomplete)..."
  rm -rf turtlebot3
fi

# Clone Packages from GitHub, make sure branches are there as well
if ! git clone -b jazzy https://github.com/ROBOTIS-GIT/turtlebot3.git; then
  echo "Failed to clone turtlebot3 repository. Check if the branch 'jazzy' exists."
  exit 1
fi
if ! git clone -b jazzy https://github.com/ROBOTIS-GIT/ld08_driver.git; then
  echo "Failed to clone ld08_driver repository. Check if the branch 'jazzy' exists."
  exit 1
fi

# remove cartographer and nav2 packages
cd ~/turtlebot3_ws/src/turtlebot3
rm -rf turtlebot3_cartographer turtlebot3_navigation2 || true
cd ~/turtlebot3_ws/

# Prevent duplicate lines in .bashrc
grep -qxF 'source /opt/ros/jazzy/setup.bash' ~/.bashrc || echo 'source /opt/ros/jazzy/setup.bash' >> ~/.bashrc

# building turtlebot workspace
cd ~/turtlebot3_ws/
colcon build --symlink-install --parallel-workers 1