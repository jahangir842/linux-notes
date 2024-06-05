#!/bin/bash

# Function to prompt for Samba username and new password
get_samba_credentials() {
    read -p "Enter Samba username: " username
    read -s -p "Enter new Samba password: " password
    echo
}

# Main function to change Samba password
change_samba_password() {
    # Prompt for Samba credentials
    get_samba_credentials

    # Check if the username is valid
    if smbpasswd -e "$username" >/dev/null 2>&1; then
        # Change the Samba password
        echo "$password" | sudo smbpasswd -s -a "$username"
        if [ $? -eq 0 ]; then
            echo "Samba password changed successfully for user: $username"
        else
            echo "Failed to change Samba password for user: $username"
        fi
    else
        echo "User $username does not exist in Samba."
    fi
}

# Call the main function to change Samba password
change_samba_password

