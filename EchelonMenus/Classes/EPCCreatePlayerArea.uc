//=============================================================================
//  EPCCreatePlayerArea.uc : Area of control to create a player profile
//  Copyright 2002 Ubi Soft, Inc. All Rights Reserved.
//
//  Revision history:
//    2002/10/15 * Created by Alexandre Dionne
//=============================================================================


class EPCCreatePlayerArea extends UWindowDialogClientWindow;


var EPCTextButton   m_ResetAllButton;     // To return to main menu
var INT             m_IResetAllXPos, m_IResetAllButtonsHeight, m_IResetAllButtonsWidth, m_IResetAllButtonsYPos; 


var UWindowLabelControl     m_LPlayerName;      //Title
var UWindowLabelControl     m_LDifficulty;      //Title
var UWindowLabelControl     m_LDifficultyNormal;
var UWindowLabelControl     m_LDifficultyHard;

var EPCEditControl      m_EPlayerName;      //Value

var EPCCheckBox             m_DifficultyNormal, m_DifficultyHard;

var INT                     m_IXLabelPos, m_ILabelHeight, m_ILabelWidth;
var INT                     m_IPlayerNameYPos, m_IPlayerNameOffset, m_IPlayerNameWidth;
var INT                     m_IDifficultyXOffset, m_IDifficultyYPos, m_IDifficultyYOffset, m_IDifficultyRadioYPos, m_IRadioWidth;

var Color                   m_EditBorderColor;
var Color                   m_TextColor;



function Created()
{
    

    m_LPlayerName       = UWindowLabelControl(CreateWindow( class'UWindowLabelControl', m_IXLabelPos, m_IPlayerNameYPos, m_ILabelWidth, m_ILabelHeight, self));
    m_LDifficulty       = UWindowLabelControl(CreateWindow( class'UWindowLabelControl', m_IXLabelPos, m_IDifficultyYPos, m_ILabelWidth, m_ILabelHeight, self));
        
    m_EPlayerName       = EPCEditControl(CreateWindow( class'EPCEditControl', m_LPlayerName.WinLeft + m_LPlayerName.WinWidth + m_IPlayerNameOffset, m_IPlayerNameYPos, m_IPlayerNameWidth, m_ILabelHeight, self));	

    m_EPlayerName.SetBorderColor(m_EditBorderColor);
    m_EPlayerName.SetEditTextColor(m_EditBorderColor);

	// Set Profile name lenght to a maximum of 17 character
    m_EPlayerName.SetMaxLength(17);

    m_LDifficultyNormal = UWindowLabelControl(CreateWindow( class'UWindowLabelControl', m_EPlayerName.WinLeft + m_IDifficultyXOffset, m_IDifficultyRadioYPos, m_ILabelWidth, m_ILabelHeight, self));
    m_LDifficultyHard   = UWindowLabelControl(CreateWindow( class'UWindowLabelControl', m_EPlayerName.WinLeft + m_IDifficultyXOffset, m_IDifficultyRadioYPos + m_IDifficultyYOffset, m_ILabelWidth, m_ILabelHeight, self));

    m_ResetAllButton  = EPCTextButton(CreateControl( class'EPCTextButton', m_IResetAllXPos, m_IResetAllButtonsYPos, m_IResetAllButtonsWidth, m_IResetAllButtonsHeight, self));

    m_DifficultyNormal  = EPCCheckBox(CreateControl( class'EPCCheckBox', m_EPlayerName.WinLeft, m_LDifficultyNormal.WinTop, m_IRadioWidth, m_ILabelHeight, self));
    m_DifficultyHard    = EPCCheckBox(CreateControl( class'EPCCheckBox', m_EPlayerName.WinLeft, m_LDifficultyHard.WinTop, m_IRadioWidth, m_ILabelHeight, self));
    m_DifficultyNormal.m_bSelected  = true;
    m_DifficultyNormal.ImageX       = 5;
    m_DifficultyNormal.ImageY       = 5;
    m_DifficultyHard.ImageX         = 5;
    m_DifficultyHard.ImageY         = 5;
 
    m_ResetAllButton.SetButtonText(Caps(Localize("HUD","CLEARALL","Localization\\HUD")) ,TXT_CENTER);    
    
    m_LPlayerName.SetLabelText(Localize("HUD","PLAYERNAME","Localization\\HUD"),TXT_LEFT);
    m_LDifficulty.SetLabelText(Localize("HUD","DIFFICULTY","Localization\\HUD"),TXT_LEFT);
    m_LDifficultyNormal.SetLabelText(Localize("HUD","Normal","Localization\\HUD"),TXT_LEFT);
    m_LDifficultyHard.SetLabelText(Localize("HUD","Hard","Localization\\HUD"),TXT_LEFT); 
      

    m_ResetAllButton.Font     = F_Normal;    
    m_LPlayerName.Font        = F_Normal;
    m_LDifficulty.Font        = F_Normal;
    m_LDifficultyNormal.Font  = F_Normal;
    m_LDifficultyHard.Font    = F_Normal;

    m_LPlayerName.TextColor         = m_TextColor;
    m_LDifficulty.TextColor         = m_TextColor;
    m_LDifficultyNormal.TextColor   = m_TextColor;
    m_LDifficultyHard.TextColor     = m_TextColor;


    
}

function String GetProfileName()
{
    return m_EPlayerName.GetValue();
}

function INT GetDifficulty()
{
    if(m_DifficultyNormal.m_bSelected == true)
        return 0;
    else 
        return 1;
}

function Reset()
{
    m_EPlayerName.Clear();
    m_DifficultyNormal.m_bSelected  = true;
    m_DifficultyHard.m_bSelected    = false;
}

function Notify(UWindowDialogControl C, byte E)
{

	if(E == DE_Click)
	{
        switch(C)
        {
        case m_DifficultyNormal:
            m_DifficultyNormal.m_bSelected = true;
            m_DifficultyHard.m_bSelected = false;
            break;
        case m_DifficultyHard:
            m_DifficultyHard.m_bSelected = true;
            m_DifficultyNormal.m_bSelected = false;
            break;
        case m_ResetAllButton:
            Reset();
            break;
        }
        
    }
    
}

defaultproperties
{
    m_IResetAllXPos=150
    m_IResetAllButtonsHeight=18
    m_IResetAllButtonsWidth=200
    m_IResetAllButtonsYPos=136
    m_IXLabelPos=20
    m_ILabelHeight=18
    m_ILabelWidth=190
    m_IPlayerNameYPos=30
    m_IPlayerNameOffset=25
    m_IPlayerNameWidth=200
    m_IDifficultyXOffset=30
    m_IDifficultyYPos=70
    m_IDifficultyYOffset=25
    m_IDifficultyRadioYPos=70
    m_IRadioWidth=20
    m_EditBorderColor=(R=51,G=51,B=51,A=255)
    m_TextColor=(R=51,G=51,B=51,A=255)
}