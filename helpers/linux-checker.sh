source ./helpers/colors.sh

ARCHITECTURE=$(uname -p)
echo "CPU Architecture: $ARCHITECTURE"

# Check shell
echo
$SHELL ./helpers/shell-checker.sh
if [ $? -eq 1 ]; then
  exit 1;
fi

# Check for Docker
echo
$SHELL ./helpers/node-checker.sh
if [ $? -eq 1 ]; then
    exit 1
fi
echo
$SHELL ./helpers/code-checker.sh
if [ $? -eq 1 ]; then
    exit 1
fi
echo
$SHELL ./helpers/postgres-checker.sh
if [ $? -eq 1 ]; then
    exit 1
fi
echo


