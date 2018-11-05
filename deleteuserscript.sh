#!/bin/bash
# This program is to create an user
# 22 Jan 2018 created by Jimmy Chu
# userscript.sh
# this script is working with plink and createuser.bat in windows environment

#check if the user is existed or not
if getent passwd $newusername > /dev/null 2>&1; 
then
	echo "#### User ($newusername) is existed, script will go to remove the user. ####";
	echo "You have 5 seconds to think. If want to cancel, press CTRL+C";
	sleep 5s;
	echo $myselfpasswd | sudo -S userdel -r $newusername; 
else
	echo "#### User ($newusername) is not existed, script will be terminated. ####";
	exit 1;
fi