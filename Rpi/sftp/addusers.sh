#!/bin/bash

#FILE=$1
#NB=$(cat $FILE | wc -l)

for i in {0..11} ;
do

	echo "$i"
	USERNAME=$(head -$i username.list | tail -1)
	PASSWORD=$(head -$i password.list | tail -1)
	GROUP=$(head -$i team.list     | tail -1)

	echo "---------------------------------------------------"
	echo "Adding new user:"
	echo "user: $USERNAME password: $PASSWORD group: $GROUP"
	echo "---------------------------------------------------"

	echo "making sure $GROUP exists..."
	groupadd -f $GROUP

	echo "adding user: $USERNAME"
	useradd $USERNAME -m -G $GROUP -s "/usr/bin/zsh"

	echo "setting password: $PASSWORD for $USERNAME"
	echo $USERNAME:$PASSWORD | chpasswd

	echo "adding $USERNAME to $GROUP"

	echo "---------------------------------------------------"

done
