#!/bin/bash
source ./helpers/colors.sh
source ./helpers/utils.sh

FEDORA_VERSION=$(cat /etc/fedora-release)

hr
title "Checking Fedora"
hr
echo "Debian Version: $FEDORA_VERSION"

print_json_line linux_version $FEDORA_VERSION >> report.json
print_json_line linux_os "Fedora" >> report.json

# Check Linux
echo
$SHELL ./helpers/linux-checker.sh
