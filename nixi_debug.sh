#!/bin/bash

echo "Run Flask only in debug mode"
echo "Go to http://nixography.com:5000"

cd ~/nix
source ./nix_env/bin/activate
python nix.py
