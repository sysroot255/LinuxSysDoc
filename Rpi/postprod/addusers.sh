#!/bin/bash

sharedhome="/home/postproduction"

groups="production planning script technical videoeditors audioengineers sftpjailed"
users="marie hugo victor camille dave sarah ester adam eefje alex"

marie="production planning script technical videoeditors audioengineers sftpjailed"
hugo="production planning script sftpjailed"
victor="production planning sftpjailed"
camille="production script sftpjailed"
dave="technical videoeditors sftpjailed"
sarah="technical videoeditors sftpjailed"
ester="technical videoeditors sftpjailed"
adam="technical audioengineers sftpjailed"
eefje="technical audioengineers sftpjailed"
alex="production planning script technical videoeditors audioengineers"

# adding the home
mkdir -p $sharedhome

# adding the groups
for group in $groups
do
	echo "adding group $group"
	groupadd $group
done

# adding the users
for user in $users
do
	echo "adding user $user"
	useradd $user
	echo "setting the password for $user"
	echo "$user:test" | chpasswd
done

# adding the users to their groups
for user in $users
do
	echo "adding groups for $user"
	usergroups=$(eval echo \$$user)
	for group in $usergroups 
	do
		echo "adding $user to $group"
		usermod -a -G $group $user
	done
done

