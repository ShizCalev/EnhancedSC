# <img src="https://i.imgur.com/rHJtwEB.png"> Enhanced SC
A major patch for the original Splinter Cell, fixing bugs and adding gameplay improvements.

For a full list of patch notes, refer to the [Patch Notes](PatchNotes.md) page.

## Installation
The latest version of Enhanced SC can be found in the [Releases](https://github.com/Joshhhuaaa/EnhancedSC/releases) page. Please note that saves from Enhanced SC are not compatible with the original version of the game.

### Game Setup
- After downloading Enhanced SC, extract the contents to your Splinter Cell directory and overwrite all existing files when prompted.
- You can adjust additional settings in `Enhanced.ini` located in the System folder.

> [!NOTE]
> Your original saves will not be deleted, but they will appear as missing. Enhanced intentionally hides them because they aren't compatible with this version.

## Linux Installation
On Linux, you need to perform a DLL override in your Wine prefix to properly load Enhanced SC and [ThirteenAG Widescreen Fix](https://github.com/ThirteenAG/WidescreenFixesPack).

To add the DLL override in Steam, right-click the game in the library and select `Properties`.

In the General tab, add the following to the launch options:
```
WINEDLLOVERRIDES="msacm32,msvfw32=n,b" %command% -shadowmode=projector
```
In the Compatibility tab, check `Force the use of a specific Steam Play compatibility tool` and select `Proton 9.0-4`. Other versions might work, but this one has been tested and confirmed to be reliable.

<img src="https://github.com/user-attachments/assets/8082d3c8-f5bb-464a-8432-2e66e5ed803e" width="640"/>

Unfortunately, [Xidi](https://github.com/samuelgr/Xidi) currently causes the game to crash on Linux, so controller support isn't working yet. As a result, `dinput8` will not be included in the DLL override.

For more detailed instructions on how to override a DLL, refer to this [guide](https://cookieplmonster.github.io/setup-instructions/#proton-wine).

## Uninstallation
To manually remove Enhanced SC from your game installation:
- Navigate to the `System` folder, delete the `Enhanced` folder, `Engine.dll`, and `Enhanced.ini`.
- Rename `Engine.dll.bak` to `Engine.dll` to restore the original file.

> [!NOTE]
> Ubisoft Connect and GOG already install the game with the latest v1.3 patch by default. However, Enhanced SC will update all game installations to v1.3 to ensure compatibility, and this change cannot be undone.

This patch also includes [dgVoodoo2](https://github.com/dege-diosg/dgVoodoo2), [ThirteenAG Widescreen Fix](https://github.com/ThirteenAG/WidescreenFixesPack), and [Xidi](https://github.com/samuelgr/Xidi)

#### dgVoodoo2
- Delete `D3D8.dll` and `dgVoodoo.conf`.

#### ThirteenAG Widescreen Fix
- Delete the `scripts` folder, `msacm32.dll`, and `msvfw32.dll`.
- Both Enhanced SC and ThirteenAG Widescreen Fix depend on `msacm32.dll` and `msvfw32.dll`. So, if you want Enhanced SC without ThirteenAG Widescreen Fix, just delete the `scripts` folder.

#### Xidi
- Delete `dinput8.dll` and `Xidi.ini`.
