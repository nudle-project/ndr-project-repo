#include <nudle-dsd.h>
#include <nudle-lts.h>
//The first int main here starts up the nudle-dsd kernel when booting (if installed) by using startup-dsd
int main() {
    // Call the startup function for nudle-dsd kernel
    startup_dsd();
    return 0;
}

// Dummy startup_dsd function for demonstration
void startup_dsd() {
    // Initialize DSD components
    // Load system modules
    // Start core services
    // Example:
    // NudleLTS::init();
    // DSDKernel::start();
}
int system() {
lts();
}