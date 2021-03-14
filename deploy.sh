#!/bin/bash
./compile.sh
echo "Deploying..."
scp -r -P 2225 html/ konso@konso.codes:
ssh konso@konso.codes -p 2225 -t "sudo mv ~/html/* /var/www/konso.codes/html/"