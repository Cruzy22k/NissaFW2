#!/bin/bash

# Detect ChromeOS/ChromiumOS
if grep -q "Chrom" /etc/lsb-release ; then
    DOWNLOADS_DIR="/home/chronos/user/Downloads"
else
    DOWNLOADS_DIR="$HOME/Downloads"
fi

RECOVERY_KEY_URL="https://drive.google.com/uc?export=download&id=1KizP1My9XHH4Q87R0TBzowkiYJgwbNky"
RECOVERY_KEY_FILE="nissa_recovery_v1.vbpubk"


# Step 1: Create Downloads directory if it doesn't exist
mkdir -p "$DOWNLOADS_DIR"

# Step 2: Download the recovery key file to the Downloads folder
echo "Downloading the recovery key file..."
cd "$DOWNLOADS_DIR" || exit 1
curl -L -o "$RECOVERY_KEY_FILE" "$RECOVERY_KEY_URL"

# Check if download was successful
if [ ! -f "$RECOVERY_KEY_FILE" ]; then
    echo "Failed to download the recovery key file."
    exit 1
fi

echo "Downloaded the recovery key file to $DOWNLOADS_DIR/$RECOVERY_KEY_FILE."

# Step 3: Ask for confirmation before applying the recovery key
echo "WARNING: Before proceeding, ensure that Write Protect (WP) is disabled on your device."
echo "Failure to disable WP may result in the recovery key not being applied correctly."
read -p "Are you sure you want to apply the recovery key with futility? (y/n) " -n 1 -r
echo    # Move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Aborting the process."
    exit 1
fi

# Step 4: Apply the recovery key with futility
echo "Applying the recovery key with futility..."
futility gbb -s --flash --recoverykey="$DOWNLOADS_DIR/$RECOVERY_KEY_FILE"

# Check if application was successful
if [ $? -eq 0 ]; then
    echo "Successfully applied the recovery key."
else
    echo "Failed to apply the recovery key."
    exit 1
fi

echo "Process completed successfully, reboot and try to boot a shim"
