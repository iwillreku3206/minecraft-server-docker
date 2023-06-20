#!/bin/bash

trap graceful_shutdown SIGINT SIGQUIT SIGTERM

# Set Java version (default: 8)

[[ $JAVA_VERSION = 17 ]] && JAVA_VERSION="17" || JAVA_VERSION="8"
echo Detected Java version $JAVA_VERSION

# Detect RAM allocation (default: 4GB)
# Format: {Amount}{M|G} (e.g. 4G = 4GB, 512M = 512MB)
# If invalid, set to 4GB

REGEX_RAM='^[0-9]+[MG]$'
OLD_RAM_ALLOCATION=$JAVA_MEMORY_ALLOCATION
[[ $JAVA_MEMORY_ALLOCATION =~ $REGEX_RAM ]] && JAVA_MEMORY_ALLOCATION=$JAVA_MEMORY_ALLOCATION || JAVA_MEMORY_ALLOCATION="4G"
[[ $JAVA_MEMORY_ALLOCATION != "" ]] && JAVA_MEMORY_ALLOCATION=$JAVA_MEMORY_ALLOCATION || JAVA_MEMORY_ALLOCATION="4G"
[[ $OLD_RAM_ALLOCATION != $JAVA_MEMORY_ALLOCATION ]] && [[ $OLD_RAM_ALLOCATION != "" ]] && echo "Invalid RAM allocation detected ($OLD_RAM_ALLOCATION), set to $JAVA_MEMORY_ALLOCATION"
echo Detected RAM allocation of $JAVA_MEMORY_ALLOCATION 

if [[ ! -f server.jar ]]; then
  echo "server.jar not found. Please ensure that the server jar is in the '/data' directory"
  exit 1
fi
echo "Starting server... To access console, run 'tmux attach -t console'"

export JAVA_VERSION
export JAVA_MEMORY_ALLOCATION
export NGROK_AUTHTOKEN
export NGROK_REGION
export NGROK_ENABLED


graceful_shutdown(){
  if [[ $NO_TMUX != "true" ]]; then
    tmux send-keys -t mcserver:console "stop" ENTER
  fi
  until [[ -e /tmp/SERVER_EXITED ]]; do
    sleep 1
  done
  exit
}

if [[ $NO_TMUX == "true" ]]; then 
  if [[ $NGROK_ENABLED = "true" ]]; then
    source /scripts/start_ngrok.sh &
  fi
  source /scripts/start_server.sh
else
  tmux new -d -s 'mcserver'
  tmux new-window -n 'console' '/bin/bash /scripts/start_server.sh'
  if [[ $NGROK_ENABLED = "true" ]]; then
    tmux new-window -n 'ngrok' '/bin/bash /scripts/start_ngrok.sh'
  fi
  while true
  do
    sleep 1
  done
fi
