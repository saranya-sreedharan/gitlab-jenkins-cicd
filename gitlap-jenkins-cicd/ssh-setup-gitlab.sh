#!/bin/bash

# Function to handle errors
handle_error() {
    echo "Error: $1" >&2
    exit 1
}

# Prompt the user for their email
echo "Enter your email address:"
read email

# Generate SSH key
ssh-keygen -t ed25519 -C "$email" || handle_error "Failed to generate SSH key."

# Start SSH agent
eval "$(ssh-agent -s)" || handle_error "Failed to start SSH agent."

# Add SSH key to SSH agent
ssh-add ~/.ssh/id_ed25519 || handle_error "Failed to add SSH key to SSH agent."

# Display the content of the public key to the user
echo "Your public key is:"
cat ~/.ssh/id_ed25519.pub

# Prompt the user to update the public key in GitLab
echo "Please update the content of this public key in your GitLab account."

# Test SSH connection to GitLab
ssh -T git@gitlab.com || handle_error "Failed to establish SSH connection to GitLab."

echo "SSH key setup completed successfully."
