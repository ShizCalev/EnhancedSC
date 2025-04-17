# Enhanced SC Patch Notes

### Gameplay
- Frag Grenades have been increased from 100 to 150 damage, making them lethal to enemies on Hard difficulty.
- The explosion delay for Wall Mines has been reduced from 1.75 seconds to 0.50 seconds to prevent running past the mine before it explodes.
- Improved the Optic Cable's enter and exit sounds, as the exit sound was previously missing from the PC version.
- Added an option to use the crouch key to drop similar to Pandora Tomorrow.
- Added an option to use any vision mode in Optic Cables similar to Pandora Tomorrow.
- Added an option to use the left and right movement keys to activate Open Door Stealth instead of the back movement key. This is recommended for keyboard users, as the back movement key previously scrolled through options when trying to use Open Door Stealth.
- Added an option to enable Thermal Vision across all levels, regardless of their original settings.
- Added an option to override Sam's mesh across all levels.
- Added an option to toggle the HUD on or off. `Enhanced.ini` controls the initial setting. While in-game, you can type `ToggleHUD` into the console or bind it to a key in `SplinterCellUser.ini`.
- The initial speed at the start of missions is now set to the highest value.
- Xbox renderer textures have been restored to bring lighting closer to the Xbox version.
- Checkpoints from the Xbox version of the game have been restored.
- Improved controller support, now more closely aligned with the Xbox version.  
  - Vibration is not supported due to the game using DirectInput.
  - There is some visual errors on the Xbox inventory and pause screen when using ThirteenAG's Widescreen Fix.
- Added an option to change the default controller layout with alternate control schemes.

### Maps
- Police Station now uses the Xbox version of the level which has lighting improvements.
- Oil Refinery now uses the Xbox version of the level which has lighting and mesh improvements.
- Abattoir now uses the Xbox version of the level which has mesh improvements.
- Chinese Embassy 2 now uses the Xbox version of the level which has mesh improvements.
- Vselka Infiltration has restored the PlayerStart position from the Xbox version.
- Vselka Infiltration has restored a camera in the control room that was present in the Xbox version.
- Vselka Infiltration now transitions directly into Vselka Submarine as a single mission.
- Included experimental versions of Nuclear Power Plant and Severonickel that can be played.
  - Using the in-game console, use `NPP1`, `NPP2`, `SEV1`, and `SEV2` to access each level.
  - Both cut levels currently lack level-specific audio due to incompatible Xbox sound files.
  - In Nuclear Power Plant, you may experience a crash if an NPP employee triggers an alarm.
  - In Nuclear Power Plant, you may need to Quick Save and Quick Load after triggering the meltdown to ensure the event works correctly.
  - The first part of Severonickel is currently unplayable, missing StaticMeshes and NPCs, but is available for exploration.
  - The second part of Severonickel now starts the player with the same equipment as the first part.

### Miscellaneous
- Save games now use a new file extension for Enhanced to prevent incompatible saves from the original game from being displayed.
- Localization fixes, including typo corrections and consistency improvements.
- Includes newly recreated loading screens by [cazzhmir](https://www.youtube.com/@cazzhmir) to improve the accuracy of the story.
- [dgVoodoo2](https://github.com/dege-diosg/dgVoodoo2) is included to restore Shadow Buffer rendering and set a 60 FPS cap.
- [ThirteenAG](https://github.com/ThirteenAG/WidescreenFixesPack) Widescreen Fix is included for widescreen support.
- [Xidi](https://github.com/samuelgr/Xidi) is included to improve compatibility for XInput-based controllers.
