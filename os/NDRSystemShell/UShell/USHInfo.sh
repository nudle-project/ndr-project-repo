#The U-Shell info and command pallete
# The U-Shell info and command pallete

# This script provides information about the U-Shell and a command palette for user interaction.

# --- U-Shell Information ---
USH_VERSION="1.0.0"
USH_AUTHOR="NudleOS Development Team"
USH_LICENSE="MIT"

# --- Command Palette ---
# This function displays the command palette and handles user input.
show_command_palette() {
  echo "-------------------------------------"
  echo "          U-Shell Command Palette"
  echo "-------------------------------------"
  echo "1. Show U-Shell Info"
  echo "2. List Files"
  echo "3. Create Directory"
  echo "4. Delete File/Directory"
  echo "5. Exit"
  echo "-------------------------------------"
  read -p "Enter your choice [1-5]: " choice

  case $choice in
    1)
      show_ush_info
      ;;
    2)
      read -p "Enter directory path: " dir_path
      list_files "$dir_path"
      ;;
    3)
      read -p "Enter new directory name: " new_dir_name
      create_directory "$new_dir_name"
      ;;
    4)
      read -p "Enter file or directory to delete: " delete_target
      delete_item "$delete_target"
      ;;
    5)
      echo "Exiting U-Shell. Goodbye!"
      exit 0
      ;;
    *)
      echo "Invalid choice. Please enter a number between 1 and 5."
      ;;
  esac
}

# --- Helper Functions ---

# Displays U-Shell information.
show_ush_info() {
  echo "-------------------------------------"
  echo "          U-Shell Information"
  echo "-------------------------------------"
  echo "Version: $USH_VERSION"
  echo "Author: $USH_AUTHOR"
  echo "License: $USH_LICENSE"
  echo "-------------------------------------"
}

# Lists files and directories in a given path.
list_files() {
  local path="$1"
  if [ -d "$path" ]; then
    echo "Listing contents of '$path':"
    ls -l "$path"
  else
    echo "Error: '$path' is not a valid directory."
  fi
}

# Creates a new directory.
create_directory() {
  local dir_name="$1"
  if mkdir "$dir_name"; then
    echo "Directory '$dir_name' created successfully."
  else
    echo "Error: Failed to create directory '$dir_name'."
  fi
}

# Deletes a file or directory.
delete_item() {
  local target="$1"
  if [ -e "$target" ]; then
    read -p "Are you sure you want to delete '$target'? (y/N): " confirm
    if [[ "$confirm" == "y" || "$confirm" == "Y" ]]; then
      if rm -rf "$target"; then
        echo "'$target' deleted successfully."
      else
        echo "Error: Failed to delete '$target'."
      fi
    else
      echo "Deletion cancelled."
    fi
  else
    echo "Error: '$target' not found."
  fi
}

# --- Main Execution ---
# Start the U-Shell by showing the command palette.
show_command_palette
# Define the main loop for the U-Shell
main_loop() {
  while true; do
    show_command_palette
  done
}

# Start the U-Shell
main_loop

echo "Usage: klp --strap [package] or klp --cmd [package]"
echo "klp --version or -V"
echo "klp --add-repository [github repo]"

# Initialize the klp command
klp() {
  case "$1" in
    --strap)
      shift
      strap_package "$@"
      ;;
    --cmd)
      shift
      cmd_package "$@"
      ;;
    --version|-V)
      echo "klp version 1.0.0"
      ;;
    --add-repository)
      shift
      add_repository "$@"
      ;;
    *)
      echo "Unknown command. Use --strap, --cmd, --version, or --add-repository."
      ;;
  esac
}

# Function to strap a package
strap_package() {
  local package_name="$1"
  echo "Strapping package: $package_name"
  # Add logic here to download and install the package
  echo "Package '$package_name' strapped successfully."
}

# Function to run a command from a package
cmd_package() {
  local package_name="$1"
  echo "Running command from package: $package_name"
  # Add logic here to find and execute the command
  echo "Command from '$package_name' executed."
}

# Function to add a new repository
add_repository() {
  local repo_url="$1"
  echo "Adding repository: $repo_url"
  # Add logic here to add the repository to the configuration
  echo "Repository '$repo_url' added successfully."
}

# Export the klp function to be available in the shell
export -f klp
#end