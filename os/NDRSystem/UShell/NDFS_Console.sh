#The proper shell application for the NDFS console (enter this with the default terminal by typing in tty_fs), the commands are shown in NDFSInfo.sh, in the current directory. Remember: See the contents of NDFSInfo.sh, everyone keeps using cd and ls and mkdir instead of the ACTUAL commands from that file!!!
# This script is the main entry point for the NDFS console.
# It will display a welcome message and then enter a loop to process user commands.
echo "Welcome to the NDFS Console!"
echo "Type 'help' for a list of available commands."
while true; do
    read -p "> " command
    case $command in
        "help")
            cat NDFSInfo.sh
            ;;
        "exit")
            echo "Exiting NDFS Console."
            break
            ;;
        *)
            echo "Unknown command: $command. Type 'help' for assistance."
            ;;
    esac
done
