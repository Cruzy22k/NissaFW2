#!/bin/bash
#
# Define variables
DOWNLOADS_DIR="/home/chronos/user/Downloads"
FIRMWARE_SCRIPT_URL="https://raw.githubusercontent.com/Cruzy22k/NissaFW2/firmware.sh"

# Function to download and execute firmware.sh
function download_and_execute_firmware {
    local script_url=$1
    local script_name="firmware.sh"

    echo "Downloading $script_name script..."
    mkdir -p "$DOWNLOADS_DIR"
    cd "$DOWNLOADS_DIR" || exit
    curl -LO "$script_url"

    # Check if download was successful
    if [ ! -f "$script_name" ]; then
        echo "Failed to download $script_name script."
        exit 1
    fi

    echo "Downloaded $script_name script to $DOWNLOADS_DIR/$script_name."

    # Change permissions to make it executable
    chmod +x "$script_name"

    # Execute the firmware.sh script
    echo "Executing $script_name script..."
    "./$script_name"
}

# Ensure script is not run as root
if [[ $EUID -eq 0 ]]; then
    echo "This script must NOT be run as root." 
    exit 1
fi

# Execute the function to download and execute firmware.sh
download_and_execute_firmware "$FIRMWARE_SCRIPT_URL"

# End of setup.sh script
