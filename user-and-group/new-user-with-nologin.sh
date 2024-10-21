#!/bin/bash

# Check if root user is running the script
if [ "$(id -u)" -ne 0 ]; then
  echo "Error: This script must be run as root."
  exit 1
fi

# Check if username and password are provided as arguments
if [ "$#" -ne 2 ]; then
  echo "Please provide username and password!"
  echo "Correct Usage: $0 <username> <password>"
  exit 1
fi

username=$1
password=$2

# Default home directory path
home_dir="/home/$username"

# Create the user account with no login and default home directory
useradd -r -m -d "$home_dir" -s /sbin/nologin "$username" &>/dev/null
if [ $? -ne 0 ]; then
  echo "Error: Failed to create user account."
  exit 1
fi

# Set the password for the user
echo "$username:$password" | chpasswd
if [ $? -ne 0 ]; then
  echo "Error: Failed to set password for the user."
  exit 1
fi

# Set permissions for the home directory
chown -R "$username:$username" "$home_dir"
chmod 750 "$home_dir"

echo "User $username has been created successfully"

