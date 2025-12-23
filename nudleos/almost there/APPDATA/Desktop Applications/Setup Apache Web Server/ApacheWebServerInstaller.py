import os
import subprocess

def install_apache():
    try:
        subprocess.run(["sudo", "apt-get", "update", "-y"], check=True)
        subprocess.run(["sudo", "apt-get", "install", "apache2", "-y"], check=True)
        subprocess.run(["sudo", "systemctl", "enable", "apache2"], check=True)
        subprocess.run(["sudo", "systemctl", "start", "apache2"], check=True)
        print("Apache2 installed successfully!")
    except subprocess.CalledProcessError as e:
        print(f"Error installing Apache2: {e}")
    except FileNotFoundError:
        print("Error: apt-get command not found. Please make sure it is installed.")
if __name__ == "__main__":
    install_apache()
def configure_firewall():
    try:
        subprocess.run(["sudo", "ufw", "allow", "Apache"], check=True)
        print("Firewall configured to allow Apache traffic.")
    except subprocess.CalledProcessError as e:
        print(f"Error configuring firewall: {e}")
    except FileNotFoundError:
        print("Error: ufw command not found. Please make sure it is installed and enabled.")
if __name__ == "__main__":
    install_apache()
    configure_firewall()
def check_apache_status():
    try:
        status = subprocess.run(["sudo", "systemctl", "status", "apache2"], capture_output=True, text=True, check=True)
        print("Apache2 status:")
        print(status.stdout)
    except subprocess.CalledProcessError as e:
        print(f"Error checking Apache2 status: {e}")
        print(e.stderr)
    except FileNotFoundError:
        print("Error: systemctl command not found. Please make sure it is installed.")
if __name__ == "__main__":
    install_apache()
    configure_firewall()
    check_apache_status()
def restart_apache():
    try:
        subprocess.run(["sudo", "systemctl", "restart", "apache2"], check=True)
        print("Apache2 restarted successfully!")
    except subprocess.CalledProcessError as e:
        print(f"Error restarting Apache2: {e}")
    except FileNotFoundError:
        print("Error: systemctl command not found. Please make sure it is installed.")
if __name__ == "__main__":
    install_apache()
    configure_firewall()
    check_apache_status()
    restart_apache()
def stop_apache():
    try:
        subprocess.run(["sudo", "systemctl", "stop", "apache2"], check=True)
        print("Apache2 stopped successfully!")
    except subprocess.CalledProcessError as e:
        print(f"Error stopping Apache2: {e}")
    except FileNotFoundError:
        print("Error: systemctl command not found. Please make sure it is installed.")
if __name__ == "__main__":
    install_apache()
    configure_firewall()
    check_apache_status()
    restart_apache()
    stop_apache()
def start_apache():
    try:
        subprocess.run(["sudo", "systemctl", "start", "apache2"], check=True)
        print("Apache2 started successfully!")
    except subprocess.CalledProcessError as e:
        print(f"Error starting Apache2: {e}")
    except FileNotFoundError:
        print("Error: systemctl command not found. Please make sure it is installed.")
if __name__ == "__main__":
    install_apache()
    configure_firewall()
    check_apache_status()
    restart_apache()
    stop_apache()
    start_apache()
def disable_apache():
    try:
        subprocess.run(["sudo", "systemctl", "disable", "apache2"], check=True)
        print("Apache2 disabled successfully!")
    except subprocess.CalledProcessError as e:
        print(f"Error disabling Apache2: {e}")
    except FileNotFoundError:
        print("Error: systemctl command not found. Please make sure it is installed.")

if __name__ == "__main__":
    install_apache()
    configure_firewall()
    check_apache_status()
    restart_apache()
    stop_apache()
    start_apache()
    disable_apache()
def enable_apache():
    try:
        subprocess.run(["sudo", "systemctl", "enable", "apache2"], check=True)
        print("Apache2 enabled successfully!")
    except subprocess.CalledProcessError as e:
        print(f"Error enabling Apache2: {e}")
    except FileNotFoundError:
        print("Error: systemctl command not found. Please make sure it is installed.")
if __name__ == "__main__":
    install_apache()
    configure_firewall()
    check_apache_status()
    restart_apache()
    stop_apache()
    start_apache()
    disable_apache()
    enable_apache()
def uninstall_apache():
    try:
        subprocess.run(["sudo", "systemctl", "stop", "apache2"], check=True)
        subprocess.run(["sudo", "apt-get", "remove", "apache2", "-y"], check=True)
        subprocess.run(["sudo", "apt-get", "autoremove", "-y"], check=True)
        print("Apache2 uninstalled successfully!")
    except subprocess.CalledProcessError as e:
        print(f"Error uninstalling Apache2: {e}")
    except FileNotFoundError:
        print("Error: apt-get or systemctl command not found. Please make sure they are installed.")
if __name__ == "__main__":
    install_apache()
    configure_firewall()
    check_apache_status()
    restart_apache()
    stop_apache()
    start_apache()
    disable_apache()
    enable_apache()
    uninstall_apache()