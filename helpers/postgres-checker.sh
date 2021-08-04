source ./helpers/utils.sh
source $(shell_startup_file) > /dev/null 2>&1
source ./helpers/colors.sh

hr
title "Checking PostgreSQL"
hr

POSTGRES_RESPONDING=$(nc 127.0.0.1 5432)
POSTGRES_RUNNING=$(ps aux | grep bin/postgres | grep -v grep | wc -l)
PSQL_VERSION=$(psql --version)

echo "psql Version: ${PSQL_VERSION}"

if [ -z $POSTGRES_RESPONDING ]; then
     echo "Your PostgreSQL server appears to be running on port 5432"
fi

