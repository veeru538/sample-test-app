#!/bin/bash

# Start the rest process
#/usr/local/bin/python3 -m http.server 4040  -d /opt/api  ;  /usr/local/bin/python3 -m http.server 6050  -d /opt/soap
/usr/local/bin/python3 -m http.server 4040  -d /opt/api &
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start rest: $status"
  exit $status
fi

# Start the soap process
python3 -m http.server 6050  -d /opt/soap &
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start soap: $status"
  exit $status
fi

# Start the soap process
python3 -m http.server 5058   -d /opt/health &
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start health : $status"
  exit $status
fi



while sleep 5; do
  ps aux |grep api |grep -q -v grep
  PROCESS_1_STATUS=$?
  ps aux |grep soap |grep -q -v grep
  PROCESS_2_STATUS=$?
  ps aux |grep  health|grep -q -v grep
  PROCESS_3_STATUS=$?
#  if [ $PROCESS_1_STATUS -ne 0 ]; then
#  if [ $PROCESS_1_STATUS -ne 0 -o $PROCESS_2_STATUS -ne 0 ]; then
  if [ $PROCESS_1_STATUS -ne 0 -o $PROCESS_2_STATUS -ne 0 -o $PROCESS_3_STATUS -ne 0 ]; then
    echo "One of the processes has already exited."
    exit 1
  fi
done

