#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]
then
    echo "ERROR:: Please run this script with root access"
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
        echo "Installing $2 is ... SUCCESS"
    else
        echo "Installing $2 is ...FAILURE"
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
    echo "MySQL is already installed... Nothing to do"
   
fi

dnf list installed python3
if [ $? -ne 0 ]
then   
    echo "Python3 is not installed.. going to install"
    
    dnf install python3 -y
    VALIDATE $? "Python3"
else
    echo "Python3 is already installed... Nothing to do"
fi

dnf list installed nginx
if [ $? -ne 0 ]
then   
    echo "Nginx is not installed.. going to install"
    
    dnf install nginx -y
    VALIDATE $? "Nginx"
else
    echo "Nginx is already installed... Nothing to do"
fi