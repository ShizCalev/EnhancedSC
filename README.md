# <img src="https://github.com/user-attachments/assets/c8734b07-3c22-4896-9bd3-bb448db80901"> Enhanced SC
A major patch for the original Splinter Cell, fixing bugs and adding gameplay improvements.

For a full list of patch notes, refer to the [Patch Notes](PatchNotes.md) page.

[![Discord](https://img.shields.io/discord/1371978442194817254?color=%237289DA&label=Members&logo=discord&logoColor=white)](https://discord.gg/k6mZJcfjSh)

## Installation
The latest version of Enhanced SC can be found in the [Releases](https://github.com/Joshhhuaaa/EnhancedSC/releases) page. Please note that saves from Enhanced SC are not compatible with the original version of the game.

### Game Setup
- After downloading Enhanced SC, extract the contents to your Splinter Cell directory and overwrite all existing files when prompted.
- You can adjust additional settings in the Enhanced tab within the in-game settings.

> [!NOTE]
> Your original saves will not be deleted, but they will appear as missing. Enhanced intentionally hides them because they aren't compatible with this version.

## Linux/Steam Deck Installation
**This section is intended for Linux only, and should be skipped if installing on Windows.**

Download [Enhanced SC v1.2 Linux](https://github.com/Joshhhuaaa/EnhancedSC/releases/download/v1.2/Enhanced-SC-v1.2-Linux.7z) instead of the standard release. This version includes dgVoodoo v2.79.3 for Linux, since newer versions currently cause the game to crash.

Enhanced SC, [dgVoodoo2](https://github.com/dege-diosg/dgVoodoo2), [ThirteenAG Widescreen Fix](https://github.com/ThirteenAG/WidescreenFixesPack), and [Xidi](https://github.com/samuelgr/Xidi) won't load without a DLL override in your Wine prefix.

To add the DLL override in Steam, right-click the game in the library and select `Properties`.

In the General tab, add the following to the launch options:
```
WINEDLLOVERRIDES="D3D8,msacm32,msvfw32,dinput8=n,b" %command%
```

In the Compatibility tab, check `Force the use of a specific Steam Play compatibility tool` and select `Proton 10.0-1 (beta)`. Other versions may work, but this one has been tested.

<img src="https://github.com/user-attachments/assets/93d1d1f4-3c84-49e1-b481-621ecefe9061" width="640"/>

For more detailed instructions on how to override a DLL, refer to this [guide](https://cookieplmonster.github.io/setup-instructions/#proton-wine).

## Uninstallation
To manually remove Enhanced SC from your game installation:
- Navigate to the `System` folder, delete the `Enhanced` folder, `Engine.dll`, `EchelonHUD.dll`, and `Enhanced.ini`.
- Rename `Engine.dll.bak` to `Engine.dll` to restore the original file.
- Rename `EchelonHUD.dll.bak` to `EchelonHUD.dll` to restore the original file.

This patch also includes [dgVoodoo2](https://github.com/dege-diosg/dgVoodoo2), [ThirteenAG Widescreen Fix](https://github.com/ThirteenAG/WidescreenFixesPack), and [Xidi](https://github.com/samuelgr/Xidi).

#### dgVoodoo2
- Delete `D3D8.dll` and `dgVoodoo.conf`.

#### ThirteenAG Widescreen Fix
- Delete the `scripts` folder, `msacm32.dll`, and `msvfw32.dll`.
- Both Enhanced SC and ThirteenAG Widescreen Fix depend on `msacm32.dll` and `msvfw32.dll`. So, if you want Enhanced SC without ThirteenAG Widescreen Fix, just delete the `scripts` folder.

#### Xidi
- Delete `dinput8.dll` and `Xidi.ini`.
