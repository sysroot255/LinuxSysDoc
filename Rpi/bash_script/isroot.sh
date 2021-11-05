#!/bin/bash

if [ $UID -ne 0 ]
then
	echo "you are not root"
else
	echo "you are root"

fi
