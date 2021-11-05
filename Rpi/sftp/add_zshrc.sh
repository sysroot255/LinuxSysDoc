#!/bin/bash
#
# This script install .zshrc into all user home directory 
# 
#

for i in {1..11}
do
	echo "Installing .zshrc"
	USERNAME=$(head -$i username.list | tail -1)
	GROUP=$(head -$i team.list | tail -1)
	
	echo "cp .zshrc into $USERNAME home directory"
	cp /home/pi/.zshrc /home/$GROUP/$USERNAME
done
