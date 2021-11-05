#!/bin/bash

read -s -p "enter the secret password please: " response

if [ "$response" == "supersecret" ]
then
	echo "Welcome in the real world!"
else
	echo "ya shall not past!"
fi
