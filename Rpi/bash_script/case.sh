#!/bin/bash

function start(){
	echo "start"
}
function stoptool(){
	echo "stop"
}                  
function status(){
	echo "status"
}
function final(){
	echo "*"
}

case $1 in
      	start)
		echo "Start"
		;;
	stop)
		echo "stop"
		;;
	status)
		echo "status"
		;;
	*)
		echo "it's unclear what you want from me"
		;;

