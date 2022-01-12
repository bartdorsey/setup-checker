#!/bin/bash
source ./helpers/colors.sh
source ./helpers/utils.sh

DEBIAN_VERSION=$(lsb_release -r -s)

hr
title "Checking Debian"
hr
echo "Debian Version: $DEBIAN_VERSION"

print_json_line os_version $DEBIAN_VERSION >> report.json

# Check Linux
echo
$SHELL ./helpers/linux-checker.sh
