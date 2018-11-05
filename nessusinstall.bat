@echo on


:: this batch script will import the commands from file "userscript.sh", so please put plink.exe, putty.exe, userscript.sh, createuserconf.cmd and deluserAWS.bat, 5 files together in the same folder
:: you can change the setting of this program in createuserconf.cmd
:: if you need a log file, please type createuser.bat > log.txt in command.com

:: include the configuration file for this program
call userscriptconf.cmd 

:: - Don't change the below setting unless you understand what it is
echo myselfpasswd='%myselfpasswd%' > %tempuserscript%
echo newuserpass='%newuserpass%' >> %tempuserscript%
echo newusername="%newusername%" >> %tempuserscript%
echo sudouser="%sudouser%" >> %tempuserscript%
echo privatekey="%privatekey%" >> %tempuserscript%

:: - generate a temp command file for plink to run
type  %nessususerscript% >> %tempuserscript%

:: - a loop to count all the uncommented network IPs
:: @echo on
if %myselfusername%=="" goto :end
if %newusername%=="" goto :end

:AWS
:: - default portno "50688" a loop to process all the uncommented network IPs with AWS Linux servers
echo "***  AWS - for loop to search port 50688  ***"
for %%a in (%listdiffport%) do (
	 if %%a GTR 0 (
	 plink -P %diffportno% -i %privatekeypath% %myselfusername%@%%a -pw %myselfpassphrase% -m %tempuserscript%
	 )
	)

:Others
:: - a loop to process all the uncommented network IPs with other Linux servers, SZ, KWT and softlayer <portno 22>
echo "***  Others - for loop to search port 22  ***"
for %%a in (%listother%) do (
	 if %%a GTR 0 (
	 plink %myselfusername%@%%a -pw %myselfpassphrase% -m %tempuserscript%
	 )
	)

:: - a loop to process all the uncommented network IPs with other Linux servers, SZ, KWT and softlayer <portno 50688>
echo "***  Others - for loop to search port 50688  ***"
for %%a in (%listotherdiffport%) do (
	 if %%a GTR 0 (
	 plink -P %diffportno% %myselfusername%@%%a -pw %myselfpassphrase% -m %tempuserscript%
	 )
	)


	
:: - remove the temp command file after finish
:: @echo off
del %tempuserscript%
echo Finished with no error !!!
exit /b 0

:end
del %tempuserscript%
echo username or new user name is missing !!!
exit /b 0
