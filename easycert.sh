#!/bin/bash

# Update and upgrade
apt update && apt upgrade -y

# Install required packages
apt install curl socat -y

# Install acme.sh script
curl https://get.acme.sh | sh

# Set default CA server
~/.acme.sh/acme.sh --set-default-ca --server letsencrypt

# Register account with email
read -p "Enter your email for registration: " user_email
~/.acme.sh/acme.sh --register-account -m "$user_email"

# Issue SSL certificate
read -p "Enter your domain or subdomain: " user_domain
~/.acme.sh/acme.sh --issue -d "$user_domain" --standalone

# Install certificate
~/.acme.sh/acme.sh --installcert -d "$user_domain" \
    --key-file /root/private.key --fullchain-file /root/cert.crt

echo "SSL certificate for $user_domain has been successfully obtained and installed!"
