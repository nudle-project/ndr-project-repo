#The shell script to setup NudleOS (copies all the files from the media to the device, or use the network.) It uses colored spaces to look graphical, similar to tty ui commands, like the debian non-graphical install. This command runs for about 3 hours to install or setup to the disk. This means it copies all the OS files, so when we finish, it closes itself and reboots. The colored orange progress bar shows how far you are.

#!/bin/bash

# Define colors
RED='\033[0;31m'
ORANGE='\033[0;33m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to display a colored progress bar
display_progress() {
    local progress=$1
    local bar_length=50
    local filled_length=$(echo "$progress * $bar_length / 100" | bc)
    local empty_length=$((bar_length - filled_length))
    local bar=""

    for ((i=0; i<filled_length; i++)); do
        bar+="${ORANGE}█${NC}"
    done
    for ((i=0; i<empty_length; i++)); do
        bar+="░"
    done
    echo -ne "\r${BLUE}Progress: [${bar}${BLUE}] ${progress}%"
}

echo -e "${GREEN}Welcome to NudleOS Setup!${NC}"
echo -e "${BLUE}This process will take approximately 3 hours.${NC}"
echo ""

# Simulate file copying with progress
total_files=1000 # Assume 1000 files for simulation
copied_files=0

for i in $(seq 1 $total_files); do
    # Simulate copying a file
    sleep 0.1 # Simulate work

    copied_files=$((copied_files + 1))
    progress=$(echo "scale=2; $copied_files * 100 / $total_files" | bc)
    display_progress $progress

done

echo ""
echo ""
echo -e "${GREEN}NudleOS installation complete!${NC}"
echo -e "${GREEN}Rebooting the system...${NC}"

# Simulate reboot
sleep 3
reboot

# Define the source and destination directories
SOURCE_DIR="/media/install" # Assuming installation media is mounted here
DEST_DIR="/mnt/nudle"      # Assuming the target installation directory

# Create the destination directory if it doesn't exist
mkdir -p "$DEST_DIR"

# Get the total number of files to copy
total_files=$(find "$SOURCE_DIR" -type f | wc -l)
copied_files=0

echo -e "${BLUE}Starting file copy from $SOURCE_DIR to $DEST_DIR...${NC}"

# Copy files with progress
find "$SOURCE_DIR" -type f -print0 | while IFS= read -r -d $'\0' file; do
    # Create parent directories if they don't exist in the destination
    mkdir -p "$DEST_DIR/$(dirname "${file#$SOURCE_DIR/}")"

    # Copy the file
    cp "$file" "$DEST_DIR/$(dirname "${file#$SOURCE_DIR/}")/"

    copied_files=$((copied_files + 1))
    progress=$(echo "scale=2; $copied_files * 100 / $total_files" | bc)
    display_progress $progress
done

echo ""
echo ""
echo -e "${GREEN}NudleOS installation complete!${NC}"
echo -e "${GREEN}Rebooting the system...${NC}"

# Simulate reboot
sleep 3
reboot

# Ensure the script exits if any command fails
set -e