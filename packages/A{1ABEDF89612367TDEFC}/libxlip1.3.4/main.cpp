#define iopanel
#include <Windows.h>
#include <iostream>
#include <bit>
#include <limits>
#include "xlip1.h"
using namespace xlip;
using namespace std;
int libxlip() {
    std::cout << "LibXlip C++ File" << std::endl;
    const char * nuduri = "NUDURI";
    const char * nuduri1 = "nuduri1";
    std::string ps1;
    std::cout << "cmd>> ";
    std::getline(std::cin, ps1);
    while (!(std::cin >> ps1)) {
        std::cout << "Invalid input. Please enter a valid non-negative number: ";
        std::cin.clear();
        std::cin.ignore(std::numeric_limits<std::streamsize>::max(), '\n');
    }
    xlip::xliplib();
    return 0;
}