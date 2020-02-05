#!/bin/bash

# Create table and insert data into the DB if it doesn't exist
echo "$DB_HOSTNAME:$DB_PORT:$DB_DATABASE:$DB_USERNAME:$DB_PASSWORD" > ~/.pgpass; chmod 600 ~/.pgpass
psql -h $DB_HOSTNAME -U $DB_USERNAME -d $DB_DATABASE -f psql-database.sql

# Start the first process
python portal.py &
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start my_first_process: $status"
  exit $status
fi

# Start the second process
python hardware.py &
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start my_second_process: $status"
  exit $status
fi

while sleep 600; do
  ps aux |grep portal.py |grep -q -v grep
  PROCESS_1_STATUS=$?
  ps aux |grep hardware.py |grep -q -v grep
  PROCESS_2_STATUS=$?
  # If the greps above find anything, they exit with 0 status
  # If they are not both 0, then something is wrong
  if [ $PROCESS_1_STATUS -ne 0 -o $PROCESS_2_STATUS -ne 0 ]; then
    echo "One of the processes has already exited."
    exit 1
  fi
done
