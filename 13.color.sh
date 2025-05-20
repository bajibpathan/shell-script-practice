#!/bin/bash

USERID=$(id -u)
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
NOCOLOR="\e[0m"

if [ $USERID -ne 0 ]
then
    echo -e "$RED ERROR:: Please run this script with root access $NOCOLOR"
    exit 1
else
    echo "You are running with root access"
fi
########################
# Funtion: Validation
# Purpose: Validate if the given package is installed or not
# Argument: Exit status & Package name
########################
VALIDATE(){
    if [ $? -eq 0 ]
    then
        echo -e "Installing $2 is ... $GREEN SUCCESS $NOCOLOR"
    else
        echo -e "Installing $2 is ...$RED FAILURE $NOCOLOR"
        exit 1
    fi
}
########################

dnf list installed mysql
if [ $? -ne 0 ]
then   
    echo "MySQL is not installed.. going to install"
    
    dnf install mysql -y
    VALIDATE $? "MySQL"
else
    echo -e "Nothing to do MySQL... $YELLOW already installed... $NOCOLOR"
   
fi

dnf list installed python3
if [ $? -ne 0 ]
then   
    echo "Python3 is not installed.. going to install"
    
    dnf install python3 -y
    VALIDATE $? "Python3"
else
     echo -e "Nothing to do Python3... $YELLOW already installed... $NOCOLOR"
fi

dnf list installed nginx
if [ $? -ne 0 ]
then   
    echo "Nginx is not installed.. going to install"
    
    dnf install nginx -y
    VALIDATE $? "Nginx"
else
     echo -e "Nothing to do NGINX... $YELLOW already installed... $NOCOLOR"
fi