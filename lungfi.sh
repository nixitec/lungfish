#!/bin/bash
COL_GREEN="\x1b[32;01m"
COL_RESET="\x1b[39;49;00m"

MYPROJECT="nixography"
MYPROJECT_ENV="nix_env"

echo -e $COL_GREEN"Installing NGINX, GreenUnicorn and Flask ..."$COL_RESET

# Create a new user
# echo -e "Please enter the new user name: "
# read name
# adduser $name                   # Add the new user
# usermod -aG sudo $name          # Add the user to the sudo group
# echo "User $name added !"

echo -e $COL_GREEN"Installing NGINX ..."$COL_RESET
echo -e "Enter to continue: "
# read ok
sudo apt install nginx

echo -e $COL_GREEN"Enabling Firewall ..."$COL_RESET
echo -e "Enter to continue: "
#read ok
sudo ufw enable
sudo ufw app list
sudo ufw allow 'Nginx HTTP'
sudo ufw allow 'OpenSSH'
# sudo ufw status
# systemctl status nginx

echo -e $COL_GREEN"Installing Python3 dependencies..."$COL_RESET
echo -e "Enter to continue: "
#read ok
sudo apt install python3-pip python3-dev build-essential libssl-dev libffi-dev python3-setuptools

echo -e $COL_GREEN"Installing Python venv ..."$COL_RESET
echo -e "Enter to continue: "
#read ok
sudo apt install python3-venv
mkdir ~/$MYPROJECT
cd ~/$MYPROJECT
pwd

echo -e $COL_GREEN"Activating Python venv ..."$COL_RESET
echo -e "Enter to continue: "
#read ok
sudo python3.6 -m venv $MYPROJECT_ENV
source ./$MYPROJECT_ENV/bin/activate

echo -e $COL_GREEN"Installing Wheel ..."$COL_RESET
echo -e "Enter to continue: "
#read ok
sudo -H ./$MYPROJECT_ENV/bin/pip install wheel

echo -e $COL_GREEN"Installing Gunicorn and Flask ..."$COL_RESET
echo -e "Enter to continue: "
# read ok
sudo -H ./$MYPROJECT_ENV/bin/pip install gunicorn flask

echo -e $COL_GREEN"Opening Port 5000 ..."$COL_RESET
sudo ufw allow 5000

echo -e $COL_GREEN"Installing Creating myproject.py ..."$COL_RESET
> myproject.py
echo -e '
from flask import Flask
app = Flask(__name__)

@app.route(\"/\")
def hello():
    return \"<h1 style=\'color:blue\'>Hello There!</h1>\"

if __name__ == \"__main__\":
    app.run(host=\'0.0.0.0\')
' > myproject.py

echo -e $COL_GREEN"Creating wsgi.py ..."$COL_RESET
> wsgi.py
echo -e '
from myproject import app

if __name__ == \"__main__\":
    app.run()
' > wsgi.py

echo -e $COL_GREEN"Starting Gunicorn ..."$COL_RESET
gunicorn --bind 0.0.0.0:5000 wsgi:app
