set -e # exit on errors
cat << "EOF"
 _____           _   _      ____              _   
|_   _|   _ _ __| |_| | ___| __ )  ___   ___ | |_ 
  | || | | | '__| __| |/ _ \  _ \ / _ \ / _ \| __|
  | || |_| | |  | |_| |  __/ |_) | (_) | (_) | |_ 
  |_| \__,_|_|   \__|_|\___|____/ \___/ \___/ \__|
               O  P  E  N    C  R            
                   _____     ____
                 /      \  |  o | 
                |        |/ ___\| 
                |_________/     
                |_|_| |_|_|
EOF
echo "Welcome to TurtleBoot OPEN CR!"
echo "developed by @kmhswimgirl"

sudo -v
while true; do sudo -n true; sleep 60; done 2>/dev/null &

sudo dpkg --add-architecture armhf  
sudo apt-get update  
sudo apt-get install libc6:armhf

export OPENCR_PORT=/dev/ttyACM0  
export OPENCR_MODEL=burger
rm -rf ./opencr_update.tar.bz2 

wget https://github.com/ROBOTIS-GIT/OpenCR-Binaries/raw/master/turtlebot3/ROS2/latest/opencr_update.tar.bz2   
tar -xvf opencr_update.tar.bz2 

cd ./opencr_update  
./update.sh $OPENCR_PORT $OPENCR_MODEL.opencr

# Kill sudo process
kill %1 2>/dev/null || true

# confirm sucess
echo "Set up complete!"