#!/bin/bash
# This program is to create an user
# 22 Jan 2018 created by Jimmy Chu
# userscript.sh
# this script is working with plink and createuser.bat in windows environment

#check if the user is existed or not
if getent passwd $newusername > /dev/null 2>&1; 
then
	echo "#### User ($newusername) is already existed, script will be terminated here. ####";
	exit 1;

else

	#create new user
	if [ "$newusername" != "" ]; then 
		echo $myselfpasswd | sudo -S useradd -m $newusername;

		#if it is sudouser, it will be set to sudo group
		if [ "$sudouser" = "true" ]; then echo $myselfpasswd | sudo -S usermod -aG sudo $newusername; fi;
	
		#if it is regular user, it will be set to following groups
		echo $myselfpasswd | sudo -S usermod -s /bin/bash $newusername; 
		echo $myselfpasswd | sudo -S usermod -aG sshusers $newusername; 
		echo $myselfpasswd | sudo -S usermod -aG userkill $newusername; 
		echo $myselfpasswd | sudo -S usermod -aG tomcat $newusername; 
		
		#create the user password after their acccount is created
		(echo $newuserpass; echo $newuserpass) | sudo passwd $newusername; 

		if [ "$firstkeycreate" = "true" ]; then
			sudo -u $newusername ssh-keygen -t rsa -b 1024 -P $newuserpass -f "/home/$newusername/.ssh/id_rsa" -q;
			sudo -u $newusername cp "/home/$newusername/.ssh/id_rsa.pub" "/home/$newusername/.ssh/authorized_keys"; 
			echo $myselfpasswd | sudo -S chmod 705 "/home/$newusername/.ssh"; 
			echo $myselfpasswd | sudo -S chmod 644 "/home/$newusername/.ssh/id_rsa"; 
			exit 1;
		fi;
	fi;


	#if private is not empty, below code will create the .ssh folder and copy public key in .ssh
	if [ "$privatekey" != "" ] && [ "$switch" = "on" ];
	then 
		echo $myselfpasswd | sudo -S mkdir "/home/$newusername/.ssh"; 
		echo $myselfpasswd | sudo -S chown $newusername:$newusername "/home/$newusername/.ssh";
		echo $myselfpasswd | sudo -S chmod 777 "/home/$newusername/.ssh";
		echo $privatekey >> /home/$newusername/.ssh/authorized_keys; 
		echo $myselfpasswd | sudo -S chmod 740 "/home/$newusername/.ssh"
		echo $myselfpasswd | sudo -S chown $newusername:$newusername "/home/$newusername/.ssh/authorized_keys";
	fi;
	
fi