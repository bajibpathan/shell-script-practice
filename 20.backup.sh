#!/bin/bash

USER_ID=$(id -u) 
SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14} #Default values 14 days 'Syntax {:-}'

LOGS_FOLDER="/var/log/shellscript-logs"
SCRIPT_NAME=$(echo $0 | awk -F ".sh" '{print $1}')
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
NOCOLOR="\e[0m"

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

USAGE(){
  echo -e "$RED USAGE:: $NCOLOR sh $0 <source-dir> <destination_dir> [days(optional)]"  
}

CHECK_DIR(){
    if [ ! -d $2 ]
    then
        echo -e "$RED $1 directory <<$2>> does not exist. Please check $NOCOLOR"
        exit 1
    fi
}

if [ $# -lt 2 ]
then
    USAGE
fi

CHECK_DIR "Source" $SOURCE_DIR
CHECK_DIR "Desitnation" $DEST_DIR

FILES=$(find $SOURCE_DIR -name "*.log" -mtime +$DAYS)

if [ ! -z $FILES ]
then
    echo "Files to zip $FILES"
    TIMESTAMP=$(date +%F-%H-%M-%S)
    ZIP_FILE="${DEST_DIR}/app-logs-${TIMESTAMP}.zip"
    echo $FILES | zip -@ $ZIP_FILE
    
    if [ -f $ZIP_FILE ]
    then
        echo -e "Created zip file ... $GREEN SUCCESS $NOCOLOR"
        while IFS= read -r filepath
        do 
            echo "Deleting file: $filepath" | tee - a $LOG_FILE
            rm -rf $filepath
        done <<< $FILES

        echo -e "Log files older than $DAYS days from source directory removed ... $GREEN SUCCESS $NOCOLOR"

    else
        echo -e "Zip file creation ... $RED FAILURE $NOCOLOR"
        exit 1
    fi
else
    echo -e "No log files found older than $DAYS days in the $SOURCE directory... $YELLOW SKIPPING $NOCOLOR"
fi