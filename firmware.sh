#!/bin/bash

RECOVERY_KEY_URL="https://drive.google.com/uc?export=download&id=1KizP1My9XHH4Q87R0TBzowkiYJgwbNky"
RECOVERY_KEY_FILE="nissa_recovery_v1.vbpubk"
DOWNLOADS_DIR="$HOME/Downloads"

# Ensure the script is run as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

# Step 1: Download the recovery key file to the Chromebook's Downloads folder
echo "Downloading the recovery key file..."
cd "$DOWNLOADS_DIR"
curl -L -o "$RECOVERY_KEY_FILE" "$RECOVERY_KEY_URL"

if [ ! -f "$RECOVERY_KEY_FILE" ]; then
    echo "Failed to download the recovery key file."
    exit 1
fi

echo "Downloaded the recovery key file to $DOWNLOADS_DIR/$RECOVERY_KEY_FILE."

# Step 2: Ask for confirmation before applying the recovery key
read -p "Are you sure you want to apply the recovery key with futility? (y/n) " -n 1 -r
echo    # Move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Aborting the process."
    exit 1
fi

# Step 3: Apply the recovery key with futility
echo "Applying the recovery key with futility..."
futility gbb -s --flash --recoverykey="$RECOVERY_KEY_FILE"

if [ $? -eq 0 ]; then
    echo "Successfully applied the recovery key."
else
    echo "Failed to apply the recovery key."
    exit 1
fi

echo "You are done. Congratulations! 🎉"
