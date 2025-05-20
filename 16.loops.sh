#!/bin/bash

USERID=$(id -u)
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
NOCOLOR="\e[0m"
LOGS_FOLDER="/var/log/shellscript-logs"
SCRIPT_NAME=$(echo $0 | cut -d ":" -f1)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"
PACKAGES=("mysql" "python3" "nginx")

mkdir -p $LOGS_FOLDER
echo "Script started executing: $(date)" | tee -a $LOG_FILE


if [ $USERID -ne 0 ]
then
    echo -e "$RED ERROR:: Please run this script with root access $NOCOLOR" | tee -a $LOG_FILE
    exit 1
else
    echo "You are running with root access"  | tee -a $LOG_FILE
fi
########################
# Funtion: Validation
# Purpose: Validate if the given package is installed or not
# Argument: Exit status & Package name
########################
VALIDATE(){
    if [ $? -eq 0 ]
    then
        echo -e "Installing $2 is ... $GREEN SUCCESS $NOCOLOR"  | tee -a $LOG_FILE
    else
        echo -e "Installing $2 is ...$RED FAILURE $NOCOLOR"  | tee -a $LOG_FILE
        exit 1
    fi
}


########################
for package in ${PACKAGES[@]}
do
    dnf list installed $package &>>$LOG_FILE
    if [ $? -ne 0 ]
    then   
        echo "$package is not installed.. going to install"  | tee -a $LOG_FILE
        
        dnf install $package -y  &>>$LOG_FILE
        VALIDATE $? "$package"
    else
        echo -e "Nothing to do MySQL... $YELLOW already installed... $NOCOLOR"  | tee -a $LOG_FILE
    fi
done


# dnf list installed mysql  &>>$LOG_FILE
# if [ $? -ne 0 ]
# then   
#     echo "MySQL is not installed.. going to install"  | tee -a $LOG_FILE
    
#     dnf install mysql -y  &>>$LOG_FILE
#     VALIDATE $? "MySQL"
# else
#     echo -e "Nothing to do MySQL... $YELLOW already installed... $NOCOLOR"  | tee -a $LOG_FILE
   
# fi

# dnf list installed python3  &>>$LOG_FILE
# if [ $? -ne 0 ]
# then   
#     echo "Python3 is not installed.. going to install"  | tee -a $LOG_FILE
    
#     dnf install python3 -y  &>>$LOG_FILE
#     VALIDATE $? "Python3"
# else
#      echo -e "Nothing to do Python3... $YELLOW already installed... $NOCOLOR"  | tee -a $LOG_FILE
# fi

# dnf list installed nginx  &>>$LOG_FILE
# if [ $? -ne 0 ]
# then   
#     echo "Nginx is not installed.. going to install"  | tee -a $LOG_FILE
    
#     dnf install nginx -y  &>>$LOG_FILE
#     VALIDATE $? "Nginx" 
# else
#      echo -e "Nothing to do NGINX... $YELLOW already installed... $NOCOLOR" | tee -a $LOG_FILE
# fi