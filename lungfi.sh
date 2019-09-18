#!/bin/bash
# Create a new user
echo -e "Please enter the new user name: "
read name
adduser $name                   # Add the new user
usermod -aG sudo $name          # Add the user to the sudo group
echo "Finished adding user $name"
