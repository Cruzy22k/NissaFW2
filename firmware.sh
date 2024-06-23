#!/bin/bash

# Detect ChromeOS/ChromiumOS
if grep -q "Chrom" /etc/lsb-release ; then
    DOWNLOADS_DIR="/home/chronos/user/Downloads"
else
    DOWNLOADS_DIR="$HOME/Downloads"
fi

RECOVERY_KEY_URL="https://drive.google.com/uc?export=download&id=1KizP1My9XHH4Q87R0TBzowkiYJgwbNky"
RECOVERY_KEY_FILE="nissa_recovery_v1.vbpubk"

# Ensure the script is NOT run as root
if [[ $EUID -eq 0 ]]; then
   echo "This script must NOT be run as root" 
   exit 1
fi

# Function to run flashrom and futility commands as root
run_commands_with_sudo() {
    echo "Applying the recovery key with futility..."
    sudo futility gbb -s --flash --recoverykey="$DOWNLOADS_DIR/$RECOVERY_KEY_FILE"
}

# Check if Write Protect (WP) is enabled using flashrom
echo "Checking Write Protect (WP) status..."
if sudo flashrom --wp-status | grep -q "Hardware write protection is enabled"; then
    echo "Write Protect (WP) is enabled. Aborting."
    exit 1
fi

# Step 1: Create Downloads directory if it doesn't exist
mkdir -p "$DOWNLOADS_DIR"

# Step 2: Download the recovery key file to the Chromebook's Downloads folder
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
read -p "Are you sure you want to apply the recovery key with futility? (y/n) " -n 1 -r
echo    # Move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Aborting the process."
    exit 1
fi

# Run flashrom and futility commands with elevated privileges
run_commands_with_sudo

# Check if application was successful
if [ $? -eq 0 ]; then
    echo "Successfully applied the recovery key."
else
    echo "Failed to apply the recovery key."
    exit 1
fi

echo "You are done. Congratulations!"
