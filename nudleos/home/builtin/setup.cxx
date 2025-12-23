#include <iostream>
#include <string>
#include <vector>
#include <chrono>
#include <thread>
#include <iomanip>
#include <cstdlib> 
#include <fstream> 

using namespace std;

// Utility function to create a directory using platform-specific commands
bool create_directory(const string& path) {
    int result;
    // Attempt to clear console for a clean start
    #ifdef _WIN32
        result = system(("mkdir " + path).c_str());
    #else
        // Works for Linux/macOS
        result = system(("mkdir -p " + path).c_str());
    #endif
    return result == 0;
}

// Utility function to create a file with content
void create_file(const string& filename, const string& content) {
    ofstream file(filename);
    if (file.is_open()) {
        file << content;
        file.close();
    }
}

// Function to simulate waiting and provide visual progress
void simulate_progress(const string& message, int duration_ms, int steps = 20) {
    cout << message << "..." << endl;
    for (int i = 0; i <= steps; ++i) {
        // Calculate the percentage
        int percent = (i * 100) / steps;
        
        // Draw the progress bar
        cout << "\r[";
        for (int j = 0; j < steps; ++j) {
            if (j < i) {
                cout << "#";
            } else {
                cout << "-";
            }
        }
        cout << "] " << setw(3) << percent << "% ";
        cout.flush();

        // Wait for a short time
        this_thread::sleep_for(chrono::milliseconds(duration_ms / steps));
    }
    cout << "\r[####################] 100% DONE" << endl << endl;
}

// Function to display a step title
void print_step_header(int step, const string& title) {
    cout << "\n==========================================" << endl;
    cout << "  STEP " << step << ": " << title << endl;
    cout << "==========================================" << endl;
}

// Simulated menu selection function
string get_user_choice(const string& prompt, const vector<string>& options) {
    int choice_num = -1;
    while (choice_num < 1 || choice_num > (int)options.size()) {
        cout << prompt << endl;
        for (size_t i = 0; i < options.size(); ++i) {
            cout << "  [" << i + 1 << "] " << options[i] << endl;
        }
        cout << "Enter number: ";
        if (!(cin >> choice_num)) {
            cin.clear();
            cin.ignore(numeric_limits<streamsize>::max(), '\n');
            choice_num = -1;
        }
    }
    cin.ignore(numeric_limits<streamsize>::max(), '\n');
    return options[choice_num - 1];
}

// NEW: Function to download and extract the GitHub repository
bool download_and_extract_repo(const string& install_path) {
    const string repo_url = "https://github.com/NudleOS/NudleOS/archive/refs/heads/main.zip";
    const string zip_filename = "NudleOS-main.zip";
    const string extracted_folder = "NudleOS-main";

    cout << "Downloading NudleOS repository..." << endl;
    
    // Use 'curl' to download the ZIP archive
    string download_cmd = "curl -L -s -o " + zip_filename + " " + repo_url;
    if (system(download_cmd.c_str()) != 0) {
        cout << "[ERROR] Download failed. Ensure 'curl' is installed and available." << endl;
        return false;
    }
    
    cout << "Download successful. Extracting files..." << endl;
    
    // Use 'unzip' to extract the contents
    string extract_cmd = "unzip -q " + zip_filename;
    if (system(extract_cmd.c_str()) != 0) {
        cout << "[ERROR] Extraction failed. Ensure 'unzip' is installed and available." << endl;
        // Attempt cleanup anyway
    }

    // Move contents from the temporary NudleOS-main folder to the final install_path
    cout << "Moving files into " << install_path << "..." << endl;
    #ifdef _WIN32
        // Windows command: move /Y NudleOS-main\* NudleOS_Installation\
        string move_cmd = "move /Y " + extracted_folder + "\\* " + install_path + " > nul";
        system(move_cmd.c_str());
        // Clean up temporary files and folder
        system(("rmdir /S /Q " + extracted_folder).c_str());
        system(("del " + zip_filename).c_str());
    #else
        // Linux/macOS command: mv NudleOS-main/* NudleOS_Installation/
        string move_cmd = "mv " + extracted_folder + "/* " + install_path + "/";
        system(move_cmd.c_str());
        // Clean up temporary files and folder
        system(("rm -rf " + extracted_folder).c_str());
        system(("rm " + zip_filename).c_str());
    #endif
    
    return true;
}

// Main installation simulation function
void run_installation() {
    // Attempt to clear console for a clean start
    #ifdef _WIN32
        system("cls");
    #else
        system("clear");
    #endif

    cout << R"(
  __  __         _ _         ____   ____  
 |  \/  | _   _ | | | _  _  / ___| / ___| 
 | |\/| || | | || | || || | \___ \| |     
 | |  | || |_| || | || |_| |  ___) | |___ 
 |_|  |_| \__,_||_|_| \__,_| |____/ \____|

    )" << endl;

    cout << "Welcome to the NudleOS Text-Based Installer!" << endl;
    cout << "Source: https://www.github.com/NudleOS/NudleOS" << endl;
    cout << "Installation target: ./NudleOS_Installation (Files will be downloaded)" << endl << endl;
    
    // --- Step 1: Locale Configuration ---
    print_step_header(1, "Locale Configuration");
    
    string language = get_user_choice("Select Installation Language:", 
        {"English (US)", "Spanish (Spain)", "French (Canada)", "Simulated Klingon"});
    
    string keyboard = get_user_choice("Select Keyboard Layout:", 
        {"us", "es", "fr", "de"});
    
    // --- Step 2: Disk Selection and Setup ---
    print_step_header(2, "Installation Target Setup");

    string install_path = "NudleOS_Installation";
    cout << "Preparing installation directory: " << install_path << endl;

    if (create_directory(install_path)) {
        cout << "Directory created successfully." << endl;
    } else {
        cout << "[WARNING] Directory creation failed. Proceeding, but cleanup may be required." << endl;
    }
    
    // --- Step 3: Package Download and Installation (REAL Download) ---
    print_step_header(3, "Downloading and Installing Base System");

    if (!download_and_extract_repo(install_path)) {
        cout << "\nFATAL: Installation cannot continue without downloading core files. Aborting." << endl;
        return;
    }
    
    cout << "\nCore files successfully installed from GitHub." << endl;

    // --- Step 4: System Configuration (Actual File Writing) ---
    print_step_header(4, "System Configuration");
    
    string hostname;
    cout << "Enter System Hostname (e.g., NudlePC): ";
    getline(cin, hostname);
    
    string username;
    cout << "Create User Account. Enter desired username: ";
    getline(cin, username);
    
    // Write configuration files based on user input
    string config_content = "LANGUAGE=" + language + "\nKEYMAP=" + keyboard + "\nHOSTNAME=" + hostname + "\n";
    create_file(install_path + "/etc/system.conf", config_content);
    
    // Create home directory for the user (assuming the repo structure might not include it)
    create_directory(install_path + "/home/" + username);
    create_file(install_path + "/home/" + username + "/welcome.txt", "Hello " + username + ", welcome to NudleOS!");
    
    simulate_progress("Generating final system configuration files...", 1500);

    // --- Step 5: Bootloader Installation ---
    print_step_header(5, "Bootloader Installation");
    
    cout << "Installing NudleBoot and configuring entries..." << endl;
    // Assume bootloader.cfg is now created/modified based on the downloaded files
    create_file(install_path + "/boot/bootloader.cfg", "[Boot]\nDefaultKernel=kernel.bin\nTimeout=5\nInstallationMethod=GitHub_Clone");
    simulate_progress("Configuring boot entries...", 3000);

    // --- Completion ---
    print_step_header(6, "Installation Complete!");
    cout << "NudleOS has been successfully installed in the '" << install_path << "' directory by downloading the latest version from GitHub!" << endl;
    cout << "System Hostname: " << hostname << endl;
    cout << "Primary User: " << username << endl;
    cout << "Repository: https://www.github.com/NudleOS/NudleOS" << endl;
    cout << "\nCheck the contents of the " << install_path << " folder to see the downloaded files." << endl;
    cout << "==========================================" << endl;
}

int main() {
    run_installation();
    return 0;
}