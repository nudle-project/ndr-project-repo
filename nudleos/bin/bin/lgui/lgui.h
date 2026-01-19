#include <sys/stat.h>
#include <algorithm>
#include <any>
#include <iostream>
#include <fstream>
#include <filesystem>
using namespace std;
namespace lgui
{
    void draw_button()
    {
        std::cout << "          ", "#FFFFFF";
        std::cout << "  button  ", "#FFFFFF";
        std::cout << "          ", "#FFFFFF";
    }
    void window()
    {
        std::cout << "###########################################################";
        std::cout << "#                                                         #";
        std::cout << "#                                                         #";
        std::cout << "#                                                         #";
        std::cout << "#                                                         #";
        std::cout << "#                        window                           #";
        std::cout << "#                                                         #";
        std::cout << "#                                                         #";
        std::cout << "#                                                         #";
        std::cout << "#                                                         #";
        std::cout << "#                                                         #";
        std::cout << "###########################################################";
    }

}
int test()
{
    lgui::draw_button();
    lgui::window();
    return 0;
}