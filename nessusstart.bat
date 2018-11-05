:: This script is only for replicating the public key to other servers and creating a new user in AWS server. It also creates new users in other non private key servers.
:: Just need to ::ove the "::" to uncomment the set list= for the servers you need
:: this batch script will import the commands from file "userscript.sh", so please put plink.exe, putty.exe, userscript.sh, userscriptconf.cmd and createuser.bat, 5 files together in the same folder
:: you can change the setting of this program in userscriptconf.cmd
:: if you need a log file, please type createuser.bat > log.txt in cmd prompt
:: Author: Jimmy created @15Nov2018
:: edited in 11Sep2018

@echo on

:: include the configuration file for this program
call userscriptconf.cmd 


if %KeyGenerateOnly%==true ( 
 goto :KeyGenerateOnly	
)

:ExportKey
:: export the public key and private key
:: will export all the key files into %keyfiletempfolder% folder
:: when export file script is enable, it will not process other scripts like :AWS and :Other
if not %exportkey%==true goto :AWS
if not exist %keyfiletempfolder% (mkdir %keyfiletempfolder%)


:: - default portno "50688" a loop to process all the uncommented network IPs with AWS Linux servers
echo "***  ExportKey - for loop to search port 50688  ***"
for %%a in (%listdiffport%) do (
	 if %%a GTR 0 (
		if not %newusername%=="" ( 
			:: pscp.exe -i %privatekeypath% -pw %myselfpasswd% %myselfusername%@%%a:/home/%exportusername%/.ssh/* %keyfiletempfolder%
			 :: pscp.exe -P %diffportno% -i %privatekeypath% -pw %myselfpassphrase% %myselfusername%@%%a:/home/%newusername%/ %keyfiletempfolder%
			 pscp.exe -P %diffportno% -i %privatekeypath% -pw %myselfpassphrase% d:\Users\jimmy.chu\Desktop\putty\nessus\*.* %myselfusername%@%%a:/home/%myselfusername%/ 
			
			if %firstkeycreate%==true ( 
				goto :finish 
			)
		)
	 )
)


goto :finish


:AWS
:: insert all the variable into temp command file
:: below variable initiation will create a new temp file, it is needed and don't remove it.
echo myselfpasswd='%myselfpasswd%' > %tempuserscript%
echo newuserpass='%newuserpass%' >> %tempuserscript%
echo newusername="%newusername%" >> %tempuserscript%
echo sudouser="%sudouser%" >> %tempuserscript%
echo privatekey="%privatekey%" >> %tempuserscript%
echo switch="on" >> %tempuserscript%
echo firstkeycreate="%firstkeycreate%" >> %tempuserscript%

:: import from userscript into temp command file for plink to run
type  %userscript% >> %tempuserscript%

:: @echo on
if %myselfusername%=="" goto :error
if %newusername%=="" goto :error

:: - a loop to process all the uncommented network IPs with AWS Linux servers

:: - default portno "22" a loop to process all the uncommented network IPs with AWS Linux servers
echo "***  AWS - for loop to search port 22  ***"
for %%a in (%list%) do (
	 if %%a GTR 0 (
		:: plink -i %privatekeypath% %myselfusername%@%%a -pw %myselfpassphrase% -m %tempuserscript%
		plink -l %myselfusername% -P %portno% -i %privatekeypath% -ssh %%a -pw %myselfpassphrase% -m %tempuserscript%
		if %firstkeycreate%==true ( 
			set exportkey=true
			::set exportusername=%newusername%
			goto :ExportKey 
		)
	 )
)

:: - default portno "50688" a loop to process all the uncommented network IPs with AWS Linux servers
echo "***  AWS - for loop to search port 50688  ***"
for %%a in (%listdiffport%) do (
	 if %%a GTR 0 (
		:: plink -i %privatekeypath% %myselfusername%@%%a -pw %myselfpassphrase% -m %tempuserscript%
		plink -l %myselfusername% -P %diffportno% -i %privatekeypath% -ssh %%a -pw %myselfpassphrase% -m %tempuserscript%
		if %firstkeycreate%==true ( 
			set exportkey=true
			::set exportusername=%newusername%
			goto :ExportKey 
		)
	 )
)


:Others
:: other servers without private key
:: insert all the variable into temp command file
:: below variable initiation will create a new temp file, it is needed and don't remove it.
echo myselfpasswd='%myselfpasswd%' > %tempuserscript%
echo newuserpass='%newuserpass%' >> %tempuserscript%
echo newusername="%newusername%" >> %tempuserscript%
echo sudouser="%sudouser%" >> %tempuserscript%
echo privatekey="%privatekey%" >> %tempuserscript%
echo switch="on" >> %tempuserscript%
echo firstkeycreate="%firstkeycreate%" >> %tempuserscript%

:: import from userscript into temp command file for plink to run
type  %userscript% >> %tempuserscript%

:: @echo on
if %myselfusername%=="" goto :error
if %newusername%=="" goto :error

:: - a loop to process all the uncommented network IPs with other Linux servers, SZ, KWT and softlayer <portno 22>
echo "***  Others - for loop to search port 22  ***"
for %%a in (%listother%) do (
	 if %%a GTR 0 (
		:: plink %myselfusername%@%%a -pw %myselfpasswd% -m %tempuserscript%
		plink -l %myselfusername% -P %portno% -ssh %%a -pw %myselfpassphrase% -m %tempuserscript%
		if %firstkeycreate%==true ( 
			set exportkey=true
			::set exportusername=%newusername%
			goto :ExportKey 
		)
	 )
)

:: - a loop to process all the uncommented network IPs with other Linux servers, SZ, KWT and softlayer <portno 50688>
echo "***  Others - for loop to search port 50688  ***"
for %%a in (%listotherdiffport%) do (
	 if %%a GTR 0 (
		:: plink %myselfusername%@%%a -pw %myselfpasswd% -m %tempuserscript%
		plink -l %myselfusername% -P %diffportno% -ssh %%a -pw %myselfpassphrase% -m %tempuserscript%
	 )
)

goto :finish


:KeyGenerateOnly
winscp.exe /keygen %keyfiletempfolder%\id_rsa /output=%keyfiletempfolder%\%newusername%.ppk
if %firstkeycreate%==true ( 
 set firstkeycreate=false	
)
goto :finish

	
:finish
:: - remove the temp command file after finish
if %firstkeycreate%==true ( 
 goto :KeyGenerateOnly	
)
del %tempuserscript%
echo Finished with no error !!!
exit /b 0


:error
:: - remove the temp command file after finish
del %tempuserscript%
echo username or new user name is missing !!!
exit /b 0
