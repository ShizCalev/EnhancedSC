#include "hook_dlls.hpp"
#include "callbacks.h"
#include <spdlog/spdlog.h>

void GameDLLs::Initialize()
{
// Initialize all game DLL module handles to nullptr
    // Load game DLLs
    Core = GetModuleHandleA("Core.dll");
    Engine = GetModuleHandleA("Engine.dll");
    GeometricEvent = GetModuleHandleA("GeometricEvent.dll");
    Window = GetModuleHandleA("Window.dll");

    ///Todo: Set up callbacks for all these ones that get loaded after the ASI.
    binkw32 = GetModuleHandleA("binkw32.dll");
    D3DDrv = GetModuleHandleA("D3DDrv.dll");
    DareAudio = GetModuleHandleA("DareAudio.dll");
    eax = GetModuleHandleA("eax.dll");
    Echelon = GetModuleHandleA("Echelon.dll");
    EchelonHUD = GetModuleHandleA("EchelonHUD.dll");
    EchelonIngredient = GetModuleHandleA("EchelonIngredient.dll");
    EchelonMenus = GetModuleHandleA("EchelonMenus.dll");
    Editor = GetModuleHandleA("Editor.dll");
    SNDdbgV = GetModuleHandleA("SNDdbgV.dll");
    SNDDSound3DDLL_VBR = GetModuleHandleA("SNDDSound3DDLL_VBR.dll");
    SNDext_VBR = GetModuleHandleA("SNDext_VBR.dll");
    UWindow = GetModuleHandleA("UWindow.dll");
    WinDrv = GetModuleHandleA("WinDrv.dll");

    // Log loaded modules
    if (!Engine) spdlog::error("GameDLLs: Engine.dll failed to load.");
    if (!Core) spdlog::error("GameDLLs: Core.dll failed to load.");
    if (!GeometricEvent) spdlog::error("GameDLLs: GeometricEvent.dll failed to load.");
    if (!Window) spdlog::error("GameDLLs: Window.dll failed to load.");


    if (!binkw32) spdlog::error("GameDLLs: binkw32.dll failed to load.");
    if (!D3DDrv) spdlog::error("GameDLLs: D3DDrv.dll failed to load.");
    if (!DareAudio) spdlog::error("GameDLLs: DareAudio.dll failed to load.");
    if (!eax) spdlog::error("GameDLLs: eax.dll failed to load.");
    if (!Echelon) spdlog::error("GameDLLs: Echelon.dll failed to load.");
    if (!EchelonHUD) spdlog::error("GameDLLs: EchelonHUD.dll failed to load.");
    if (!EchelonIngredient) spdlog::error("GameDLLs: EchelonIngredient.dll failed to load.");
    if (!EchelonMenus) spdlog::error("GameDLLs: EchelonMenus.dll failed to load.");
    if (!Editor) spdlog::error("GameDLLs: Editor.dll failed to load.");
    if (!SNDdbgV) spdlog::error("GameDLLs: SNDdbgV.dll failed to load.");
    if (!SNDDSound3DDLL_VBR) spdlog::error("GameDLLs: SNDDSound3DDLL_VBR.dll failed to load.");
    if (!SNDext_VBR) spdlog::error("GameDLLs: SNDext_VBR.dll failed to load.");
    if (!UWindow) spdlog::error("GameDLLs: UWindow.dll failed to load.");
    if (!WinDrv) spdlog::error("GameDLLs: WinDrv.dll failed to load.");


}
