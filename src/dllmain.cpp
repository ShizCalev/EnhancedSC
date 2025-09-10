#include "common.hpp"
#include "config.hpp"
#include "logging.hpp"

///Resources
//#include "callbacks.h"
#include "hook_dlls.hpp"
#include "gamevars.hpp"

///Features
#include "intro_skip.hpp"
#include "custom_saves.hpp"
#include "pause_on_focus_loss.hpp"

///Fixes
#include "distance_culling.hpp"
#include "idle_timers.hpp"
#include "mouse_xbuttons_support.hpp"

//Warnings
#include "asi_loader_checks.hpp"
#include "submodule_initiailization.hpp"
#include "version.h"
#include "version_checker.hpp"

///WIP
//#include "msaa.hpp"
//#include "pause_on_focus_loss.hpp"
//#include "wireframe.hpp"


HWND MainHwnd = nullptr;

HMODULE baseModule = GetModuleHandle(NULL);

// Case-insensitive string comparison helper
static bool iequals(const std::string& a, const std::string& b) {
    return a.size() == b.size() &&
        std::equal(a.begin(), a.end(), b.begin(), [](char a, char b) {
            return std::tolower(static_cast<unsigned char>(a)) == std::tolower(static_cast<unsigned char>(b));
        });
}



void Initbinw32() //g_GameDLLs.binkw32
{
}

void InitDareAudio() //g_GameDLLs.DareAudio
{
}
void Initeax() //g_GameDLLs.eax
{
}
void InitEchelon() //g_GameDLLs.Echelon
{
}
void InitEchelonHUD() //g_GameDLLs.EchelonHUD
{
}
void InitEchelonIngredient() //g_GameDLLs.EchelonIngredient
{
}
void InitEchelonMenus() //g_GameDLLs.EchelonMenus
{
}
void InitEditor() //g_GameDLLs.Editor
{
}
void InitSNDdbgV() //g_GameDLLs.SNDdbgV
{
}
void InitSNDDSound3DDLL_VBR() //g_GameDLLs.SNDDSound3DDLL_VBR
{
}
void InitSNDext_VBR() //g_GameDLLs.SNDext_VBR
{
}
void InitUWindow() //g_GameDLLs.UWindow
{
}
void InitWinDrv() //g_GameDLLs.WinDrv
{}

void InitD3DDrv() //g_GameDLLs.D3DDrv
{
    INITIALIZE(g_MouseXButtonsSupport.Initialize());
}

void InitializeSubsystems()
{
    INITIALIZE(g_Logging.LogSysInfo());
    INITIALIZE(Init_ASILoaderSanityChecks());
    if (iequals(sExeName, "Splintercell.exe"))
    {
        INITIALIZE(g_GameDLLs.Initialize());
        /* At this point Core, Engine, GeometricEvent, and Window dll's are hooked.
        Things reliant on binkw32, D3DDrv, DareAudio, eax, Echelon, EchelonHUD, EchelonIngredient, EchelonMenus, Editor, SNDdbgV, SNDDSound3DDLL_VBR, SNDext_VBR, UWindow, and WinDrv
        need to be hooked via the above Init functions, as they're loaded after ASI loader finishes everything. */

        INITIALIZE(g_GameVars.Initialize());
        INITIALIZE(Config::Read()); 
        INITIALIZE(g_CustomSaves.Initialize());
        INITIALIZE(g_IdleTimers.Initialize());
        INITIALIZE(g_DistanceCulling.Initialize());
        INITIALIZE(g_IntroSkip.Initialize());

        INITIALIZE(CheckForUpdates());
    }
    else
    {
        spdlog::error("Game not detected. Please ensure you are running the correct game executable.");
    }
}

DWORD __stdcall Main(void*)
{
    g_Logging.initStartTime = std::chrono::high_resolution_clock::now();
    g_Logging.Initialize();
    INITIALIZE(InitializeSubsystems());
    return true;
}



BOOL APIENTRY DllMain(HMODULE hModule,
    DWORD  ul_reason_for_call,
    LPVOID lpReserved
)
{
    switch (ul_reason_for_call)
    {
    case DLL_PROCESS_ATTACH:
    {
        SetProcessDPIAware();

        HANDLE mainHandle = CreateThread(NULL, 0, Main, 0, CREATE_SUSPENDED, 0);
        if (mainHandle)
        {
            SetThreadPriority(mainHandle, THREAD_PRIORITY_TIME_CRITICAL); // set our Main thread priority higher than the games thread
            ResumeThread(mainHandle);
            CloseHandle(mainHandle);
        }
        break;

    }
    case DLL_THREAD_ATTACH:
    case DLL_THREAD_DETACH:
    case DLL_PROCESS_DETACH:
        break;
    }
    return TRUE;
}
