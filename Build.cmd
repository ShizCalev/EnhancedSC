@echo off
setlocal

set sysDir=%~dp0System

echo Deleting UnrealScript packages...

del "%sysDir%\Echelon.u"
del "%sysDir%\EchelonIngredient.u"
del "%sysDir%\EchelonCharacter.u"
del "%sysDir%\EchelonHUD.u"
del "%sysDir%\EchelonPattern.u"

:: Not working yet, currently using v1.3
:: del "%sysDir%\Engine.u"
:: del "%sysDir%\UWindow.u"

:: Not needed yet, currently using v1.3
:: del "%sysDi%\Core.u"
:: del "%sysDir%\EchelonEffect.u"
:: del "%sysDir%\EchelonGameObject.u"
:: del "%sysDir%\EchelonMenus.u"
:: del "%sysDir%\Editor.u"
:: del "%sysDir%\UDebugMenu.u"

timeout /t 1 >nul

echo Building UnrealScript packages...
"%sysDir%\UCC.exe" make

timeout /t 1 >nul

endlocal