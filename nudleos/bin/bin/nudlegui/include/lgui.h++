#pragma once

#include <iostream>
#include <vector>
#include <string>
#include <algorithm>
namespace lgui
{
    struct Button
    {
        int x, y, width, height;
        std::string text;
        void (*callback)();
    };
    struct Window
    {
        int x, y, width, height;
        std::string title;
        std::vector<Button> buttons;
        bool is_draggable;
        bool is_dragging;
        int drag_offset_x, drag_offset_y;
        bool is_visible;

        Window(int x, int y, int width, int height, std::string title) : x(x), y(y), width(width), height(height), title(title),
                                                                         is_draggable(true), is_dragging(false), drag_offset_x(0), drag_offset_y(0), is_visible(true) {}

        void addButton(const Button &button)
        {
            buttons.push_back(button);
        }
    };
    std::vector<Window> windows;
    Window &createWindow(int x, int y, int width, int height, const std::string &title)
    {
        windows.emplace_back(x, y, width, height, title);
        return windows.back();
    }
    void handleMouseClick(int mouse_x, int mouse_y)
    {
        for (auto it = windows.rbegin(); it != windows.rend(); ++it)
        {
            Window &window = *it;
            if (!window.is_visible)
                continue;
            if (mouse_x >= window.x && mouse_x <= window.x + window.width &&
                mouse_y >= window.y && mouse_y <= window.y + window.height)
            {
                if (window.is_draggable && mouse_y >= window.y && mouse_y <= window.y + 20)
                {
                    window.is_dragging = true;
                    window.drag_offset_x = mouse_x - window.x;
                    window.drag_offset_y = mouse_y - window.y;
                    return;
                }
                for (auto &button : window.buttons) {            
                    if (mouse_x >= button.x + window.x && mouse_x <= button.x + window.x + button.width &&
                        mouse_y >= button.y + window.y && mouse_y <= button.y + window.y + button.height)
                    {
                        if (button.callback)
                        {
                            button.callback();
                        }
                        return;
                    }
                }
                std::rotate(windows.rbegin(), std::next(it), windows.rend());
                return;
            }
        }
    }
    void handleMouseMove(int mouse_x, int mouse_y)
    {
        for (auto &window : windows)
        {
            if (window.is_dragging)
            {
                window.x = mouse_x - window.drag_offset_x;
                window.y = mouse_y - window.drag_offset_y;
                break;
            }
        }
    }
    void handleMouseRelease()
    {
        for (auto &window : windows)
        {
            window.is_dragging = false;
        }
    }
    void drawGUI()
    {
        for (const auto &window : windows)
        {
            if (!window.is_visible)
                continue;
            std::cout << "Drawing Window: " << window.title << " at (" << window.x << ", " << window.y << ") Size: (" << window.width << ", " << window.height << ")" << std::endl;
            std::cout << "  Drawing Title Bar: " << window.title << std::endl;
            for (const auto &button : window.buttons)
            {
                std::cout << "  Drawing Button: '" << button.text << "' at (" << button.x << ", " << button.y << ") Size: (" << button.width << ", " << button.height << ")" << std::endl;
            }
        }
    }
}
