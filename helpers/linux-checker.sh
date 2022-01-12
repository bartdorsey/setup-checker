#!/bin/bash
source ./helpers/colors.sh
source ./helpers/utils.sh

ARCHITECTURE=$(uname -p)
echo "CPU Architecture: $ARCHITECTURE"

print_json_line arch $ARCHITECTURE >> report.json

# Check shell
echo
$SHELL ./helpers/shell-checker.sh
$SHELL ./helpers/node-checker.sh
$SHELL ./helpers/code-checker.sh
$SHELL ./helpers/postgres-checker.sh


