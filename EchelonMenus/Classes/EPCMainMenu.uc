//=============================================================================
//  EPCMainMenu.uc : MainMenu
//  Copyright 2002 Ubi Soft, Inc. All Rights Reserved.
//
//  Revision history:
//    2002/10/03 * Created by Alexandre Dionne
//=============================================================================


class EPCMainMenu extends EPCMenuPage
        native;

var EPCTextButton   m_StarGame;
var EPCTextButton   m_Settings;
var EPCTextButton   m_PlayIntro;
var EPCTextButton   m_Credits;
var EPCTextButton   m_ExitGame;
var EPCTextButton   m_GoOnline;

var INT             m_IMainButtonsXPos, m_IMainButtonsHeight, m_IMainButtonsWidth, m_IMainButtonsFirstYPos, m_IMainButtonsYOffset;
var INT             m_IGoOnlineYPos, m_IGoOnlineWidth, m_IGoOnlineXPos;

var EPCMessageBox        m_MessageBox;

function Created()
{
    Super.Created();
    
    m_StarGame  = EPCTextButton(CreateControl( class'EPCTextButton', m_IMainButtonsXPos, m_IMainButtonsFirstYPos, m_IMainButtonsWidth, m_IMainButtonsHeight, self));
    m_Settings  = EPCTextButton(CreateControl( class'EPCTextButton', m_IMainButtonsXPos, m_StarGame.WinTop + m_StarGame.WinHeight + m_IMainButtonsYOffset, m_IMainButtonsWidth, m_IMainButtonsHeight, self));
    m_PlayIntro = EPCTextButton(CreateControl( class'EPCTextButton', m_IMainButtonsXPos, m_Settings.WinTop + m_Settings.WinHeight + m_IMainButtonsYOffset, m_IMainButtonsWidth, m_IMainButtonsHeight, self));
    m_Credits   = EPCTextButton(CreateControl( class'EPCTextButton', m_IMainButtonsXPos, m_PlayIntro.WinTop + m_PlayIntro.WinHeight + m_IMainButtonsYOffset, m_IMainButtonsWidth, m_IMainButtonsHeight, self));
    m_ExitGame  = EPCTextButton(CreateControl( class'EPCTextButton', m_IMainButtonsXPos, m_Credits.WinTop + m_Credits.WinHeight + m_IMainButtonsYOffset, m_IMainButtonsWidth, m_IMainButtonsHeight, self));

    m_GoOnline  = EPCTextButton(CreateControl( class'EPCTextButton', m_IGoOnlineXPos, m_IGoOnlineYPos, m_IGoOnlineWidth, m_IMainButtonsHeight, self));

    //Buttons will have Root.Font[0] as default font wich is what we want
    m_StarGame.SetButtonText(Localize("HUD","START","Localization\\HUD") ,TXT_CENTER);
    m_Settings.SetButtonText(Localize("HUD","SETTINGSMENU","Localization\\HUD") ,TXT_CENTER);
    m_PlayIntro.SetButtonText(Localize("HUD","PLAYINTRO","Localization\\HUD") ,TXT_CENTER);
    m_Credits.SetButtonText(Localize("HUD","CREDIT","Localization\\HUD") ,TXT_CENTER);
    m_ExitGame.SetButtonText(Localize("HUD","EXIT","Localization\\HUD") ,TXT_CENTER);
    m_GoOnline.SetButtonText(Localize("HUD","WEBSITE","Localization\\HUD") ,TXT_CENTER);
    
    m_StarGame.Font = F_Large;
    m_Settings.Font = F_Large;
    m_PlayIntro.Font = F_Large;
    m_Credits.Font = F_Large;
    m_ExitGame.Font = F_Large;
    m_GoOnline.Font = F_Large;


}



function Paint(Canvas C, float MouseX, float MouseY)
{
    Render( C , MouseX, MouseY);	
}

function Notify(UWindowDialogControl C, byte E)
{

	if(E == DE_Click)
	{
        switch(C)
        {
        case m_StarGame:
            Root.ChangeCurrentWidget(WidgetID_Player);
            break;
        case m_Settings:
            Root.ChangeCurrentWidget(WidgetID_Options);
            break;
        case m_PlayIntro:
            Root.ChangeCurrentWidget(WidgetID_Intro);
            break;
        case m_Credits:            
            Root.ChangeCurrentWidget(WidgetID_Credits);
            break;
        case m_GoOnline:            
            GetLevel().ConsoleCommand("startminimized "@"http://www.splintercell.com");
            break;
        case m_ExitGame:            
            m_MessageBox = EPCMainMenuRootWindow(Root).m_MessageBoxCW.CreateMessageBox(Self, Localize("OPTIONS","QUITSPLINTER","Localization\\HUD"), Localize("OPTIONS","QUITSPLINTERMESSAGE","Localization\\HUD"), MB_YesNo, MR_No, MR_No);
            break;

        }
    }
}

function MessageBoxDone(UWindowWindow W, MessageBoxResult Result)
{   
    if(m_MessageBox == W)
    {
        m_MessageBox = None;

        if(Result == MR_Yes)
        {
            Root.DoQuitGame();
        }
            
    }    

}

defaultproperties
{
    m_IMainButtonsXPos=200
    m_IMainButtonsHeight=18
    m_IMainButtonsWidth=230
    m_IMainButtonsFirstYPos=160
    m_IMainButtonsYOffset=3
    m_IGoOnlineYPos=295
    m_IGoOnlineWidth=300
    m_IGoOnlineXPos=180
}