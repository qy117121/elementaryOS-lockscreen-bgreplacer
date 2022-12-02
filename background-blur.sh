#!/bin/bash

if [[ -d /tmp/greeter ]]
then
	echo "/greeter exists within /tmp/, deleting."
	rm -rf /tmp/greeter
fi
# Clones greeter into tmp
cd /tmp/
git clone https://github.com/elementary/greeter.git

# Blur image
convert /home/"$SUDO_USER"/图片/bg.jpg -filter Gaussian -blur 0x6 /home/"$SUDO_USER"/图片/bg_blur.jpg

cd /tmp/greeter/compositor

# Settings file used in greeter to indicate which file it is using.
filename=SystemBackground.vala

# Replace path to new texture's path.
sed -i "s/resource\:\/\/\/io\/elementary\/desktop\/gala\/texture\.png/file\:\/\/\/home\/"$SUDO_USER"\/图片\/bg_blur\.jpg/" $filename

cd /tmp/greeter

# Build greeter
meson _build --prefix=/usr
ninja install -C _build
