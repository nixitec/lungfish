#!/bin/bash
COL_GREEN="\x1b[32;01m"
COL_BLUE="\x1b[34;01m"
COL_RESET="\x1b[39;49;00m"

MYPROJECT="nix"
MYPROJECT_ENV="nix_env"
MYDOMAIN="nixography.com"
USERNAME="ubuntu"

echo -e $COL_GREEN"Running Upgrade ..."$COL_RESET

sudo apt-get update
sudo apt-get upgrade


echo -e $COL_GREEN"Installing NGINX, GreenUnicorn and Flask ..."$COL_RESET

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
# sudo ufw status
# systemctl status nginx

echo -e $COL_GREEN"Installing Python3 dependencies..."$COL_RESET
sudo apt install python3-pip python3-dev build-essential libssl-dev libffi-dev python3-setuptools

echo -e $COL_GREEN"Installing Python venv ..."$COL_RESET
sudo apt install python3-venv
mkdir ~/$MYPROJECT
cd ~/$MYPROJECT
pwd

echo -e $COL_GREEN"Activating Python venv ..."$COL_RESET
sudo python3.6 -m venv $MYPROJECT_ENV
source ./$MYPROJECT_ENV/bin/activate

echo -e $COL_GREEN"Installing Wheel ..."$COL_RESET
sudo -H ./$MYPROJECT_ENV/bin/pip install wheel

echo -e $COL_GREEN"Installing Gunicorn and Flask ..."$COL_RESET
sudo -H ./$MYPROJECT_ENV/bin/pip install gunicorn flask

echo -e $COL_GREEN"Opening Port 5000 ..."$COL_RESET
sudo ufw allow 5000

echo -e $COL_GREEN"Creating $MYPROJECT.py ..."$COL_RESET  #Note: Use "..." and escape \ the " and not the '
> $MYPROJECT.py
echo -e "
from flask import Flask
app = Flask(__name__)

@app.route(\"/\")
def hello():
    return \"<h1 style='color:blue'>Hello There!</h1>\"

if __name__ == \"__main__\":
    app.run(host='0.0.0.0')
" > $MYPROJECT.py

echo -e $COL_GREEN"Creating wsgi.py ..."$COL_RESET
> wsgi.py
echo -e "
from $MYPROJECT import app

if __name__ == \"__main__\":
    app.run()
" > wsgi.py

# exit 1

# echo -e $COL_GREEN"Starting Gunicorn ..."$COL_RESET
# gunicorn --bind 0.0.0.0:5000 wsgi:app

echo -e $COL_GREEN"Deactivating Virtual Environment"$COL_RESET
deactivate

echo -e $COL_GREEN"Creating Unit file"$COL_RESET
sudo > $MYPROJECT.service.TEMP
sudo echo -e "
[Unit]
Description=Gunicorn instance to serve $MYPROJECT
After=network.target

[Service]
User=$USERNAME
Group=www-data
WorkingDirectory=/home/$USERNAME/$MYPROJECT
Environment="PATH=/home/$USERNAME/$MYPROJECT/$MYPROJECT_ENV/bin"
ExecStart=/home/$USERNAME/$MYPROJECT/$MYPROJECT_ENV/bin/gunicorn --workers 3 --bind unix:$MYPROJECT.sock -m 007 wsgi:app

[Install]
WantedBy=multi-user.target

" > $MYPROJECT.service.TEMP

sudo cp $MYPROJECT.service.TEMP /etc/systemd/system/$MYPROJECT.service
rm $MYPROJECT.service.TEMP

echo -e $COL_GREEN"Starting Gunicorn ..."$COL_RESET
sudo systemctl start $MYPROJECT

echo -e $COL_GREEN"Enabling Gunicorn ..."$COL_RESET
sudo systemctl enable $MYPROJECT

echo -e $COL_GREEN"Creating NGINX site file"$COL_RESET
sudo > $MYPROJECT.NGNX.TEMP
sudo echo -e "
server {
    listen 80;
    server_name $MYDOMAIN $MYDOMAIN.com;

    location / {
        include proxy_params;
        proxy_pass http://unix:/home/ubuntu/nix/nix.sock;
    }
}
" > $MYPROJECT.NGNX.TEMP

sudo cp $MYPROJECT.NGNX.TEMP /etc/nginx/sites-available/$MYPROJECT
rm $MYPROJECT.NGNX.TEMP

sudo ln -s /etc/nginx/sites-available/$MYPROJECT /etc/nginx/sites-enabled

sudo nginx -t

sudo systemctl restart nginx

echo
echo -e $COL_BLUE"NGINX Server should be started and ready to serve !"$COL_RESET
echo
echo -e $COL_GREEN"NGINX Securing $MYPROJECT ..."$COL_RESET
echo
sudo add-apt-repository ppa:certbot/certbot
sudo apt install python-certbot-nginx
sudo certbot --nginx -d $MYDOMAIN -d www.$MYDOMAIN
sudo ufw delete allow 'Nginx HTTP'


echo
echo -e $COL_BLUE"NGINX Tidying Up ... "$COL_RESET
rm -rf lungfish

echo -e $COL_BLUE"NGINX If you encounter any errors, trying checking the following: "$COL_RESET

echo sudo less /var/log/nginx/error.log: checks the Nginx error logs.
echo sudo less /var/log/nginx/access.log: checks the Nginx access logs.
echo sudo journalctl -u nginx: checks the Nginx process logs.
echo sudo journalctl -u myproject: checks your Flask app’s Gunicorn logs.
