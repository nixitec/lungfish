# lungfish
Linux Ubuntu Nginx Gunicorn Flask Instance SHell

### Preperation:
1. Install Lightsail Instance
1. Don't forget to attach the static ip

2. Clone this repository
```
git clone https://github.com/nixitec/lungfish.git
```
3. Run ./lungfi.sh
```
chmod +x ./lungfish/lungfi.sh
bash -x ./lungfish/lungfi.sh
```
4. Remove lungfish
```
sudo rm -rfv lungfish
```



### lungfi.sh will:
1. Create a new user
1. Install Cloud9

###Excellent articles and links:
https://lightsail.aws.amazon.com/ls/docs/en_us/articles/amazon-lightsail-using-lets-encrypt-certificates-with-nginx
