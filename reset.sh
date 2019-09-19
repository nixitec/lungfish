cd ~
sudo rm -rf lungfish
sudo rm -rf nixography
git clone https://github.com/nixitec/lungfish.git
cd lungfish
chmod +x lungfi.sh
chmod +x reset.sh
cp ./reset.sh ..
cd ..
sudo bash +x ./lungfi.sh
