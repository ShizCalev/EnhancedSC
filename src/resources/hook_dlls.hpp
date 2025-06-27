#pragma once
#include "stdafx.h"

class GameDLLs
{
public:
    void Initialize();
    HMODULE binkw32;
    HMODULE Core;
    HMODULE D3DDrv;
    HMODULE DareAudio;
    HMODULE eax;
    HMODULE Echelon;
    HMODULE EchelonHUD;
    HMODULE EchelonIngredient;
    HMODULE EchelonMenus;
    HMODULE Editor;
    HMODULE Engine;
    HMODULE GeometricEvent;
    HMODULE SNDdbgV;
    HMODULE SNDDSound3DDLL_VBR;
    HMODULE SNDext_VBR;
    HMODULE UWindow;
    HMODULE Window;
    HMODULE WinDrv;
};

inline GameDLLs g_GameDLLs;
