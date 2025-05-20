#!/bin/bash

echo "All variables passed to the script: $@"
echo "Number of variables passed to the script: $#"
echo "Script name: $0"
echo "Current working directory: $PWD"
echo "User running the script: $USER"
echo "Home directory of the current user: $HOME"
echo "PID of the script: $$"
sleep 10&
echo "PID of the last command in background: $!"
