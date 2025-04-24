//=============================================================================
//  EPCControlsConfigArea.uc : Area containing controls for setting game keys
//  Copyright 2002 Ubi Soft, Inc. All Rights Reserved.
//
//  Revision history:
//    2002/10/27 * Created by Alexandre Dionne
//=============================================================================


class EPCControlsConfigArea extends UWindowDialogClientWindow;

var EPCOptionKeysListBox m_ListBox;
var EPCMessageBox        m_MessageBox;

var EPCHScrollBar        m_MouseSensitivityScroll;
var EPCCheckBox          m_InvertMouseButton;
var EPCCheckBox          m_FireEquipGun;

var bool                    m_bModified;    //A setting has changed
var bool					m_bFirstRefresh;


//==============================================================================
// 
//==============================================================================
function Created()
{
    SetAcceptsFocus();

	m_MessageBox = none;
	
    m_ListBox = EPCOptionKeysListBox(CreateControl( class'EPCOptionKeysListBox', 0, 0, WinWidth, WinHeight, self));            
    m_ListBox.bAlwaysBehind = true;
    InitOptionControls();
    m_ListBox.TitleFont=F_Normal; 
}

//==============================================================================
// 
//==============================================================================
function InitOptionControls()
{
	// MOVEMENT
	// add items in display order


    AddLineItem();
	AddTitleItem( Caps(Localize("Keys","Title_Move","Localization\\HUD")));
    AddLineItem();
    
	AddKeyItem( Localize("Keys","K_MoveForward","Localization\\HUD"),"MoveForward");
	AddKeyItem( Localize("Keys","K_MoveBackward","Localization\\HUD"), "MoveBackward");
    AddKeyItem( Localize("Keys","K_StrafeLeft","Localization\\HUD"),"StrafeLeft");
	AddKeyItem( Localize("Keys","K_StrafeRight","Localization\\HUD"), "StrafeRight");
    AddKeyItem( Localize("Keys","K_Duck","Localization\\HUD"),"Duck");
	AddKeyItem( Localize("Keys","K_Accel","Localization\\HUD"), "IncSpeed");
    AddKeyItem( Localize("Keys","K_Decell","Localization\\HUD"),"DecSpeed");
    AddKeyItem( Localize("Keys","k_BackToWall","Localization\\HUD"),"BackToWall");
	
    
	
    // Actions
	AddLineItem();
	AddTitleItem( Caps(Localize("Keys","Title_Actions","Localization\\HUD")));
    AddLineItem();

	AddKeyItem( Localize("Keys","K_Fire","Localization\\HUD"), "Fire");
	AddKeyItem( Localize("Keys","K_AltFire","Localization\\HUD"), "AltFire");
    AddKeyItem( Localize("Keys","K_Scope","Localization\\HUD"), "Scope");
    AddKeyItem( Localize("Keys","K_Jump","Localization\\HUD"), "Jump");
    AddKeyItem( Localize("Keys","K_Interaction","Localization\\HUD"), "Interaction");
    AddKeyItem( Localize("Keys","K_Reload","Localization\\HUD"), "ReloadGun");
    AddKeyItem( Localize("Keys","K_SwitchROF","Localization\\HUD"), "SwitchROF");    
    AddKeyItem( Localize("Keys","K_QuickSave","Localization\\HUD"), "QuickSave");
	AddKeyItem( Localize("Keys","K_QuickLoad","Localization\\HUD"), "QuickLoad");    
    AddKeyItem( Localize("Keys","K_NightVision","Localization\\HUD"), "DPadLeft");
    AddKeyItem( Localize("Keys","K_HeatVision","Localization\\HUD"), "DPadRight");
    AddKeyItem( Localize("Keys","K_Pause","Localization\\HUD"), "Pause");
    AddKeyItem( Localize("Keys","K_ToggleHUD","Localization\\HUD"), "ToggleHUD");
    AddLineItem();
	AddFireEquipControls();
    

    // Gadgets
	AddLineItem();    
	AddTitleItem( Caps(Localize("Keys","Title_Inventory","Localization\\HUD")));
    AddLineItem();    

	AddKeyItem( Localize("Keys","K_QuickInventory","Localization\\HUD"), "QuickInventory");
    //AddKeyItem( Localize("Keys","K_FullInventory","Localization\\HUD"), "FullInventory");	
    AddLineItem();


    // Mouse

    AddLineItem();    
	AddTitleItem( Caps(Localize("HUD","MOUSE","Localization\\HUD")));
    AddLineItem();    

    AddControls();
    AddLineItem();

}

//==============================================================================
// 
//==============================================================================
function SaveOptions()
{

    local EPCGameOptions GO;   
    local UWindowList ListItem;
	
    GO = class'Actor'.static.GetGameOptions();

    GO.MouseSensitivity = m_MouseSensitivityScroll.Pos;    
    GO.InvertMouse = m_InvertMouseButton.m_bSelected;
	GO.FireEquipGun = m_FireEquipGun.m_bSelected;

    // Reset all m_bDrawFlipped's
    for ( ListItem = m_ListBox.Items.Next; ListItem != None ; ListItem = ListItem.Next)
	{
		EPCOptionsKeyListBoxItem(ListItem).m_bDrawFlipped = false;
	}     

    GetPlayerOwner().SaveKeyboard();
}

//==============================================================================
// 
//==============================================================================
function Refresh()
{
    // MClarke - Patch 1 Beta 2 - Added false parameter 
    RefreshKeyList(false);

	m_bModified = false;
	m_bFirstRefresh = false;
}

//==============================================================================
// 
//==============================================================================
function ResetToDefault()
{
    local EPCGameOptions GO;
    local UWindowList ListItem;

    // Reset all m_bDrawFlipped's
    for ( ListItem = m_ListBox.Items.Next; ListItem != None ; ListItem = ListItem.Next)
	{
		EPCOptionsKeyListBoxItem(ListItem).m_bDrawFlipped = false;
	} 

    GO = class'Actor'.static.GetGameOptions();
    GetPlayerOwner().ResetKeyboard();
    GO.ResetControlsToDefault();
    Refresh();    

	GO.oldResolution = GO.Resolution;
	GO.oldEffectsQuality = GO.EffectsQuality;
	GO.oldShadowResolution = GO.ShadowResolution;
    GO.UpdateEngineSettings();       
}
//===============================================================================
// AddFireEquipControls
//===============================================================================
function AddFireEquipControls()
{
    // a hack to make displaying Controls Possible
    local EPCOptionsKeyListBoxItem NewItem;

    NewItem = EPCOptionsKeyListBoxItem(m_ListBox.Items.Append(m_ListBox.ListClass));
    NewItem.Caption			        = Localize("HUD","FIRETODRAWGUN","Localization\\HUD");
    NewItem.m_bIsNotSelectable  = true;

    m_FireEquipGun = EPCCheckBox(CreateControl( class'EPCCheckBox', 0, 0, 20, 18, self));    
    m_FireEquipGun.ImageX      = 5;
    m_FireEquipGun.ImageY      = 5;
    NewItem.m_Control = m_FireEquipGun;
    NewItem.bIsCheckBoxLine = true;
    m_ListBox.m_Controls[m_ListBox.m_Controls.Length] = m_FireEquipGun;
}

//===============================================================================
// AddControls
//===============================================================================
function AddControls()
{
    // a hack to make displaying Controls Possible
    local EPCOptionsKeyListBoxItem NewItem;

    NewItem = EPCOptionsKeyListBoxItem(m_ListBox.Items.Append(m_ListBox.ListClass));
    NewItem.Caption			        = Localize("HUD","INVERTMOUSE","Localization\\HUD");
    NewItem.m_bIsNotSelectable  = true;

    m_InvertMouseButton = EPCCheckBox(CreateControl( class'EPCCheckBox', 0, 0, 20, 18, self));    
    m_InvertMouseButton.ImageX      = 5;
    m_InvertMouseButton.ImageY      = 5;
    NewItem.m_Control = m_InvertMouseButton;
    NewItem.bIsCheckBoxLine = true;
    m_ListBox.m_Controls[m_ListBox.m_Controls.Length] = m_InvertMouseButton;

    NewItem = EPCOptionsKeyListBoxItem(m_ListBox.Items.Append(m_ListBox.ListClass));
    NewItem.Caption			        = Localize("HUD","MOUSESENSITIVITY","Localization\\HUD");
    NewItem.m_bIsNotSelectable  = true;       

    m_MouseSensitivityScroll   = EPCHScrollBar(CreateControl( class'EPCHScrollBar', 0, 0, 150, LookAndFeel.Size_HScrollbarHeight, self));
    m_MouseSensitivityScroll.SetScrollHeight(12);
    m_MouseSensitivityScroll.SetRange(1, 100, 1);

    NewItem.m_Control = m_MouseSensitivityScroll;
    m_ListBox.m_Controls[m_ListBox.m_Controls.Length] = m_MouseSensitivityScroll;
	
}

//===============================================================================
// AddKeyItem: Add a key item
//===============================================================================
function AddKeyItem( string _szTitle, string _szActionKey)
{
	local EPCOptionsKeyListBoxItem NewItem;

    NewItem = EPCOptionsKeyListBoxItem(m_ListBox.Items.Append(m_ListBox.ListClass));
    NewItem.Caption			        = _szTitle;
	NewItem.m_szActionKey			= _szActionKey;
	NewItem.HelpText	= GetLocKeyNameByActionKey( _szActionKey, false); // value to display "the key name"
    NewItem.HelpText2	= GetLocKeyNameByActionKey( _szActionKey, true); // value to display "the ALT key name"    
}

//===============================================================================
// RefreshKeyList: Refresh the list of key with the new value in Bindings[] array
//===============================================================================
function RefreshKeyList(bool bKeysOnly) // MClarke - Patch 1 Beta 2 - Added bool bKeysOnly parameter 
{
	local UWindowList ListItem;
	local string szTemp;
    local EPCGameOptions GO;   

	for ( ListItem = m_ListBox.Items.Next; ListItem != None ; ListItem = ListItem.Next)
	{
		if (!EPCOptionsKeyListBoxItem(ListItem).m_bIsNotSelectable)	
        {
	        EPCOptionsKeyListBoxItem(ListItem).HelpText = GetLocKeyNameByActionKey(EPCOptionsKeyListBoxItem(ListItem).m_szActionKey, false);
            EPCOptionsKeyListBoxItem(ListItem).HelpText2 = GetLocKeyNameByActionKey(EPCOptionsKeyListBoxItem(ListItem).m_szActionKey, true);
        }		
	}     
	
    // MClarke - Patch 1 Beta 2 - Added bKeysOnly check 
    if(!bKeysOnly)
    {
        GO = class'Actor'.static.GetGameOptions();

        m_MouseSensitivityScroll.Pos = Clamp(GO.MouseSensitivity, 1,100);    
        m_InvertMouseButton.m_bSelected = GO.InvertMouse;    
	    m_FireEquipGun.m_bSelected = GO.FireEquipGun;
    }
}

//===============================================================================
// GetLocKeyNameByActionKey: Get the localization name of the key to display
//===============================================================================
function string GetLocKeyNameByActionKey( string _szActionKey, bool bAltKey)
{
	local string szTemp;
	local BYTE Key;

	Key =    GetPlayerOwner().GetKey(_szActionKey, bAltKey);
	szTemp = GetPlayerOwner().GetEnumName( Key);
	szTemp = EPCConsole(Root.Console).ConvertKeyToLocalisation( Key, szTemp);

	return szTemp;
}

//===============================================================================
// AddLineItem: add a line item in the list
//===============================================================================
function AddLineItem()
{
	local EPCOptionsKeyListBoxItem NewItem;

    NewItem = EPCOptionsKeyListBoxItem(m_ListBox.Items.Append(m_ListBox.ListClass));
    NewItem.m_bIsNotSelectable  = true;
}

//===============================================================================
// AddTitleItem: Add a title item only
//===============================================================================
function AddTitleItem( string _szTitle)
{
	local EPCOptionsKeyListBoxItem NewItem;

    NewItem = EPCOptionsKeyListBoxItem(m_ListBox.Items.Append(m_ListBox.ListClass));    
    NewItem.Caption             = _szTitle;
    NewItem.m_bisTitle          = true;
    NewItem.m_bIsNotSelectable  = true;    
}
        
//==============================================================================
// KeyPressed -  Set the new key pressed  
//==============================================================================
function KeyPressed( int Key)
{
	local string szKeyName;
    local string szKeyToReplace;        // Tells whether we want to replace the primary or alt key
    local BYTE KeyOld;                  // Key which will be replaced
    local BYTE OtherKey;

    KeyOld = GetPlayerOwner().GetKey(EPCOptionsKeyListBoxItem(m_ListBox.SelectedItem).m_szActionKey, m_ListBox.m_bDoingAltMapping);
    OtherKey = GetPlayerOwner().GetKey(EPCOptionsKeyListBoxItem(m_ListBox.SelectedItem).m_szActionKey, !m_ListBox.m_bDoingAltMapping);
	szKeyToReplace = GetPlayerOwner().GetEnumName( KeyOld);

	// set the key and refresh the list
	szKeyName = GetPlayerOwner().GetEnumName(Key);

    if((OtherKey != 0) && (m_ListBox.m_bDoingAltMapping == (Key < OtherKey)))
    {
        EPCOptionsKeyListBoxItem(m_ListBox.SelectedItem).m_bDrawFlipped = !EPCOptionsKeyListBoxItem(m_ListBox.SelectedItem).m_bDrawFlipped;  
    }
    else
    {
        EPCOptionsKeyListBoxItem(m_ListBox.SelectedItem).m_bDrawFlipped = EPCOptionsKeyListBoxItem(m_ListBox.SelectedItem).m_bDrawFlipped;
    }
	
	GetPlayerOwner().SetKey( szKeyName@ EPCOptionsKeyListBoxItem(m_ListBox.SelectedItem).m_szActionKey, szKeyToReplace);
	
    // MClarke - Patch 1 Beta 2 - Added true parameter 
    RefreshKeyList(true);
}

//==============================================================================
// KeyDown - Handler for a key pressed, passes stuff to KeyPressed, if valid
//==============================================================================
function KeyDown(int Key, float X, float Y)
{
	local string szTemp, szKeyName;

	if(m_MessageBox != None)
    {
		// set the key and refresh the list
		szKeyName = GetPlayerOwner().GetEnumName(Key);
		
		//validates the windows key:
		szTemp = Caps(Left(szKeyName, 7));
		
		// No joystick/gampad support for the PC version
		if( Key >= 196 && Key <= 215 ) return;
		if(szTemp == "UNKNOWN") return;
		
		if(Key != GetPlayerOwner().Player.Console.EInputKey.IK_Escape)
		{
			 EPCMainMenuRootWindow(Root).m_MessageBoxCW.Close();
			 KeyPressed(Key);
			 m_MessageBox = None;
			 m_bModified = true;
		}
    }        
}

//==============================================================================
// LMouseDown - Handler for player who wants to set Left mouse button as new key
//==============================================================================
function LMouseDown(float X, float Y)
{
	if(m_MessageBox != None)
    {
         EPCMainMenuRootWindow(Root).m_MessageBoxCW.Close();
         KeyPressed(Root.Console.EInputKey.IK_LeftMouse);
         m_MessageBox = None;
         m_bModified = true;
    }   
}

//==============================================================================
// MMouseDown - Handler for player who wants to set Middle mouse button as new key
//==============================================================================
function MMouseDown(float X, float Y) 
{
    if(m_MessageBox != None)
    {
         EPCMainMenuRootWindow(Root).m_MessageBoxCW.Close();
         KeyPressed(Root.Console.EInputKey.IK_MiddleMouse);
         m_MessageBox = None;
         m_bModified = true;
    }   
}

//==============================================================================
// 
//==============================================================================
function RMouseDown(float X, float Y) 
{
	if(m_MessageBox != None)
    {
         EPCMainMenuRootWindow(Root).m_MessageBoxCW.Close();
         KeyPressed(Root.Console.EInputKey.IK_RightMouse);
         m_MessageBox = None;
         m_bModified = true;
    }   
}

//==============================================================================
// 
//==============================================================================
function MouseWheelDown(FLOAT X, FLOAT Y)
{
	if(m_MessageBox != None)
    {
         EPCMainMenuRootWindow(Root).m_MessageBoxCW.Close();
         KeyPressed(Root.Console.EInputKey.IK_MouseWheelDown);
         m_MessageBox = None;
         m_bModified = true;
    }   
}

//==============================================================================
// 
//==============================================================================
function MouseWheelUp(FLOAT X, FLOAT Y)
{
	if(m_MessageBox != None)
    {
         EPCMainMenuRootWindow(Root).m_MessageBoxCW.Close();
         KeyPressed(Root.Console.EInputKey.IK_MouseWheelUp);
         m_MessageBox = None;
         m_bModified = true;
    }   
}

//==============================================================================
// Notify - Handles doubles clicks and single clicks 
//==============================================================================
function Notify(UWindowDialogControl C, byte E)
{
    local float iMouseX;
    local float iMouseY;
    local float fOffsetFromMiddle; // Where the PRIM and ALT boxes start from middle of screen

    fOffsetFromMiddle = 6.50;
        
    if(E == DE_DoubleClick && C == m_ListBox && m_ListBox.SelectedItem != None)
    {    
        GetMouseXY(iMouseX, iMouseY);

        // Now we want to know whether primary or alternate config has been selected
        if((iMouseX - ((m_ListBox.WinWidth / 2) -  fOffsetFromMiddle)) > (m_ListBox.m_IHighLightWidth / 1.4) )
        {
            m_ListBox.m_bDoingAltMapping = !EPCOptionsKeyListBoxItem(m_ListBox.SelectedItem).m_bDrawFlipped;           
        }
        else
        {
            m_ListBox.m_bDoingAltMapping = EPCOptionsKeyListBoxItem(m_ListBox.SelectedItem).m_bDrawFlipped;
        }

        m_MessageBox = EPCMainMenuRootWindow(Root).m_MessageBoxCW.CreateMessageBox(Self, Localize("OPTIONS","MAPKEYTITLE","Localization\\HUD"), Localize("OPTIONS","MAPKEYMESSAGE","Localization\\HUD"), MB_Cancel, MR_Cancel, MR_None, true);                
    }
    else if(E==DE_Click && C == m_InvertMouseButton)
    {
        m_bModified = true;
    }
    else if(E==DE_Click && C == m_FireEquipGun)
    {
        m_bModified = true;
    }
    else if(E == DE_Change && C == m_MouseSensitivityScroll)
    {
        m_bModified = true;
    }
}

//==============================================================================
// 
//==============================================================================
function MessageBoxDone(UWindowWindow W, MessageBoxResult Result)
{
    m_MessageBox = None;
}
