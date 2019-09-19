#!/bin/bash
COL_GREEN="\x1b[32;01m"
COL_RESET="\x1b[39;49;00m"

MYPROJECT="nixography"
MYPROJECT_ENV="nixographyenv"

# Create a new user
# echo -e "Please enter the new user name: "
# read name
# adduser $name                   # Add the new user
# usermod -aG sudo $name          # Add the user to the sudo group
# echo "User $name added !"

echo -e $COL_GREEN"Installing NGINX ..."$COL_RESET
sudo apt install nginx

echo -e $COL_GREEN"Enabling Firewall ..."$COL_RESET
sudo ufw enable
sudo ufw app list
sudo ufw allow 'Nginx HTTP'
sudo ufw allow 'OpenSSH'
sudo ufw status
systemctl status nginx

echo -e $COL_GREEN"Installing Python ..."$COL_RESET
sudo apt install python3-pip python3-dev build-essential libssl-dev libffi-dev python3-setuptools

echo -e $COL_GREEN"Creating Python venv ..."$COL_RESET
sudo apt install python3-venv
mkdir ~/$MYPROJECT
cd ~/$MYPROJECT
python3.6 -m venv $MYPROJECT_ENV
source $MYPROJECT_ENV/bin/activate
pip install wheel
pip install gunicorn flask
