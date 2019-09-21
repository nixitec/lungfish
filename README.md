# lungfish
Linux Ubuntu Nginx Gunicorn Flask Instance SHell

### Preperation:
1. Install Lightsail Instance

2. Clone this repository
```
git clone https://github.com/nixitec/lungfish.git
```
3. Run ./lungfi.sh
```
chmod +x ./lungfish/lungfi.sh
bash -x ./lungfish/lungfi.sh
```
4. Link static ip address
5. Update https 'txt' certificates per
```
https://lightsail.aws.amazon.com/ls/docs/en_us/articles/amazon-lightsail-using-lets-encrypt-certificates-with-nginx
```
4. Remove lungfish
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
- sudo less /var/log/nginx/error.log: checks the Nginx error logs.
- sudo less /var/log/nginx/access.log: checks the Nginx access logs.
- sudo journalctl -u nginx: checks the Nginx process logs.
- sudo journalctl -u myproject: checks your Flask app’s Gunicorn logs.
