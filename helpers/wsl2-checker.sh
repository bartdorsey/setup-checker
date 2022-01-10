#!/bin/bash
source ./helpers/colors.sh
WSL=$(which wsl.exe)
WINDOWS_NAME=$(systeminfo.exe | findstr.exe /B /C:"OS Name")
WINDOWS_VERSION=$(systeminfo.exe | findstr.exe /B /C:"OS Version")
WINDOWS_BUILD=$(echo $WINDOWS_VERSION | tr -d '\0\r' | awk '{print $6}')
WSL_VERSION=$(wsl.exe --status | tr -d '\0\r'|grep "Default Version"| awk '{print $3}')

MINIMUM_WINDOWS_BUILD_VERSION=19043

hr
title "Checking WSL"
hr
echo $WINDOWS_NAME
echo $WINDOWS_VERSION
echo "Windows Build: $WINDOWS_BUILD"
echo "WSL Version: $WSL_VERSION"

# if [ $WINDOWS_BUILD -lt $MINIMUM_WINDOWS_BUILD_VERSION ]; then
#     c_red "Your Windows 10 build version isn't high enough"
#     c_red "Please run Windows update and update to at least build $MINIMUM_WINDOWS_BUILD_VERSION"
#     exit 1;
# fi

if [ -z "$WSL" ]; then
    c_red "WSL doesn't appear to be installed."
    # exit 1;
fi

if [ "$WSL_VERSION" != "2" ]; then
    c_red "WSL is not version 2."
    c_red "It is highly recommended you use WSL 2"
    c_red "Please run 'wsl --set-version Ubuntu 2' from Powershell"
    c_red "To convert your Ubuntu to WSL 2"
    # exit 1;
fi

c_green "WSL is OK"