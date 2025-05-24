#!/bin/bash

USER_ID=$(id -u) 
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
NOCOLOR="\e[0m"
LOGS_FOLDER="/var/log/shellscript-logs"
SCRIPT_NAME=$(echo $0 | awk -F ".sh" '{print $1}')
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"
SOURCE_DIR="/home/ec2-user/app-logs"

mkdir -p $LOGS_FOLDER

if [ $USER_ID -ne 0 ]
then
    echo -e "$RED ERROR:: Please run this script with root access $NOCOLOR" | tee -a $LOG_FILE
    exit 1
else
    echo -e "$GREEN You are running with root access $NOCOLOR" | tee -a $LOG_FILE
fi
########################
# Funtion: Validation
# Purpose: Validate if the given package is installed or not
# Argument: Exit status & Package name
########################
VALIDATE(){
    if [ $? -eq 0 ]
    then
        echo -e "$2 is ... $GREEN SUCCESS $NOCOLOR" | tee -a $LOG_FILE
    else
        echo -e "$2 is ...$RED FAILURE $NCOLOR" | tee -a $LOG_FILE
        exit 1
    fi
}



echo "Script scarted executing at $(date)" | tee -a $LOG_FILE
FILES_TO_DELETE=$(find $SOURCE_DIR -name "*.log" -mtime +14)

while IFS= read -r filepath
do  
    echo "Deleting file: $filepath" | tee -a $LOG_FILE
    rm -rf $filepath
    VALIDATE $? "Deleted the file: $filepath"
done <<< $FILES_TO_DELETE

echo -e "Script executed $GREEN successfully $NOCOLOR"