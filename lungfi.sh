#!/bin/bash
COL_BLUE="\x1b[32;01m"
COL_RESET="\x1b[39;49;00m"

# Create a new user
# echo -e "Please enter the new user name: "
# read name
# adduser $name                   # Add the new user
# usermod -aG sudo $name          # Add the user to the sudo group
# echo "User $name added !"

echo -e $COL_BLUE"Important Message: "$COL_RESET"This is a message"

sudo apt install nginx
sudo ufw enable
sudo ufw app list
sudo ufw allow 'Nginx HTTP'
sudo ufw allow 'OpenSSH'
sudo ufw status
systemctl status nginx

