#!/bin/bash

# Print a line for separation
function getLiner(){
	echo "---------------------------"
}

# Print the banner
function getBanner(){
	figlet "$HOSTNAME SysInfos"
	getLiner
}

# Print User infos
function getUserInfo(){
	echo "you are: " $(whoami)
	echo "your groups are:" $(groups)
	getLiner
}

# Print Host infos
function getHostInfo(){
	echo "Hostname: $HOSTNAME "
	echo "Internal IP adress: " $(hostname --all-ip-addresses)
	echo "External IP adress: " $(wget -q -O - "http://canhazip.com/" )
	echo "Nameserver is: " $(cat /etc/resolv.conf |grep nameserver | cut -d " " -f 2 )
	getLiner
}

# Print Google ping and tell the response time
function getGoogleStatus(){
	echo "Google ping time: " $(ping -c 1 8.8.8.8 | grep time | cut -d "=" -f4 | sed '$d' )
	echo "Please wait..."
	pings=$(ping -c 10 8.8.8.8 | grep time | cut -d "=" -f4 | sed '$d' | cut -d ' ' -f 1 )

	total=0

	for ping in $pings
	do
		total=$(($total + $ping))
		echo $total
	done

	echo "Google ping time Avg: " $(( $total \/ 10))
	getLiner
}

# Print App menu
function getMenu(){
	echo "#############################"
	echo "#  Bienvenu dans le SysCLI \#"
	echo "#############################"
	echo ""
	echo "MENU:"
	echo "		1) Get User informations"	
	echo "		2) Get Host informations"	
	echo "		3) Get google ping status"				
	echo "		4) quit"
	echo ""
	echo "############################"
	echo ""
	read -p "input your choice: " choice
 	echo "$choice"

	case $choice in
		1)
			getUserInfo
			echo " 1 "
			;;
		2)		
			getHostInfo
			;;
		3)	
			getGoogleStatus
			;;
		4)
			end=true
			exit
			;;
	esac
}

#####################
# Main menu CLI     #
#####################
end=true
getBanner
while [ end ]
do
	getMenu
done

