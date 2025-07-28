#include "asi_loader_checks.hpp"
#include "common.hpp"
#include "spdlog/spdlog.h"

static bool IsVCRuntimeInstalled()
{
    HKEY hKey;
    DWORD installed = 0;
    DWORD size = sizeof(installed);

    // Just the subkey path, no root key in the string!
    const TCHAR* subKey = TEXT("SOFTWARE\\WOW6432Node\\Microsoft\\VisualStudio\\14.0\\VC\\Runtimes\\x86");

    if (RegOpenKeyEx(HKEY_LOCAL_MACHINE, subKey, 0, KEY_READ, &hKey) == ERROR_SUCCESS)
    {
        if (RegQueryValueEx(hKey, TEXT("Installed"), nullptr, nullptr, (LPBYTE)&installed, &size) == ERROR_SUCCESS)
        {
            RegCloseKey(hKey);
            return installed == 1;
        }
        RegCloseKey(hKey);
    }

    return false;
}

void Init_ASILoaderSanityChecks()
{
    //Don't simplify by removing filesystem::exists() from this check. While GetFileDescription does handle non-existent files own its own, checking filesystem::exists() first saves 400+ ms of initialization time
    if (std::filesystem::exists(sExePath / "d3d11.dll") && (Util::GetFileDescription((sExePath / "d3d11.dll").string()) == Util::GetFileDescription((sExePath / "winhttp.dll").string())))
    {
        AllocConsole();
        FILE* dummy;
        freopen_s(&dummy, "CONOUT$", "w", stdout);
        std::cout << "DUPLICATE MOD LOADER ERROR: Multiple ASI Loader .dll's detected! This can cause inconsistent bugs and crashes.\n";
        spdlog::error("DUPLICATE MOD LOADER ERROR: Multiple ASI Loader .dll installations detected! This can cause inconsistent bugs and crashes.");
        std::cout << "DUPLICATE MOD LOADER ERROR: Please delete d3d11.dll, it has been replaced by winhttp.dll & wininit.dll.\n";
        spdlog::error("DUPLICATE MOD LOADER ERROR: Please delete d3d11.dll, it has been replaced by winhttp.dll & wininit.dll.");
#ifndef _WIN32
        std::cout << "DUPLICATE MOD LOADER ERROR: Steam Deck / Linux users must also replace their Steam game launch paramaters with the following command:\n";
        spdlog::error("DUPLICATE MOD LOADER ERROR: Steam Deck / Linux users must also replace their Steam game launch paramaters with the following command:");
        std::cout << "`WINEDLLOVERRIDES=\"wininet,winhttp=n,b\" % command % `\n";
        spdlog::error("`WINEDLLOVERRIDES=\"wininet,winhttp=n,b\" % command % `");
#endif
        spdlog::info("----------");
    }
    Util::CheckForASIFiles(sFixName, true, true, nullptr); //Exit thread & warn the user if multiple copies of EnhancedSC are trying to initialize.

    if (!Util::IsSteamOS() && !IsVCRuntimeInstalled())
    {
        MessageBoxA(NULL,
            "Microsoft Visual C++ 2015-2022 Redistributable (x86) is not installed.\n\nPlease install the required runtimes.",
            "Missing Runtime",
            MB_ICONERROR | MB_OK);
        return FreeLibraryAndExitThread(baseModule, 1);
    }

}
