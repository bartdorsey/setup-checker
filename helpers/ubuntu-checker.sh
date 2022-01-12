#!/bin/bash
source ./helpers/colors.sh
source ./helpers/utils.sh

UBUNTU_VERSION=$(lsb_release -r -s)
IS_WINDOWS=$(which cmd.exe | grep -c -v 'not found' 2> /dev/null)

hr
title "Checking Ubuntu"
hr
echo "Ubuntu Version: $UBUNTU_VERSION"

print_json_line linux_version $UBUNTU_VERSION >> report.json
print_json_line linux_os "Ubuntu" >> report.json

# Check Linux
echo
$SHELL ./helpers/linux-checker.sh
# if [ $? -eq 1 ]; then
  # exit 1;
# fi
