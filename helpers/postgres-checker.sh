#!/bin/bash
source ./helpers/utils.sh
# shellcheck disable=SC1090
source "$(shell_startup_file)" > /dev/null 2>&1
source ./helpers/colors.sh

hr
title "Checking PostgreSQL"
hr

POSTGRES_RESPONDING=$(nc -vz 127.0.0.1 5432 2>&1 | grep -c succeeded)
POSTGRES_RUNNING=$(pgrep -c postgres)
PSQL="$(which psql)"
PSQL_VERSION=$(psql --version)

if [ -z "$PSQL" ]; then
     c_red "You don't appear to have the psql command line installed"
     c_red "Please install postgres"
     exit 1;
fi

c_green "PostgreSQL Version: ${PSQL_VERSION}"
c_green "psql path: ${PSQL}"

if [ "$POSTGRES_RUNNING" = 0 ]; then
     c_yellow "Your postgreSQL server isn't showing up in the process list"
     c_yellow "This could be because it's running in a virtual machine or docker"
     c_yellow "container, but if it isn't you should probably check it"
fi

if [ "$POSTGRES_RESPONDING" -ge 1 ]; then
     echo "Your PostgreSQL server appears to be available on localhost at port 5432"
fi

if [ "$POSTGRES_RESPONDING" = 0 ]; then
     c_red "Your PostgreSQL server does not appear to be available on localhost at port 5432"
     c_red "Please start it or check that it's listening on port 5432"
     exit 1;
fi

c_green "PostgreSQL is OK"