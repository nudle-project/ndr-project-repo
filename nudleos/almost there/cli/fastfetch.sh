RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'
nudleos_ascii() {
    cat << "EOF"
${BLUE}
    __  _  __
   / / | |/ /
  / /  |   /
 / /___|  /
/_____|_/
${NC}
EOF
}
OS=$(grep PRETTY_NAME /etc/os-release | cut -d'=' -f2 | tr -d '"')
KERNEL=$(uname -r)
UPTIME=$(uptime -p | sed 's/up //g')
PACKAGES=$(dpkg -l | grep ^ii | wc -l) # For Debian/Ubuntu
SHELL=$(basename "$SHELL")
RESOLUTION=$(xdpyinfo | grep dimensions | awk '{print $2}') # Requires xdpyinfo
CPU=$(grep "model name" /proc/cpuinfo | head -n 1 | cut -d':' -f2 | sed 's/^ *//')
GPU=$(lspci | grep -i vga | cut -d':' -f3 | sed 's/^ *//')
MEMORY=$(free -h | awk '/Mem:/ {print $3 "/" $2}')
clear
nudleos_ascii
echo -e " ${GREEN}NudleOS${NC}"
echo -e " ${BLUE}--------------------${NC}"
echo -e " ${YELLOW}OS:${NC}         $OS"
echo -e " ${YELLOW}Kernel:${NC}     $KERNEL"
echo -e " ${YELLOW}Uptime:${NC}     $UPTIME"
echo -e " ${YELLOW}Packages:${NC}   $PACKAGES (dpkg)"
echo -e " ${YELLOW}Shell:${NC}      $SHELL"
echo -e " ${YELLOW}Resolution:${NC} $RESOLUTION"
echo -e " ${YELLOW}CPU:${NC}        $CPU"
echo -e " ${YELLOW}GPU:${NC}        $GPU"
echo -e " ${YELLOW}Memory:${NC}     $MEMORY"
echo -e " ${BLUE}--------------------${NC}"
echo
EOF
if ! command -v xdpyinfo &> /dev/null
then
    RESOLUTION="N/A (xdpyinfo not found)"
else
    RESOLUTION=$(xdpyinfo | grep dimensions | awk '{print $2}')
fi
if command -v dpkg &> /dev/null; then
    PACKAGES=$(dpkg -l | grep ^ii | wc -l)
    PKG_MANAGER="dpkg"
elif command -v rpm &> /dev/null; then
    PACKAGES=$(rpm -qa | wc -l)
    PKG_MANAGER="klp"
elif command -v pacman &> /dev/null; then
    PACKAGES=$(pacman -Qq | wc -l)
    PKG_MANAGER="pacman"
else
    PACKAGES="N/A"
    PKG_MANAGER="Unknown"
fi
OS=$(grep PRETTY_NAME /etc/os-release | cut -d'=' -f2 | tr -d '"')
KERNEL=$(uname -r)
UPTIME=$(uptime -p | sed 's/up //g')
SHELL=$(basename "$SHELL")
CPU=$(grep "model name" /proc/cpuinfo | head -n 1 | cut -d':' -f2 | sed 's/^ *//')
GPU=$(lspci | grep -i vga | cut -d':' -f3 | sed 's/^ *//')
MEMORY=$(free -h | awk '/Mem:/ {print $3 "/" $2}')
clear
nudleos_ascii
echo -e " ${GREEN}NudleOS${NC}"
echo -e " ${BLUE}--------------------${NC}"
echo -e " ${YELLOW}OS:${NC}         $OS"
echo -e " ${YELLOW}Kernel:${NC}     $KERNEL"
echo -e " ${YELLOW}Uptime:${NC}     $UPTIME"
echo -e " ${YELLOW}Packages:${NC}   $PACKAGES ($PKG_MANAGER)"
echo -e " ${YELLOW}Shell:${NC}      $SHELL"
echo -e " ${YELLOW}Resolution:${NC} $RESOLUTION"
echo -e " ${YELLOW}CPU:${NC}        $CPU"
echo -e " ${YELLOW}GPU:${NC}        $GPU"
echo -e " ${YELLOW}Memory:${NC}     $MEMORY"
echo -e " ${BLUE}--------------------${NC}"