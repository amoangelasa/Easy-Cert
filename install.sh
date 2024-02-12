#!/bin/bash

# Constants
SCRIPT_NAME="easycert.sh"
GITHUB_REPO="https://raw.githubusercontent.com/amoangelasa/Easy-Cert/blob/main/$SCRIPT_NAME"

# Download the script from GitHub
curl -O "$GITHUB_REPO" || { echo "Error downloading $SCRIPT_NAME from GitHub"; exit 1; }

# Make the script executable (if needed)
chmod +x "$SCRIPT_NAME" || { echo "Error making $SCRIPT_NAME executable"; exit 1; }

# Run the script
./"$SCRIPT_NAME" || { echo "Error running $SCRIPT_NAME"; exit 1; }
