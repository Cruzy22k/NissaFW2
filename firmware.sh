#!/bin/bash

BACKUP_DIR=~/vpd_backup
RECOVERY_KEY_URL="https://drive.google.com/uc?export=download&id=1KizP1My9XHH4Q87R0TBzowkiYJgwbNky"
RECOVERY_KEY_FILE="nissa_recovery_v1.vbpubk"

# Ensure the script is run as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

# Step 1: Download the recovery key file to the Chromebook's Downloads folder
echo "Downloading the recovery key file..."
cd ~/Downloads
curl -L -o $RECOVERY_KEY_FILE $RECOVERY_KEY_URL

if [ ! -f $RECOVERY_KEY_FILE ]; then
    echo "Failed to download the recovery key file."
    exit 1
fi

echo "Downloaded the recovery key file to ~/Downloads/$RECOVERY_KEY_FILE."

# Step 2: Apply the recovery key with futility
echo "Applying the recovery key with futility..."
futility gbb -s --flash --recoverykey=$RECOVERY_KEY_FILE

if [ $? -eq 0 ]; then
    echo "Successfully applied the recovery key."
else
    echo "Failed to apply the recovery key."
    exit 1
fi

echo "You are done. Congratulations! 🎉”
