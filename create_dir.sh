#!/bin/bash

# This script creates a parent directory and optional nested subdirectories
# based on user input.

# Function to get user input for a directory name
get_dir_name() {
  local prompt_message=$1
  local dir_name=""
  while [ -z "$dir_name" ]; do
    read -p "$prompt_message" dir_name
    if [ -z "$dir_name" ]; then
      echo "Directory name cannot be empty. Please try again."
    fi
  done
  echo "$dir_name"
}

echo "--- Directory Creator Script ---"

# Get parent directory name
parent_dir=$(get_dir_name "Enter the name for the parent directory: ")

# Initialize path variable
full_path="$parent_dir"

# Create the parent directory
echo "Creating parent directory: $parent_dir"
mkdir -p "$parent_dir" || { echo "Error: Could not create $parent_dir"; exit 1; }

# Ask about creating a first subdirectory
read -p "Do you want to create a subdirectory inside '$parent_dir'? (y/n): " create_sub1_choice
if [[ "$create_sub1_choice" =~ ^[Yy]$ ]]; then
  sub_dir1=$(get_dir_name "Enter the name for the first subdirectory: ")
  full_path="$full_path/$sub_dir1"
  echo "Creating subdirectory: $full_path"
  mkdir -p "$full_path" || { echo "Error: Could not create $full_path"; exit 1; }

  # Ask about creating a second subdirectory (nested inside the first)
  read -p "Do you want to create a subdirectory inside '$sub_dir1'? (y/n): " create_sub2_choice
  if [[ "$create_sub2_choice" =~ ^[Yy]$ ]]; then
    sub_dir2=$(get_dir_name "Enter the name for the second subdirectory: ")
    full_path="$full_path/$sub_dir2"
    echo "Creating subdirectory: $full_path"
    mkdir -p "$full_path" || { echo "Error: Could not create $full_path"; exit 1; }
  fi
fi

echo "--- Directory creation complete! ---"
echo "The following directory structure was created (if applicable):"
echo "$parent_dir"
if [[ -n "$sub_dir1" ]]; then
  echo "├── $sub_dir1"
  if [[ -n "$sub_dir2" ]]; then
    echo "│   └── $sub_dir2"
  fi
fi
echo "You can find them at $(pwd)/$parent_dir"

