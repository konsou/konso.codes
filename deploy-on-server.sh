#!/bin/bash
# Run this script on the web server
if [[ ! -f .env ]]; then
    echo ".env missing!"
    exit 1
fi

cd ~
if [[ ! -d ./konso.codes ]]; then
    echo "Cloning repo..."
    git clone https://github.com/konsou/konso.codes/
    cd konso.codes/
else
    echo "Updating files..."
    cd konso.codes/
    git pull
fi

./compile.sh

sudo cp -r ./html/. ${REMOTE_WWW_DIR}/
echo Done.
