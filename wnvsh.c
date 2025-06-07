#include <windows.h>
#include <shellapi.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

int is_admin() {
    HKEY hKey;
    LONG result = RegOpenKeyExA(HKEY_LOCAL_MACHINE, "SOFTWARE", 0, KEY_WRITE, &hKey);
    if (result == ERROR_SUCCESS) {
        RegCloseKey(hKey);
        return 1;
    }
    return 0;
}

void run_ps_script(const char *script_name) {
    char command[1024];
    const char *base_url = "https://github.com/HimadriChakra12/wnvsh/raw/refs/heads/master/";

    snprintf(command, sizeof(command),
        "powershell -NoProfile -ExecutionPolicy Bypass -Command \"iwr -useb '%s%s' | iex\"",
        base_url, script_name);

    system(command);
}

void clear_screen() {
    system("cls");
}

void start_shell() {
    char input[128];
    printf("\033[1;35m[wnvsh]\033[0m Type 'Himinit', 'CTT', 'reg', 'gruvbox', 'pacman', 'install', 'spotify' 'git', 'pencil', 'mingw', 'idm', 'nvim', 'help', 'exit'\n");

    while (1) {
        printf("\033[1;32mwnvsh>\033[0m ");
        if (!fgets(input, sizeof(input), stdin)) break;

        input[strcspn(input, "\r\n")] = 0;

        if (strcmp(input, "exit") == 0) break;

        else if (strcmp(input, "reg") == 0) run_ps_script("Wfile/reg.ps1");
        else if (strcmp(input, "gruvbox") == 0) run_ps_script("Wfile/gruvbox.ps1");

        else if (strcmp(input, "pencil") == 0) run_ps_script("pencil/pencil.ps1");

        else if (strcmp(input, "mingw") == 0) run_ps_script("mingw/mingw.ps1");

        else if (strcmp(input, "idm") == 0) run_ps_script("IDM/idm.ps1");

        else if (strcmp(input, "spotify") == 0) run_ps_script("spotify/spotify.ps1");

        else if (strcmp(input, "himinit") == 0) run_ps_script("himinit/himinit.ps1");

        else if (strcmp(input, "install") == 0) run_ps_script("pack/install.ps1");

        else if (strcmp(input, "git") == 0) run_ps_script("git/git.ps1");

        else if (strcmp(input, "nvim") == 0) run_ps_script("nvim/himnvimplugins.ps1");

        else if (strcmp(input, "help") == 0) {
            printf("\033[1;35m[wnvsh]\033[0m Type 'CTT', 'reg', 'gruvbox', 'pacman', 'install', 'git', 'pencil', 'mingw', 'idm', 'nvim'\n");
        }

        else if (strcmp(input, "pacman") == 0) {
            printf("\033[1;36mpack: All Package Manager\033[0m\n");
            printf("\033[1;36mpackw: Winget\033[0m\n");
            printf("\033[1;36mpackcs: Choco + Scoop\033[0m\n");
            printf("\033[1;36mpackconf: Adding Package Configd\033[0m\n");
        }
        else if (strcmp(input, "pack") == 0) run_ps_script("pack/pac.ps1");
        else if (strcmp(input, "packw") == 0) run_ps_script("pack/winget.ps1");
        else if (strcmp(input, "packcs") == 0) run_ps_script("pack/choco-scoop.ps1");
        else if (strcmp(input, "packconf") == 0) run_ps_script("pack/packsconfig.ps1");

        else if (strcmp(input, "CTT") == 0) {
            printf("\033[1;36mCTTS: CTT Standard Tweaks\033[0m\n");
            printf("\033[1;36mCTTA: CTT Advanced Tweaks\033[0m\n");
            printf("\033[1;36mCTTR: Remove MS Apps\033[0m\n");
            printf("\033[1;36mCTTSAR: Run All of the CTT[S-A-R]\033[0m\n");
        }
        else if (strcmp(input, "CTTS") == 0) run_ps_script("ctt/CTTS.ps1");
        else if (strcmp(input, "CTTA") == 0) run_ps_script("ctt/CTTA.ps1");
        else if (strcmp(input, "CTTR") == 0) run_ps_script("ctt/CTTR.ps1");
        else if (strcmp(input, "CTTSAR") == 0) run_ps_script("ctt/CTTSAR.ps1");

	    else if (strcmp(input, "clear") == 0) clear_screen();
        else if (strlen(input) > 0) printf("\033[1;31mUnknown command:\033[0m %s\n", input);
    }

    printf("\033[1;34m[F**k!?]\033[0m\n");
}

int main() {
    if (!is_admin()) {
        // Relaunch as admin using ShellExecute
        char exe_path[MAX_PATH];
        GetModuleFileNameA(NULL, exe_path, MAX_PATH);

        SHELLEXECUTEINFOA sei = { sizeof(sei) };
        sei.lpVerb = "runas";
        sei.lpFile = exe_path;
        sei.nShow = SW_SHOWNORMAL;

        if (!ShellExecuteExA(&sei)) {
            MessageBoxA(NULL, "UAC elevation was cancelled or failed.", "Error", MB_ICONERROR);
            return 1;
        }

        return 0; // Exit current instance
    }

    start_shell();
    return 0;
}
