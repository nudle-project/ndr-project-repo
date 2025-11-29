#The script to create the lshware command.
echo "Listing hardware..."
echo "-----------------"
# List CPU information
echo "CPU Information:"
lscpu
echo ""

# List memory information
echo "Memory Information:"
free -h
echo ""

# List disk information
echo "Disk Information:"
lsblk
echo ""

# List network interface information
echo "Network Interface Information:"
ip a
echo ""

# List PCI devices
echo "PCI Devices:"
lspci
echo ""

# List USB devices
echo "USB Devices:"
lsusb
echo ""

echo "-----------------"
echo "Hardware listing complete."
