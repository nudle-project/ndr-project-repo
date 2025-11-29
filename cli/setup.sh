#The extremely large setup file to setup NudleOS. It's very hard, and you ahve to execute more than 30 commands to install. It uses klp --strap to strap packages and klp --strap --cmd to install then or you can use -sc. To install them use klp --strap --cmd or klp -sc, not klp --strap install, that just straps an nonexistent package

# Check if running as root
if [ "$(id -u)" -ne 0 ]; then
    echo "Error: This script must be run as root."
    exit 1
fi

echo "Welcome to NudleOS setup! This process involves more than 30 commands."
echo "Please ensure you have an active internet connection."

# Step 1: Initialize klp package manager and update core components
echo "--- Step 1: Initializing klp and updating core components ---"
klp --strap klp-core # Strap the core klp package itself
klp --strap --cmd klp-utils # Install klp utilities
klp --strap --cmd klp-repo-manager # Install repository manager

# Step 2: Install essential build tools and development libraries
echo "--- Step 2: Installing essential build tools ---"
klp -sc build-essential
klp -sc cmake
klp -sc autoconf
klp -sc libtool
klp -sc pkg-config
klp -sc python3-dev
klp -sc perl
klp -sc ruby

# Step 3: Install core system utilities
echo "--- Step 3: Installing core system utilities ---"
klp -sc procps
klp -sc util-linux
klp -sc iproute2
klp -sc net-tools
klp -sc file
klp -sc findutils
klp -sc grep
klp -sc sed
klp -sc awk
klp -sc tar
klp -sc gzip
klp -sc bzip2
klp -sc xz-utils
klp -sc zip
klp -sc unzip
klp -sc rsync
klp -sc sudo
klp -sc logrotate

# Step 4: Setup basic directory structure for NudleOS
echo "--- Step 4: Setting up NudleOS directory structure ---"
mkdir -p /opt/nudleos/bin
mkdir -p /opt/nudleos/lib
mkdir -p /opt/nudleos/etc
mkdir -p /var/nudleos/data
mkdir -p /var/log/nudleos

# Step 5: Install NudleOS specific core packages
echo "--- Step 5: Installing NudleOS core packages ---"
klp -sc nudleos-base-system
klp -sc nudleos-kernel-firmware
klp -sc nudleos-bootloader
klp -sc nudleos-init-system
klp -sc nudleos-shell-environment
klp -sc nudleos-system-config
klp -sc nudleos-security-framework

# Step 6: Configure hostname and basic network settings
echo "--- Step 6: Configuring hostname and network ---"
# For simplicity, let's assume a default hostname. User can change later.
HOSTNAME="nudleos-desktop"
echo "$HOSTNAME" > /etc/hostname
hostname "$HOSTNAME"
echo "127.0.0.1 localhost" > /etc/hosts
echo "127.0.1.1 $HOSTNAME" >> /etc/hosts

# Install network management tools
klp -sc network-manager
klp -sc wireless-tools
klp -sc wpa-supplicant

# Step 7: Install SSH server for remote access
echo "--- Step 7: Installing and configuring SSH server ---"
klp -sc openssh-server
systemctl enable ssh
systemctl start ssh

echo "NudleOS initial setup completed successfully!"
echo "It is highly recommended to reboot your system now."
echo "You can set up users and further configure your system after reboot."
# Step 8: Install a basic text editor
echo "--- Step 8: Installing a basic text editor ---"
klp -sc nano

# Step 9: Install and configure a basic firewall
echo "--- Step 9: Installing and configuring firewall (UFW) ---"
klp -sc ufw
ufw enable
ufw default deny incoming
ufw default allow outgoing
echo "Firewall (UFW) enabled with default deny incoming, allow outgoing rules."

# Step 10: Set up system locale and timezone
echo "--- Step 10: Setting up system locale and timezone ---"
# Set a default timezone (e.g., UTC)
timedatectl set-timezone UTC
echo "Timezone set to UTC. You can change this later using 'timedatectl set-timezone'."

# Generate and set locales (e.g., en_US.UTF-8)
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
update-locale LANG=en_US.UTF-8

echo "NudleOS initial setup completed successfully with additional configurations!"
echo "It is highly recommended to reboot your system now."
echo "After reboot, you can create users, install a desktop environment (if desired), and further customize your NudleOS installation."
# Step 11: Install common download utilities
echo "--- Step 11: Installing common download utilities ---"
klp -sc wget
klp -sc curl

# Step 12: Clean up package manager cache
echo "--- Step 12: Cleaning up package manager cache ---"
klp --clean-cache
echo "Package manager cache cleaned."

echo "All specified NudleOS setup steps are complete."
echo "Please remember to reboot your system for all changes to take effect."
echo "After reboot, consider creating a non-root user for daily operations."
echo "Example: adduser yourusername"
echo "Then, you can install a desktop environment or other applications as needed."

# Step 13: Install a basic web browser (e.g., Lynx for text-based browsing)
echo "--- Step 13: Installing a basic web browser ---"
klp -sc lynx

# Step 14: Install essential system monitoring tools
echo "--- Step 14: Installing system monitoring tools ---"
klp -sc htop
klp -sc iotop
klp -sc nload

# Step 15: Install tools for disk management
echo "--- Step 15: Installing disk management tools ---"
klp -sc gparted
klp -sc smartmontools

# Step 16: Install common compression/decompression tools
echo "--- Step 16: Installing additional compression tools ---"
klp -sc p7zip-full
klp -sc rar

# Step 17: Install tools for system information
echo "--- Step 17: Installing system information tools ---"
klp -sc dmidecode
klp -sc lshw
klp -sc hwinfo

# Step 18: Install a package for managing fonts
echo "--- Step 18: Installing font management tools ---"
klp -sc fontconfig

# Step 19: Install tools for managing users and groups
echo "--- Step 19: Installing user management tools ---"
klp -sc users
klp -sc groups

# Step 20: Install a tool for managing cron jobs
echo "--- Step 20: Installing cron job manager ---"
klp -sc cron

# Step 21: Install a tool for managing services (alternative to systemctl if needed)
echo "--- Step 21: Installing service management tools ---"
klp -sc supervisor

# Step 22: Install a tool for managing permissions
echo "--- Step 22: Installing permission management tools ---"
klp -sc acl

# Step 23: Install a tool for managing symbolic links
echo "--- Step 23: Installing symbolic link management tools ---"
klp -sc symlinks

# Step 24: Install a tool for managing processes
echo "--- Step 24: Installing process management tools ---"
klp -sc psmisc

# Step 25: Install a tool for managing network connections
echo "--- Step 25: Installing network connection tools ---"
klp -sc nmap

# Step 26: Install a tool for managing remote filesystems
echo "--- Step 26: Installing remote filesystem tools ---"
klp -sc nfs-common
klp -sc cifs-utils

# Step 27: Install a tool for managing sound
echo "--- Step 27: Installing sound management tools ---"
klp -sc alsa-utils
klp -sc pulseaudio

# Step 28: Install a tool for managing graphics drivers (basic support)
echo "--- Step 28: Installing basic graphics support ---"
klp -sc xorg-server
klp -sc xinit

# Step 29: Install a terminal emulator
echo "--- Step 29: Installing a terminal emulator ---"
klp -sc xterm

# Step 30: Install a basic graphical file manager
echo "--- Step 30: Installing a graphical file manager ---"
klp -sc pcmanfm

# Final confirmation and reboot suggestion
echo ""
echo "=================================================="
echo " NudleOS Setup - All Steps Completed! "
echo "=================================================="
echo ""
echo "You have successfully installed NudleOS with a comprehensive set of tools."
echo "It is strongly recommended to reboot your system now for all changes to take effect."
echo ""
echo "To reboot, run: sudo reboot"
echo ""
echo "After reboot, you can:"
echo "  - Create a new user: sudo adduser <your_username>"
echo "  - Switch to the new user: su - <your_username>"
echo "  - Install a desktop environment (e.g., GNOME, KDE, XFCE) if desired."
echo "  - Further configure your system as needed."
echo ""
echo "Thank you for choosing NudleOS!"
