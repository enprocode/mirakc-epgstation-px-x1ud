#!/bin/bash

function trap_exit() {
  echo "Stopping... $(jobs -p)"
  kill $(jobs -p) > /dev/null 2>&1 || echo "Already killed."
  if [ -e "/etc/init.d/pcscd" ]; then
    /etc/init.d/pcscd stop
  fi
  sleep 1
  echo "Exit."
}

trap "exit 0" 2 3 15
trap trap_exit 0

if [ -e "/etc/init.d/pcscd" ]; then
  while true; do
    echo "Starting pcscd..."
    /etc/init.d/pcscd start
    sleep 1
    if timeout 2 pcsc_scan | grep -A 50 "Using reader plug'n play mechanism"; then
      echo "pcscd started successfully."
      break
    else
      echo "Failed to start pcscd, retrying..."
    fi
    sleep 5
  done
fi

echo "mirack Start!"
/usr/local/bin/mirakc --config /etc/mirakc/config.yml
