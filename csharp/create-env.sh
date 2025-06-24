#!/bin/bash

# Script to create a .env file with Git configuration

# Output file
ENV_FILE=".env"

# Clear existing file or create new one
> "$ENV_FILE"

# Function to prompt for input and add to .env
add_env_var() {
    local var_name=$1
    local prompt_text=$2

    echo -n "$prompt_text: "
    read -r var_value
    echo "$var_name=$var_value" >> "$ENV_FILE"
}

echo "Creating .env file with Git configuration..."

# Prompt for each value
add_env_var "GIT_TOKEN" "Enter your Git token"
add_env_var "GIT_USER" "Enter your Git username"
add_env_var "GIT_EMAIL" "Enter your Git email"

echo "Done! .env file created successfully."
echo "File location: $(pwd)/$ENV_FILE"
