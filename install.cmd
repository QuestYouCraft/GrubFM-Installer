::[Bat To Exe Converter]
::
::fBE1pAF6MU+EWHreyHcjLQlHcAWGMWK0OpEZ++Pv4Pq79VccGucnfe8=
::fBE1pAF6MU+EWHreyHcjLQlHcAWGMWK0OpEZ++Pv4Pq7pV8IVusxa5uV36yLQA==
::fBE1pAF6MU+EWHreyHcjLQlHcAWGMWK0OpEZ++Pv4Pq7pV8RUPBf
::fBE1pAF6MU+EWHreyHcjLQlHcAWGMWK0OpEZ++Pv4Pq7oVgPWN0vd53P27aCJa4W8kCE
::YAwzoRdxOk+EWAjk
::fBw5plQjdCyDJGyX8VAjFBpQQQ2MAE+/Fb4I5/jH5umIrAMUV+1f
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
::cxY6rQJ7JhzQF1fEqQJhZkkaHErSXA==
::ZQ05rAF9IBncCkqN+0xwdVsFAlbMbCXqZg==
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
exit /b
)
wmic diskdrive get Index,Partitions,Model,Size,Caption
echo WARNING! All data on the drive you select will be deleted!
set /p IndexOfInstallDrive="Enter the INDEX of the disk on which the installation will be made: "
(
echo sel disk %IndexOfInstallDrive%
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
echo Connecting to GitHub...
ping github.com>nul
if %errorlevel% neq 0 goto er
for /f "tokens=7 delims=/" %%a in ('curl_portable -k https://github.com/a1ive/grub2-filemanager/releases/latest/') do (
    setlocal EnableDelayedExpansion
    for /f "tokens=*" %%b in ("%%a") do (
    set c=%%b
    set c=!c:"= !
    for /f "tokens=1" %%b in ("!c!") do (
        echo Downloading GrubFM %%b...
        curl_portable -k -L -O https://github.com/a1ive/grub2-filemanager/releases/download/%%b/grubfm-en_US.7z
        )
    )
)
echo Installing GRUB4DOS...
grubinst.exe (hd%IndexOfInstallDrive%)
if %errorlevel% neq 0 goto er
SetLocal EnableDelayedExpansion
for /f "tokens=1* delims=" %%a in ('wmic LogicalDisk Get VolumeName^, Caption ^| findstr /i /c:"GRUBFM"') do (
for /f "tokens=1 delims=:" %%b in ("%%a") do (
    echo Copying files...
( 
  echo echo Created through GrubFM by QuestYouCraft
  echo map --mem /grubfm.iso (0xff^)
  echo map --hook
  echo chainloader (0xff^)
) > %%b:\menu.lst
(
    echo This section was created and recorded by files through "GrubFM Installer" (by QuestYouCraft^).
) > %%b:\readme.txt
7za.exe e -odata grubfm-en_us.7z>nul
md %%b:\EFI\Boot>nul
move data\*.efi %%b:\EFI\Boot>nul
move data\*.* %%b:\>nul
move grldr %%b:\>nul
rd data>nul
del grubfm-en_us.7z>nul
))
color 27
title GrubFM Installer: success
echo OK!
pause
exit /b
:er
color 47
title GrubFM Installer: error
echo RUNTIME ERROR!
pause
exit /b