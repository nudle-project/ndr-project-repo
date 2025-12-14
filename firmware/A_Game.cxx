#include <windows.h>
#include <string>
#include <sstream>
#include <iostream> 

using namespace std;

const int IDC_INPUT = 1001;
const int IDC_FETCH_BUTTON = 1002;
const int IDC_RESULTS = 1003;
const int HIDE_DELAY = 1000;

HWND g_hInput;
HWND g_hFetchButton;
HWND g_hResults;
HFONT g_hFontTitle;
HFONT g_hFontMono;

string fetch_repo_details(const string& repo_path) {
    if (repo_path.empty()) {
        return "Please enter a repository path (e.g., microsoft/vscode).";
    }

    size_t slash_pos = repo_path.find('/');
    string owner = (slash_pos != string::npos) ? repo_path.substr(0, slash_pos) : "user";
    string name = (slash_pos != string::npos) ? repo_path.substr(slash_pos + 1) : "repo";
    
    if (repo_path == "microsoft/vscode") {
        return 
            "Repository: microsoft/vscode\r\n"
            "Owner: Microsoft\r\n"
            "Description: Visual Studio Code - Open Source\r\n"
            "Language: TypeScript\r\n"
            "Stars: ~180,000\r\n"
            "Forks: ~36,800\r\n"
            "License: MIT\r\n"
            "\r\n"
            "This information is simulated and reflects public details about the VS Code repository.";
    } 
    
    if (slash_pos != string::npos) {
        stringstream ss;
        ss << "--- Fetched Details ---\r\n"
           << "Repository: " << repo_path << "\r\n"
           << "Owner: " << owner << "\r\n"
           << "Description: A fantastic new project by " << owner << ".\r\n"
           << "Language: C++\r\n"
           << "Stars: 1024\r\n"
           << "Forks: 512\r\n"
           << "License: Apache 2.0\r\n"
           << "\r\n"
           << "Note: Data for '" << repo_path << "' is simulated.";
        return ss.str();
    } else {
        return "Invalid format: Please use 'owner/repo' format.";
    }
}

LRESULT CALLBACK WindowProc(HWND hWnd, UINT uMsg, WPARAM wParam, LPARAM lParam) {
    switch (uMsg) {
        case WM_CREATE: {
            g_hFontTitle = CreateFontA(20, 0, 0, 0, FW_BOLD, FALSE, FALSE, FALSE, DEFAULT_CHARSET, OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS, DEFAULT_QUALITY, DEFAULT_PITCH | FF_SWISS, "Arial");
            g_hFontMono = CreateFontA(16, 0, 0, 0, FW_NORMAL, FALSE, FALSE, FALSE, DEFAULT_CHARSET, OUT_DEFAULT_PRECIS, CLIP_DEFAULT_PRECIS, DEFAULT_QUALITY, DEFAULT_PITCH | FF_MODERN, "Consolas");

            HWND hLabel = CreateWindowA("STATIC", "Repo (user/repo):", WS_CHILD | WS_VISIBLE, 
                                     20, 20, 150, 20, hWnd, NULL, NULL, NULL);
            SendMessageA(hLabel, WM_SETFONT, (WPARAM)g_hFontTitle, TRUE);

            g_hInput = CreateWindowA("EDIT", "microsoft/vscode", WS_CHILD | WS_VISIBLE | WS_BORDER | ES_AUTOHSCROLL,
                                     170, 20, 250, 25, hWnd, (HMENU)IDC_INPUT, NULL, NULL);
            SendMessageA(g_hInput, WM_SETFONT, (WPARAM)g_hFontMono, TRUE);

            g_hFetchButton = CreateWindowA("BUTTON", "Fetch Details", WS_CHILD | WS_VISIBLE | BS_PUSHBUTTON,
                                            430, 20, 120, 25, hWnd, (HMENU)IDC_FETCH_BUTTON, NULL, NULL);
            SendMessageA(g_hFetchButton, WM_SETFONT, (WPARAM)g_hFontTitle, TRUE);

            g_hResults = CreateWindowA("EDIT", "Enter a GitHub repository (e.g., microsoft/vscode) and click 'Fetch Details' to see simulated data.", 
                                      WS_CHILD | WS_VISIBLE | WS_BORDER | WS_VSCROLL | ES_MULTILINE | ES_READONLY | ES_AUTOVSCROLL,
                                      20, 60, 530, 300, hWnd, (HMENU)IDC_RESULTS, NULL, NULL);
            SendMessageA(g_hResults, WM_SETFONT, (WPARAM)g_hFontMono, TRUE);
            
            return 0;
        }

        case WM_COMMAND: {
            if (LOWORD(wParam) == IDC_FETCH_BUTTON) {
                char repo_buffer[256];
                GetWindowTextA(g_hInput, repo_buffer, 256);
                string repo_path = repo_buffer;
                
                size_t first = repo_path.find_first_not_of(" \t\n\r");
                if (first == string::npos) {
                    repo_path = "";
                } else {
                    size_t last = repo_path.find_last_not_of(" \t\n\r");
                    repo_path = repo_path.substr(first, (last - first + 1));
                }

                string result = fetch_repo_details(repo_path);

                SetWindowTextA(g_hResults, result.c_str());
            }
            return 0;
        }

        case WM_SIZE: {
            int width = LOWORD(lParam);
            int height = HIWORD(lParam);

            SetWindowPos(g_hInput, NULL, 170, 20, width - 200, 25, SWP_NOZORDER);
            SetWindowPos(g_hFetchButton, NULL, width - 130, 20, 110, 25, SWP_NOZORDER);
            SetWindowPos(g_hResults, NULL, 20, 60, width - 40, height - 80, SWP_NOZORDER);
            return 0;
        }

        case WM_DESTROY: {
            PostQuitMessage(0);
            return 0;
        }
    }
    return DefWindowProc(hWnd, uMsg, wParam, lParam);
}

int WINAPI WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR lpCmdLine, int nCmdShow) {
    const char CLASS_NAME[] = "GitHubBrowserClass";
    
    WNDCLASSA wc = { };
    wc.lpfnWndProc = WindowProc;
    wc.hInstance = hInstance;
    wc.lpszClassName = CLASS_NAME;
    wc.hbrBackground = (HBRUSH)(COLOR_WINDOW + 1);

    RegisterClassA(&wc);

    int initial_width = 570; 
    int initial_height = 430;

    HWND hWnd = CreateWindowExA(0, CLASS_NAME, "GitHub Repository Browser", WS_OVERLAPPEDWINDOW | WS_CLIPCHILDREN,
                                CW_USEDEFAULT, CW_USEDEFAULT, initial_width, initial_height,
                                NULL, NULL, hInstance, NULL);

    if (hWnd == NULL) {
        return 0;
    }

    ShowWindow(hWnd, nCmdShow);
    UpdateWindow(hWnd);

    MSG msg = { };
    while (GetMessage(&msg, NULL, 0, 0)) {
        TranslateMessage(&msg);
        DispatchMessage(&msg);
    }

    return 0;
}