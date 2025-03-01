#!/bin/bash

# This script downloads a recovery key file and applies it to the firmware using futility.  This script is ONLY intended for use on Dedede, Nissa or Corsola. Use at your own risk. I might add more keyrolled devices in the near future
# This script requires to be ran as chronos, not root. Failure to do so may result in the recovery key not being applied correctly, or the device not being able to access the recovery key file.
# Detect ChromeOS/ChromiumOS
if grep -q "Chrom" /etc/lsb-release ; then
    DOWNLOADS_DIR="/home/chronos/user/Downloads"
else
    DOWNLOADS_DIR="$HOME/Downloads"
fi
# Variables
RECOVERY_KEY_NISSA="https://raw.githubusercontent.com/Cruzy22k/NissaFW2/main/nissa_recovery_v1.vbpubk"
RECOVERY_KEY_NISSA_FILE="nissa_recovery_v1.vbpubk"
RECOVERY_KEY_DEDEDE="https://raw.githubusercontent.com/Cruzy22k/NissaFW2/main/dedede_recovery_v1.vbpubk"
RECOVERY_KEY_DEDEDE_FILE="dedede_recovery_v1.vbpubk"
RECOVERY_KEY_CORSOLA="https://raw.githubusercontent.com/Cruzy22k/NissaFW2/main/corsola_recovery_v1.vbpubk"
RECOVERY_KEY_CORSOLA_FILE="corsola_recovery_v1.vbpubk"

echo -e "\e[0;37;42m<Firmware2>  Copyright (C) 2024  <Cruzy22k>
This program comes with ABSOLUTELY NO WARRANTY.

This is free software, and you are welcome to redistribute it
under certain conditions.\e[0m"

echo "please select what device you have, dedede (1), nissa (2) or corsola (3)"
echo    
read -p "Enter the number of the device you have: " -n 1 -r
echo   


echo "DEBUG: You entered '$REPLY'"
if [[ $REPLY =~ ^[1]$ ]]; then
    RECOVERY_KEY_URL="$RECOVERY_KEY_DEDEDE"
    RECOVERY_KEY_FILE="$RECOVERY_KEY_DEDEDE_FILE"
elif [[ $REPLY =~ ^[2]$ ]]; then
    RECOVERY_KEY_URL="$RECOVERY_KEY_NISSA"
    RECOVERY_KEY_FILE="$RECOVERY_KEY_NISSA_FILE"
elif [[ $REPLY =~ ^[3]$ ]]; then
    RECOVERY_KEY_URL="$RECOVERY_KEY_CORSOLA"
    RECOVERY_KEY_FILE="$RECOVERY_KEY_CORSOLA_FILE"
else
    echo "Invalid input. Please enter 1, 2 or 3."
    exit 1
fi

# Debug output:
echo "DEBUG: Selected URL: $RECOVERY_KEY_URL"
echo "DEBUG: Selected file name: $RECOVERY_KEY_FILE"



# Create Downloads directory if it doesn't exist
mkdir -p "$DOWNLOADS_DIR"


# Download the recovery key file to the Downloads folder
echo "Downloading the recovery key file..."
cd "$DOWNLOADS_DIR" || exit 1
curl -L -o "$RECOVERY_KEY_FILE" "$RECOVERY_KEY_URL"

# Check if download was successful
if [ ! -f "$RECOVERY_KEY_FILE" ]; then
    echo "Failed to download the recovery key file."
    exit 1
fi

echo "Downloaded the recovery key file to $DOWNLOADS_DIR/$RECOVERY_KEY_FILE."

# Ask for confirmation before applying the recovery key
echo "WARNING: Before proceeding, ensure that Write Protect (WP) is disabled on your device."
echo "Failure to disable WP may result in the recovery key not being applied correctly."
read -p "Are you sure you want to apply the recovery key with futility? (y/n) " -n 1 -r
echo    
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Aborting the process."
    exit 1
fi

# Apply the recovery key with futility
echo "Applying the recovery key with futility..."
futility gbb -s --flash --recoverykey="$DOWNLOADS_DIR/$RECOVERY_KEY_FILE"

# Check if application was successful
if [ $? -eq 0 ]; then
    echo "Successfully applied the recovery key."
else
    echo "Failed to apply the recovery key."
    # Clear the vbpubk files from the Downloads folder only if the previous command fails
    echo "Clearing the vbpubk files from the Downloads folder..."
    rm -f "$DOWNLOADS_DIR"/*.vbpubk
    sleep 5

    exit 1
fi

echo "Process completed successfully, reboot and try to boot a shim" 
echo " "
echo "Made by cruzy22k" 
echo ":)"
echo " A reboot is required for the changes to take effect."
# Clear the vbpubk files from the Downloads folder
echo "Clearing the vbpubk files from the Downloads folder..."
rm -f "$DOWNLOADS_DIR"/*.vbpubk


sleep 5

echo "the vbpubk files have been removed from the Downloads folder."

echo " "


# Option to reboot the system
read -p "Do you want to reboot now? (y/n) " -n 1 -r
echo   
if [[ $REPLY =~ ^[Yy]$ ]]; then
    sudo reboot
fi

echo   
sleep 10


echo "Please reboot your system manually to see changes take effect"


