#include "hook_dlls.hpp"

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
    if (Engine) spdlog::info("GameDLLs: Engine.dll loaded at 0x{:x}", (uintptr_t)Engine);
    if (Core) spdlog::info("GameDLLs: Core.dll loaded at 0x{:x}", (uintptr_t)Core);
    if (GeometricEvent) spdlog::info("GameDLLs: GeometricEvent.dll loaded at 0x{:x}", (uintptr_t)GeometricEvent);
    if (Window) spdlog::info("GameDLLs: Window.dll loaded at 0x{:x}", (uintptr_t)Window);


    if (binkw32) spdlog::info("GameDLLs: binkw32.dll loaded at 0x{:x}", (uintptr_t)binkw32);
    if (D3DDrv) spdlog::info("GameDLLs: D3DDrv.dll loaded at 0x{:x}", (uintptr_t)D3DDrv);
    if (DareAudio) spdlog::info("GameDLLs: DareAudio.dll loaded at 0x{:x}", (uintptr_t)DareAudio);
    if (eax) spdlog::info("GameDLLs: eax.dll loaded at 0x{:x}", (uintptr_t)eax);
    if (Echelon) spdlog::info("GameDLLs: Echelon.dll loaded at 0x{:x}", (uintptr_t)Echelon);
    if (EchelonHUD) spdlog::info("GameDLLs: EchelonHUD.dll loaded at 0x{:x}", (uintptr_t)EchelonHUD);
    if (EchelonIngredient) spdlog::info("GameDLLs: EchelonIngredient.dll loaded at 0x{:x}", (uintptr_t)EchelonIngredient);
    if (EchelonMenus) spdlog::info("GameDLLs: EchelonMenus.dll loaded at 0x{:x}", (uintptr_t)EchelonMenus);
    if (Editor) spdlog::info("GameDLLs: Editor.dll loaded at 0x{:x}", (uintptr_t)Editor);
    if (SNDdbgV) spdlog::info("GameDLLs: SNDdbgV.dll loaded at 0x{:x}", (uintptr_t)SNDdbgV);
    if (SNDDSound3DDLL_VBR) spdlog::info("GameDLLs: SNDDSound3DDLL_VBR.dll loaded at 0x{:x}", (uintptr_t)SNDDSound3DDLL_VBR);
    if (SNDext_VBR) spdlog::info("GameDLLs: SNDext_VBR.dll loaded at 0x{:x}", (uintptr_t)SNDext_VBR);
    if (UWindow) spdlog::info("GameDLLs: UWindow.dll loaded at 0x{:x}", (uintptr_t)UWindow);
    if (WinDrv) spdlog::info("GameDLLs: WinDrv.dll loaded at 0x{:x}", (uintptr_t)WinDrv);


}
