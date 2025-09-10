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

    if (!Util::IsSteamOS() && !IsVCRuntimeInstalled())
    {
        MessageBoxA(NULL,
            "Microsoft Visual C++ 2015-2022 Redistributable (x86) is not installed.\n\nPlease install the required runtimes.",
            "Missing Runtime",
            MB_ICONERROR | MB_OK);
        return FreeLibraryAndExitThread(baseModule, 1);
    }

}
