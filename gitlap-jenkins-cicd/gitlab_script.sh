#!/bin/bash

# Function to prompt user for choice
get_choice() {
    read -r -p "Which operation would you like to perform? (Enter the number)
1. Add changes to an existing repository
2. Setup a new Git repository
Enter choice: " choice
    echo "$choice"
}

# Function to prompt user for confirmation with a given message
confirm() {
    read -r -p "$1 [y/N]: " response
    case "$response" in
        [yY][eE][sS]|[yY])
            true
            ;;
        *)
            false
            ;;
    esac
}

# Function to handle errors
handle_error() {
    echo "Error occurred: $1"
    # Check if continue on error flag is set, if not, exit
    if [ "$continue_on_error" != "true" ]; then
        exit 1
    fi
}

echo "Welcome to the GitLab push script."

# Get user choice
choice=$(get_choice)

# Set continue_on_error flag to true
continue_on_error="true"

# Choice 1: Add changes to an existing repository
if [ "$choice" -eq 1 ]; then
    echo "Fetching git branch..."
    git branch || handle_error "Failed to fetch git branch."
    echo "Fetching associated remote branch..."
    git rev-parse --abbrev-ref --symbolic-full-name @{u} || handle_error "Failed to fetch associated remote branch."
    
    if confirm "Do you want to push your changes to the remote repository?"; then
        read -rp "Enter the commit message: " message
        git add . || handle_error "Failed to add files to the index."
        git status || handle_error "Failed to get the status of the repository."
        sleep 10
        git commit -m "$message" || handle_error "Failed to commit changes."
        git push --set-upstream origin "$(git rev-parse --abbrev-ref HEAD)" || handle_error "Failed to push changes to remote repository."
        echo "Pushed changes successfully."
    else
        echo "Push operation cancelled."
    fi

# Choice 2: Setup a new Git repository
elif [ "$choice" -eq 2 ]; then
    echo "Setting up Git in a new directory..."
    git init || handle_error "Failed to initialize new Git repository."
    
    echo "Checking status..."
    git status || handle_error "Failed to get the status of the repository."
    
    echo "Listing branches..."
    git branch || handle_error "Failed to list branches."
    read -rp "Enter the branch name: " branch_name
    # Check if branch already exists
    if git show-ref --verify --quiet "refs/heads/$branch_name"; then
        handle_error "A branch named '$branch_name' already exists."
    fi
    git checkout -b "$branch_name" || handle_error "Failed to create and checkout new branch."
    
    read -rp "Enter the remote repository URL (SSH): " remote_url
    # Check if remote already exists, if not add it
    if ! git remote get-url origin >/dev/null 2>&1; then
        git remote add origin "$remote_url" || handle_error "Failed to add remote repository URL."
    else
        echo "Remote repository already exists."
    fi
    
    echo "Fetching from remote repository..."
    git pull origin main --allow-unrelated-histories || handle_error "Failed to pull from remote repository."
    
    echo "Listing remote repositories..."
    git remote -v || handle_error "Failed to l
    ist remote repositories."
    
    echo "Make some changes in your source code..."
    # You can add code here to make changes to the source code
    
    git add . || handle_error "Failed to add files to the index."
    git commit -m "Updated content uploaded" || handle_error "Failed to commit changes."
    git push --set-upstream origin "$branch_name" || handle_error "Failed to push changes to remote repository."
    echo "Pushed changes successfully."
    
else
    echo "Invalid choice. Exiting."
fi