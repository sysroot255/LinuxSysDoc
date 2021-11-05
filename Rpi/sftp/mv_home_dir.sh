#!/bin/bash
#
# This script moves all users home directory from username.list 
# inside the directory of teir group.
#
for i in {1..11}
do
	echo "Moving all users directory"
	USERNAME=$(head -$i username.list | tail -1)
	GROUP=$(head -$i team.list | tail -1)
	
	echo "Moves $USERNAME into $GROUP directory"
	sudo mv /home/$USERNAME /home/$GROUP/$USERNAME
	
	echo "changing user home path config"
	sudo usermod -d /home/$GROUP/$USERNAME $USERNAME	
done
