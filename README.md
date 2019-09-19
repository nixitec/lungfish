# lungfish
Linux Ubuntu Nginx Gunicorn Flask Instance SHell

### Preperation:
1. Install Lightsail Instance
2. Install git
```
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install git
```
3. Clone this repository
```
git clone https://github.com/nixitec/lungfish.git
```
4. Run ./lungfi.sh
```
cd lungfish
chmod +x lungfi.sh
sudo bash -x ./lungfi.sh
```
5. Remove lungfish
```
cd ..
sudo rm -rfv lungfish
```



### lungfi.sh will:
1. Create a new user
1. Install Cloud9
