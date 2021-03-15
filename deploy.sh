#!/bin/bash
source .env
./compile.sh
echo "Deploying..."
scp -r -P $SSH_PORT html/ "${SSH_USER}@${SSH_SERVER}:${REMOTE_TEMP_DIR}/"
ssh "${SSH_USER}@${SSH_SERVER}" -p $SSH_PORT -t "sudo cp -r \"${REMOTE_TEMP_DIR}/html/*\" \"${REMOTE_WWW_DIR}/\""