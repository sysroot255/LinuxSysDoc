#!/bin/bash

sharedhome="/home/postproduction"

groups="production planning script technical videoeditors audioengineers sftpjailed"
users="marie hugo victor camille dave sarah ester adam eefje alex"

# removing the groups
for group in $groups
do
	echo "removing group $group"
	groupdel $group 2> /dev/null
done

# removing the users and their primary groups
for user in $users
do
	echo "removing user $user"
	userdel $user 2> /dev/null
	echo "removing group $user"
	groupdel $user 2> /dev/null
done

# removing the home
rm -r $sharedhome 2> /dev/null


