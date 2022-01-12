#!/bin/bash
source ./helpers/colors.sh
source ./helpers/utils.sh
MACOS_VERSION=$(sw_vers -productVersion)
CURRENT_ARCH=$(uname -m)
IS_ROSETTA="$(sysctl -in sysctl.proc_translated)"

hr
title "Checking macOS"
hr
echo "macOS Version: $MACOS_VERSION"
echo "Current Architecture: $CURRENT_ARCH"

print_json_line os_version $MACOS_VERSION >> report.json
print_json_line arch $CURRENT_ARCH >> report.json

if [ "$IS_ROSETTA" = "1" ]; then
c_yellow "Warning: You are running under a Rosetta Termninal,"
c_yellow "you should switch back to the native terminal if possible"
fi

$SHELL ./helpers/shell-checker.sh
$SHELL ./helpers/node-checker.sh
$SHELL ./helpers/code-checker.sh
$SHELL ./helpers/postgres-checker.sh
