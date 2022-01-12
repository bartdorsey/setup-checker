#!/bin/bash
source ./helpers/colors.sh
source ./helpers/utils.sh

echo "{" > report.json

echo "Enter your email address and press enter:"
read EMAIL

print_json_line email $EMAIL >> report.json

IS_MACOS=$(uname -a | awk '{ print $1 }' | grep -c Darwin 2> /dev/null)
IS_WINDOWS=$(which cmd.exe | grep -c -v 'not found' 2> /dev/null)
LSB_RELEASE=$(which lsb_release | grep -c -v 'not found' 2> /dev/null)
if [ "$LSB_RELEASE" = 1 ]; then
    IS_UBUNTU=$(lsb_release -s -i | grep -c "Ubuntu" 2> /dev/null)
    IS_DEBIAN=$(lsb_release -s -i | grep -c "Debian" 2> /dev/null)
    IS_RASPBIAN=$(lsb_release -s -i | grep -c "Raspbian" 2> /dev/null)
fi

success() {
    hr
    c_green "Congratulations, you have everything installed properly!"
    hr
}

if [ "$IS_MACOS" = 1 ]; then
    print_json_line os macOS >> report.json
    $SHELL -l ./helpers/macos-checker.sh
elif [ "$IS_WINDOWS" = 1 ]; then
    print_json_line os Windows >> report.json
    $SHELL -l ./helpers/windows-checker.sh   
elif [ "$IS_UBUNTU" = 1 ]; then
    print_json_line os Ubuntu >> report.json
    $SHELL ./helpers/ubuntu-checker.sh
elif [ "$IS_DEBIAN" = 1 ]; then
    print_json_line os Debian >> report.json
    $SHELL ./helpers/debian-checker.sh
elif [ "$IS_RASPBIAN" = 1 ]; then
    print_json_line os Raspbian >> report.json
    $SHELL ./helpers/raspbian-checker.sh
elif [ -e /etc/fedora-release ]; then
    print_json_line os Fedora >> report.json
    $SHELL ./helpers/fedora-checker.sh
else
    c_red "Unknown Operating System, checker script not supported"
fi

echo "}" >> report.json

curl -X POST -H "Content-Type: application/json" -d "@report.json" https://setup-collector.herokuapp.com/report
