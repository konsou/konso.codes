#!/bin/bash
if [[ ! -f .env ]]; then
    echo ".env missing!"
    exit 1
fi
source .env
./compile-pdf.sh
git add .
git commit -m "Automatic deployment"
git push
echo "Deploying..."
DEPLOY_ON_SERVER_SCRIPT=$(< deploy-on-server.sh)
TEMP_SCRIPT_LOCATION=/tmp/konso.codes/temp-deploy-script.sh
ssh "${SSH_USER}@${SSH_SERVER}" -p $SSH_PORT -t "echo "${DEPLOY_ON_SERVER_SCRIPT}" > "${TEMP_SCRIPT_LOCATION}"; bash "${TEMP_SCRIPT_LOCATION}"; rm "${TEMP_SCRIPT_LOCATION}""