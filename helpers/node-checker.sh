#!/bin/bash
source ./helpers/utils.sh
source ./helpers/colors.sh

LTS_NODE_VERSION=16

NODE=$(which node)
NODE_IS_FROM_NVM=$(echo "$NODE" | grep -c "nvm")
NODE_VERSION=$($NODE --version)
NODE_IS_LTS=$(echo "$NODE_VERSION" | grep -c $LTS_NODE_VERSION)
NPM=$(which npm)
NPM_VERSION=$($NPM --version)
NVM_COMMAND="curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash"
NVM_IN_SHELL_STARTUP_FILE=$(grep -ic 'nvm.sh' < "$(shell_startup_file)")
NVM_LINES="export NVM_DIR="$HOME/.nvm"\n[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm"
NODE_ARCH=$($NODE ./helpers/node-arch-check.js)
ESLINT=$(which eslint)
ESLINT_VERSION=$(eslint --version 2> /dev/null)

# Start up nvm so we can check it.
# shellcheck disable=SC1091
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

hr
c_cyan "Checking Node.JS"
hr
echo "Node Path: ${NODE}"
echo "Node Architecture: ${NODE_ARCH}"
echo "Node Version: ${NODE_VERSION}"
echo "NPM Path: ${NPM}"
echo "NPM Version: ${NPM_VERSION}"
echo "ESLint Version: ${ESLINT_VERSION}"
echo "ESLint Path: ${ESLINT}"

print_json_line node_version $NODE_VERSION >> report.json
print_json_line node_path $NODE >> report.json

if [ "${NVM_IN_SHELL_STARTUP_FILE}" = 0 ]; then
    c_yellow "nvm does not appear to be initialized in your"
    c_yellow "shell startup file: $(shell_startup_file)"
    c_yellow "You should check to make sure these lines exist in that file:"
    echo
    echo "$NVM_LINES"
    echo
fi

if [ ! -d ~/.nvm ]; then
    c_red "NVM isn't installed into your home directory"
    c_red "Please run this command to install it"
    echo
    f_bold "$NVM_COMMAND"
    # exit 1;
fi

if [ -z "$NVM_DIR" ]; then
    c_red "NVM isn't initialized properly"
    c_red "Please check your startup files for the correct NVM startup lines"
    echo
    f_bold "$NVM_LINES"
    # exit 1;
fi

# Check node and version
if [ -z "$NODE" ]; then
    c_red "Couldn't find the node binary in your PATH. Check to make sure NVM"
    c_red "is setup correctly"
    echo
    f_bold "You might want to restart your terminal"
    f_bold "Or you might need to install node with this command:"
    echo 
    f_bold "nvm install $LTS_NODE_VERSION"
    # exit 1;
fi

if [ "$NODE_IS_FROM_NVM" != 1 ]; then
    c_red "Your node version isn't coming from NVM"
    c_red "Check to make sure you don't have node installed globally"
    c_red "somewhere in your PATH"
    c_red "Node binary = ${NODE}"
    # exit 1;
fi

if [ "$NODE_IS_LTS" != 1 ]; then
    c_red "You aren't running Node.JS ${LTS_NODE_VERSION}"
    c_red "Please use nvm to update to version ${LTS_NODE_VERSION}"
    c_red "Run 'nvm install ${LTS_NODE_VERSION}"
    c_red "Followed by 'nvm alias default ${LTS_NODE_VERSION}'"
    # exit 1;
fi

if [ -z "$ESLINT" ] || [ "$ESLINT" = "eslint not found" ]; then
    c_red "Couldn't find eslint in your PATH. Check to make sure it is"
    c_red "installed globally."
    echo
    c_red "Run 'npm install -g eslint' to install."
    # exit 1;
fi

c_green "Node.JS is OK"
