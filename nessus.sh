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
	sleep 2s;
	## echo $myselfpasswd | sudo -S apt-get -q -y update;
	## echo $myselfpasswd | sudo -S apt-get -q -y -o DPkg::Options::=--force-confold -o DPkg::Options::=--force-confdef upgrade;
	echo $myselfpasswd | sudo -S apt-get -q -y -o DPkg::Options::=--force-confold -o DPkg::Options::=--force-confdef dist-upgrade;
	## echo $myselfpasswd | sudo -S dpkg -i "/home/jchu/NessusAgent-7.1.1-ubuntu1110_amd64.deb";
	## echo $myselfpasswd | sudo -S /etc/init.d/nessusagent stop;	
	## echo $myselfpasswd | sudo -S rm /etc/tenable_tag
	## echo $myselfpasswd | sudo -S /opt/nessus_agent/sbin/nessuscli agent unlink --force;
	## echo $myselfpasswd | sudo -S /etc/init.d/nessusagent start;	
	## echo $myselfpasswd | sudo -S /opt/nessus_agent/sbin/nessuscli agent link --host=cloud.tenable.com --port=443 --key=0d1da42159a93204fac1dba1cf436a32c3adea655de12917c8dc9eaef8fe0c3f;
else
	echo "#### User ($newusername) is not existed, script will be terminated. ####";
	exit 1;
fi