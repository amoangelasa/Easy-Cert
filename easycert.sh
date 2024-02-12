#!/bin/bash

# Constants
ACME_HOME="$HOME/.acme.sh"
PRIVATE_KEY="/root/private.key"
FULLCHAIN_FILE="/root/cert.crt"

# Update and upgrade
apt update && apt upgrade -y || { echo "Error updating and upgrading"; exit 1; }

# Install required packages
apt install curl socat -y || { echo "Error installing packages"; exit 1; }

# Install acme.sh script
curl https://get.acme.sh | sh || { echo "Error installing acme.sh"; exit 1; }

# Set default CA server
"$ACME_HOME/acme.sh" --set-default-ca --server letsencrypt || { echo "Error setting default CA server"; exit 1; }

# Register account with email
read -p "Enter your email for registration: " user_email
"$ACME_HOME/acme.sh" --register-account -m "$user_email" || { echo "Error registering account"; exit 1; }

# Issue SSL certificate
read -p "Enter your domain or subdomain: " user_domain
"$ACME_HOME/acme.sh" --issue -d "$user_domain" --standalone || { echo "Error issuing SSL certificate"; exit 1; }

# Install certificate
"$ACME_HOME/acme.sh" --installcert -d "$user_domain" \
    --key-file "$PRIVATE_KEY" --fullchain-file "$FULLCHAIN_FILE" || { echo "Error installing certificate"; exit 1; }

echo "SSL certificate for $user_domain has been successfully obtained and installed!"
