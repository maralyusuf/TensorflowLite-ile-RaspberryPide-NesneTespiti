# Installs Prerequisites for OpenCV

sudo apt-get  -y install libhdf5-dev libhdf5-serial-dev libhdf5-103
sudo apt-get  -y install libqtgui4 libqtwebkit4 libqt4-test python3-pyqt5
sudo apt-get  -y install libatlas-base-dev
sudo apt-get -y install libjasper-dev
sudo apt-get -y install libjpeg-dev libtiff5-dev libjasper-dev libpng12-dev
sudo apt-get -y install libavcodec-dev libavformat-dev libswscale-dev libv4l-dev
sudo apt-get -y install libxvidcore-dev libx264-dev
sudo apt-get -y install qt4-dev-tools 
sudo apt-get -y install libatlas-base-dev

# Installs OpenCV pip package

pip3 install opencv-python==3.4.11.41



# Install the tflite_runtime

echo success

version=$(python3 -c 'import sys; print(".".join(map(str, sys.version_info[:2])))')

if [ $version == "3.9" ]; then
pip3 install https://github.com/google-coral/pycoral/releases/download/v2.0.0/tflite_runtime-2.5.0.post1-cp39-cp39-linux_armv7l.whl
fi

if [ $version == "3.8" ]; then
pip3 install https://github.com/google-coral/pycoral/releases/download/v2.0.0/tflite_runtime-2.5.0.post1-cp38-cp38-linux_armv7l.whl
fi

if [ $version == "3.7" ]; then
pip3 install https://github.com/google-coral/pycoral/releases/download/v2.0.0/tflite_runtime-2.5.0.post1-cp37-cp37m-linux_armv7l.whl
fi

if [ $version == "3.6" ]; then
pip3 install https://github.com/google-coral/pycoral/releases/download/v2.0.0/tflite_runtime-2.5.0.post1-cp36-cp36m-linux_armv7l.whl
fi

if [ $version == "3.5" ]; then
pip3 install https://github.com/google-coral/pycoral/releases/download/release-frogfish/tflite_runtime-2.5.0-cp35-cp35m-linux_armv7l.whl
fi	
	
echo Prerequisites Installed Successfully
