cd ~
sudo rm -rf lungfish
sudo rm -rf nixography
git clone https://github.com/nixitec/lungfish.git
cd lungfish
chmod +x lungfi.sh
cp ./reset.sh ..
cd ..
chmod +x reset.sh
bash +x ./lungfish/lungfi.sh
