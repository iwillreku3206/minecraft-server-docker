#!/bin/bash

figlet -w 120 "Minecraft Server"
echo "This is the Minecraft server Docker container"
echo "To access the console, run 'tmux attach -t mcserver:console'"
echo "To detach from the console, press 'Ctrl + B' then 'D'"

if [[ $NGROK_ENABLED = "true" ]]; then
  echo "Ngrok is enabled. To access the Ngrok console, run 'tmux attach -t mcserver:ngrok'"
fi
