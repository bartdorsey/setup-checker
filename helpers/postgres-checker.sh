#!/bin/bash
source ./helpers/utils.sh
# shellcheck disable=SC1090
source "$(shell_startup_file)" > /dev/null 2>&1
source ./helpers/colors.sh

hr
title "Checking PostgreSQL"
hr

POSTGRES_RESPONDING=$(nc -vz 127.0.0.1 5432 2>&1 | grep -c succeeded)
POSTGRES_RUNNING=$(pgrep postgres | wc -l)
PSQL="$(which psql)"
PSQL_VERSION=$(psql --version)
QUERY="$(echo "SELECT 1+1;" | psql 2>&1)"
CANT_RUN_QUERIES="$(echo "${QUERY}" | grep -c FATAL)"
NO_DATABASE="$(echo ${QUERY} | grep -c "database.*does not exist")"


if [ -z "$PSQL" ]; then
     c_red "You don't appear to have the psql command line installed"
     c_red "Please install postgres"
     exit 1;
fi

echo "PostgreSQL Version: ${PSQL_VERSION}"
echo "psql path: ${PSQL}"
hr
echo "Environment Variables"
hr
echo "PGHOST: ${PGHOST}"
echo "PGUSER: ${PGUSER}"
echo "PGPORT: ${PGPOST}"
echo "PGDATABASE: ${PGDATABASE}"


if [ "$POSTGRES_RUNNING" = 0 ]; then
     c_yellow "Your postgreSQL server isn't showing up in the process list"
     c_yellow "This could be because it's running in a virtual machine or docker"
     c_yellow "container, but if it isn't you should probably check it"
fi

if [ "$POSTGRES_RESPONDING" = 0 ]; then
     c_red "Your PostgreSQL server does not appear to be available on localhost at port 5432"
     c_red "Please start it or check that it's listening on port 5432"
     exit 1;
fi

if [ "$NO_DATABASE" -ge 1 ]; then
     c_red "Your default database doesn't exist"
     c_red "Either change your PGUSER variable to match"
     c_red "Set PGDATBASE or create the database using 'createdb'"
     echo
     c_red "$QUERY"
     exit 1;
fi

if [ "$CANT_RUN_QUERIES" -ge 1 ]; then
     c_red "Can't run queries against the PostgreSQL database without supplying"
     c_red "a username and password. Try configuring the environment vairables PGUSER, PGHOST or a .pgpass file"
     echo
     c_red "$QUERY"
     exit 1;
fi

DATABASES="$(echo "\l" | psql 2>&1)"
DATADIRECTORY="$(printf "show data_directory;" | psql -t 2>/dev/null)"
PORT=$(echo "show port;" | psql -t 2>/dev/null);

hr
echo "From Configuration:"
hr
echo "Data Directory: ${DATADIRECTORY}"
echo "Port: ${PORT}"
hr
echo "$DATABASES"
hr

c_green "PostgreSQL is OK"