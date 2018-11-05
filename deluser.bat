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
type  %deleteuserscript% >> %tempuserscript%

:: - a loop to count all the uncommented network IPs
:: @echo on
if %myselfusername%=="" goto :end
if %newusername%=="" goto :end

for %%a in (%list%) do (
	 if %%a GTR 0 (
	 plink -i %privatekeypath% %myselfusername%@%%a -pw %myselfpassphrase% -m %tempuserscript%
	 )
	)
	
for %%a in (%listdiffport%) do (
	 if %%a GTR 0 (
	 plink -P %diffportno% -i %privatekeypath% %myselfusername%@%%a -pw %myselfpassphrase% -m %tempuserscript%
	 )
	)
	
for %%a in (%listother%) do (
	 if %%a GTR 0 (
	 plink %myselfusername%@%%a -pw %myselfpassphrase% -m %tempuserscript%
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
