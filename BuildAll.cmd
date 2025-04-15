@echo off
setlocal

set sysDir=%~dp0System

echo Deleting UnrealScript packages...

del "%sysDi%\Core.u"
del "%sysDir%\Engine.u"
del "%sysDir%\Editor.u"
del "%sysDir%\EchelonEffect.u"
del "%sysDir%\Echelon.u"
del "%sysDir%\EchelonGameObject.u"
del "%sysDir%\EchelonIngredient.u"
del "%sysDir%\EchelonCharacter.u"
del "%sysDir%\EchelonHUD.u"
del "%sysDir%\EchelonPattern.u"
del "%sysDir%\UWindow.u"
del "%sysDir%\UDebugMenu.u"
del "%sysDir%\EchelonMenus.u"

timeout /t 1 >nul

echo Building UnrealScript packages...
"%sysDir%\UCC.exe" make

timeout /t 1 >nul

endlocal