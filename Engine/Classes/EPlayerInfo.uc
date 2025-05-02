//=============================================================================
// EPlayerInfo.
//=============================================================================
class EPlayerInfo extends Actor 
	  config(SplinterCellUser)
      //config(Enhanced) // Joshua - Class, configurable in Enhanced config
	  native;

/*-----------------------------------------------------------------------------
                      T Y P E   D E F I N I T I O N S 
-----------------------------------------------------------------------------*/
//struct SaveGameInfo
//{
//	var String	Name;
//    var String	Date;
//    var String	Time;
//	var Texture	ScreenShot;
//};

/*-----------------------------------------------------------------------------
                   I N S T A N C E   V A R I A B L E S
-----------------------------------------------------------------------------*/
var config string PlayerName;
var config int    ControllerScheme;
var config int    Difficulty; 
var config string GameSave[3];
var config string GameSaveRealMap[3];
var config int    MapCompleted;
var config string UnlockedMap[14];
var config bool   bDownloadableMapsExists;
var config string GamePath;
var config int    PosX;
var config int    PosY;
var config int    MusicVol;
var config int    VoiceVol;
var config int    SfxVol;
var config int    AmbVol;
var config int    iLastSaveType;
var config bool   bValidProfile;
// Joshua - Enable once Engine package gets fixed
//var config bool   bUnlockAllMaps; // Joshua - New variable to unlock all maps in the game

defaultproperties
{
    bHidden=true
}