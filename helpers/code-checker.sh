#!/bin/bash
source ./helpers/colors.sh
source ./helpers/utils.sh

CODE=$(which code)
CODE_VERSION=$(code --version | head -n 1)

hr
title "Checking VSCode"
hr
echo "Code Binary: ${CODE}"
echo "Version: ${CODE_VERSION}"

if [ -z "$CODE" ] || [ "$CODE" = "code not found" ]; then
    c_red "You don't have Visual Studio Code installed properly"
    c_red "Please reinstall it"
    print_json_line vscode false >> report.json;
else 
    print_json_line vscode true >> report.json;
fi

c_green "VSCode is OK"
