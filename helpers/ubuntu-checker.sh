#!/bin/bash
source ./helpers/colors.sh
source ./helpers/utils.sh

UBUNTU_VERSION=$(lsb_release -r -s)

hr
title "Checking Ubuntu"
hr
echo "Ubuntu Version: $UBUNTU_VERSION"

print_json_line os_version $UBUNTU_VERSION >> report.json

# Check Linux
echo
$SHELL ./helpers/linux-checker.sh
# if [ $? -eq 1 ]; then
  # exit 1;
# fi
