# lungfish
Linux Ubuntu Nginx Gunicorn Flask Instance SHell

### Preperation:
1. Install Lightsail Instance
2. In Lightsail
    - Attach Static IP
    - Create DNS Zone
        - Create A records for @ and www
        - Take note of Name Servers (4)
        - Open the HTTPS port in networking
3. In Route 53 (or other Register)
    - Register Domain
    - Enter Static IP from Lightsail
    - Change Name Servers to those noted from Lightsail
4. Wait !!! (it takes time - anywhere from 5 mins to 48 hours)
    - You can do the installation while you are waiting

### Installation
1. Clone this repository
```
git clone https://github.com/nixitec/lungfish.git
```
1. Run ./lungfi.sh
```
chmod +x ./lungfish/lungfi.sh
bash -x ./lungfish/lungfi.sh

Also:
- Link static ip address
- Open HTTPS port
```
1. Update https 'txt' certificates per
```
https://lightsail.aws.amazon.com/ls/docs/en_us/articles/amazon-lightsail-using-lets-encrypt-certificates-with-nginx
```
1. Remove lungfish
```
sudo rm -rfv lungfish
```



### lungfi.sh will:
1. Create a new user
1. Install Cloud9

### This script was created based on these excellent articles and links:
- https://www.digitalocean.com/community/tutorials/how-to-serve-flask-applications-with-gunicorn-and-nginx-on-ubuntu-18-04
- https://lightsail.aws.amazon.com/ls/docs/en_us/articles/amazon-lightsail-using-lets-encrypt-certificates-with-nginx

### The following commands may be useful:
- tail -f /var/log/nginx/access.log | less -S: lists the last 10 records and updates new records
- 
- sudo less /var/log/nginx/error.log: checks the Nginx error logs.
- sudo less /var/log/nginx/access.log: checks the Nginx access logs.
- sudo journalctl -u nginx: checks the Nginx process logs.
- sudo journalctl -u myproject: checks your Flask app’s Gunicorn logs.


### The following files may be useful:
- /var/log/nginx/access.log
- /etc/nginx/sutes-enabled/nix
- /etc/letsencrypt/live/nixography.com/fullchail.pem
- /etc/letsencrypt/live/nixography.com/privkey.pem
- /etc/letsencrypy/options-ssl-nginx.conf
- /etc/letsencrypt/ssl-dhparams.pem

