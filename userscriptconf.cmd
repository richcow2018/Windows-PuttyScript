:: this is configuration file for createuser batch program
:: Just need to remove the "::" to uncomment the set list= for the servers you need
:: Author: Jimmy created @15Nov2018
:: edited in 15Aug2018

:: declare the variable, please not to comment or remove it
set list=0
set listother=0
set listotherdiffport=0
set listdiffport=0
set sudouser=""
set privatekey=""
set myselfpassphrase=""
set myselfpasswd=""
set newuserpass=""
set newusername=""
set myselfusername=""
set exportkey=""
set exportusername=""
set firstkeycreate=""
set portno=22
set diffportno=50688

:: change the file path as you need, please make sure the path is valid
set privatekeypath="d:\Users\user.name\Desktop\"
set tempuserscript="c:\temp\userscripttemp.sh"
set userscript="d:\Users\user.name\Desktop\putty\userscript.sh"
set deleteuserscript="d:\Users\user.name\Desktop\putty\deleteuserscript.sh"
set keyfiletempfolder="c:\temp\key"

:: change the your passphrase, password, new user name and password
:: you can use this website to generate the password for userscript
:: https://identitysafe.norton.com/password-generator/
:: Don't use "Punctuation" in your password and standard will be 8 digits

:: Yourself login info
set myselfusername=username
set myselfpassphrase=abc
set myselfpasswd=abc

:: New user info 
set newuserpass=username
set newusername=abc


:: if it is the first key to create, please put "true" to enable or "false" or comment "::" to disable it
set firstkeycreate=false

:: if you need to export the keys, please put "true" to enable or "false" or comment "::" to disable it
:: please fill up the user name you need to export his/her key files.
:: if it is the "first account" to be created, please don't enable it
set exportkey=false

:: if it is sudo user, please put "true" to enable or "false" or comment "::" to disable it
set sudouser=true

:: if you only need to generate ".ppk" private, please put "true" to enable or "false" or comment "::" to disable it
:: please confirm there is a "id_rsa" prepared in temp\key odler
set KeyGenerateOnly=false

:: put your public key after"=", there should be no space next to "="
if exist %keyfiletempfolder%\id_rsa.pub (
	set /p privatekey=<%keyfiletempfolder%\id_rsa.pub
) else (
	if exist %keyfiletempfolder%\authorized_keys (
		set /p privatekey=<%keyfiletempfolder%\authorized_keys
	)
)

:: ************************************
:: AWS Linux Servers port no 22
:: ************************************


:: ************************************
:: AWS Different port no 50688 with private key
:: ************************************
:: New abcdef - 1.1.1.1
:: set listdiffport=%listdiffport%;1.1.1.1

:: New abcdef - 1.1.1.1
::  set listdiffport=%listdiffport%;1.1.1.1

:: New abcdef - 1.1.1.1
::  set listdiffport=%listdiffport%;1.1.1.1

:: New abcdef - 1.1.1.1
::  set listdiffport=%listdiffport%;1.1.1.1
 
:: New abcdef
::  set listdiffport=%listdiffport%;1.1.1.1

:: New abcdef - 1.1.1.1
::  set listdiffport=%listdiffport%;1.1.1.1

:: New abcdef - 1.1.1.11
:: set listdiffport=%listdiffport%;1.1.1.1
 
:: New abcdef - 1.1.1.1
:: set listdiffport=%listdiffport%;1.1.1.1

:: New abcdef - 1.1.1.1
::  set listdiffport=%listdiffport%;1.1.1.1
 

 
:: ************************************
:: Other Linux Servers port 50688 with private key
:: ************************************
::New abcdef - 1.1.1.1:50688 (with AWS private key)
:: set listdiffport=%listdiffport%;1.1.1.1


:: ************************************
::Other Linux Servers without key and port 22
:: ************************************
:: New abcdef - 1.1.1.1:22
:: set listother=%listother%;1.1.1.1

:: New abcdef - 1.1.1.1:22
:: set listother=%listother%;1.1.1.1

:: New abcdef - 1.1.1.1:22(no key needed, but need to edit it in etc/ssh/sshd_config)
:: set listother=%listother%;1.1.1.1

:: New abcdef - 1.1.1.1 (no key needed)
:: set listother=%listother%;1.1.1.1

 
 :: ************************************
:: Other Linux Servers port 50688 without key
:: ************************************
:: New abcdefn - 1.1.1.1:50688
:: set listotherdiffport=%listotherdiffport%;1.1.1.1

:: New abcdef - 1.1.1.1:50688 (no key needed)
:: set listotherdiffport=%listotherdiffport%;1.1.1.1

:: New abcdef - 1.1.1.1:50688 (no key needed)
:: set listotherdiffport=%listotherdiffport%;1.1.1.1




