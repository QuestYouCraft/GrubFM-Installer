::[Bat To Exe Converter]
::
::fBE1pAF6MU+EWHreyHcjLQlHcAWGMWK0OpEZ++Pv4Pq79VccGucnfe8=
::fBE1pAF6MU+EWHreyHcjLQlHcAWGMWK0OpEZ++Pv4Pq7pV8IVusxa5uV36yLQA==
::fBE1pAF6MU+EWHreyHcjLQlHcAWGMWK0OpEZ++Pv4Pq7pV8IVuQyNY3S1PqUKfBz
::YAwzoRdxOk+EWAjk
::fBw5plQjdCyDJGyX8VAjFBpQQQ2MAE+/Fb4I5/jH4+WArXIaRvc9foKV07eBQA==
::YAwzuBVtJxjWCl3EqQJgSA==
::ZR4luwNxJguZRRnk
::Yhs/ulQjdF65
::cxAkpRVqdFKZSDk=
::cBs/ulQjdF65
::ZR41oxFsdFKZSDk=
::eBoioBt6dFKZSDk=
::cRo6pxp7LAbNWATEpSI=
::egkzugNsPRvcWATEpSI=
::dAsiuh18IRvcCxnZtBJQ
::cRYluBh/LU+EWAnk
::YxY4rhs+aU+IeA==
::cxY6rQJ7JhzQF1fEqQJhZkoaHErSXA==
::ZQ05rAF9IBncCkqN+0xwdVsFAlXMbCXqZg==
::ZQ05rAF9IAHYFVzEqQIXOg5WainCFWWpErQQ5O3pjw==
::eg0/rx1wNQPfEVWB+kM9LVsJDGQ=
::fBEirQZwNQPfEVWB+kM9LVsJDCOQKWmcK/U15vvv7uaLp199
::cRolqwZ3JBvQF1fEqQIXOg5WainCFWWpErQQ5O3pjw==
::dhA7uBVwLU+EWDk=
::YQ03rBFzNR3SWATElA==
::dhAmsQZ3MwfNWATExVc1Ow9tQxGhLmq8EtU=
::ZQ0/vhVqMQ3MEVWAtB9wSA==
::Zg8zqx1/OA3MEVWAtB9wSA==
::dhA7pRFwIByZRRmj5lcyDjYUZQqRKGq2CrAOiA==
::Zh4grVQjdCyDJGyX8VAjFBpQQQ2MAE+/Fb4I5/jHyPiSoGswa8sxa5va1riLMq4W8kCE
::YB416Ek+ZW8=
::
::
::978f952a14a936cc963da21a135fa983
@echo off
title GrubFM Installer
echo GrubFM Installer by QuestYouCraft
for /f "tokens=2 delims=[]" %%i in ('ver') do (@for /f "tokens=2 delims=. " %%a in ("%%i") do set "n=%%a")
if %n% LEQ 5 (
echo Sorry, I can't work in Windows XP and lower...
pause
exit
)
wmic diskdrive get Index,Partitions,Model,Size,Caption
echo WARNING! All data on the drive you select will be deleted!
set /p IndexOfInstallDrive="Enter the INDEX of the disk on which the installation will be made: "
(
echo select disk %IndexOfInstallDrive%
echo clean
echo create partition primary size=24
echo active
echo format fs=fat quick label=GRUBFM
echo assign
echo active
echo create partition primary
echo format fs=ntfs quick
echo assign
) > script.txt
echo Drive preparation...
diskpart /s script.txt>nul
del script.txt
echo Installing GRUB4DOS...
%cd%\grubinst.exe (hd%IndexOfInstallDrive%)
if %errorlevel%==0 (
SetLocal EnableDelayedExpansion
for /f "tokens=1* delims=" %%a in ('wmic LogicalDisk Get VolumeName^, Caption ^| findstr /i /c:"GRUBFM"') do (
for /f "tokens=1 delims=:" %%b in ("%%a") do (
echo Extracting files...
%cd%\7za.exe x -o%%b:\ -y %cd%\grubfm-bin.zip>nul
))
color 27
title GrubFM Installer: success
echo OK!
pause
exit /b
) else (
color 47
title GrubFM Installer: error
echo RUNTIME ERROR!
pause
exit /b
)
