#!/bin/bash
source ./helpers/colors.sh
source ./helpers/utils.sh

RASPBIAN_VERSION=$(lsb_release -r -s)

hr
title "Checking Raspbian"
hr
echo "Raspbian Version: $RASPBIAN_VERSION"

print_json_line linux_version $RASPBIAN_VERSION >> report.json
print_json_line linux_os "Raspbian" >> report.json

# Check Linux
echo
$SHELL ./helpers/linux-checker.sh
# if [ $? -eq 1 ]; then
  # exit 1;
# fi
