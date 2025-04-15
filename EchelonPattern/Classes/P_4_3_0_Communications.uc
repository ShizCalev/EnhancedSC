//=============================================================================
// P_4_3_0_Communications
//=============================================================================
class P_4_3_0_Communications extends EPattern;

#exec OBJ LOAD FILE=..\Sounds\S4_3_0Voice.uax
#exec OBJ LOAD FILE=..\Sounds\Lambert.uax

// FLAGS ///////////////////////////////////////////////////////////////////////

var int FirstLambertComDone;


// EVENTS //////////////////////////////////////////////////////////////////////

function EventCallBack(EAIEvent Event,Actor TriggerActor)
{
    if(!bDisableMessages)
    {
        switch(Event.EventType)
        {
        default:
            break;
        }
    }
}

function InitPattern()
{
    local Pawn P;

    Super.InitPattern();

    ForEach DynamicActors(class'Pawn', P)
    {
        if(P.name == 'ELambert0')
            Characters[1] = P.controller;
    }

    if( !bInit )
    {
    bInit=TRUE;
    FirstLambertComDone=0;
    }

}


// PATTERN /////////////////////////////////////////////////////////////////////

state Pattern
{

Begin:
LambertMapStartCom:
    Log("");
    CheckFlags(FirstLambertComDone,TRUE,'CommAlreadyDone');
    SetFlags(FirstLambertComDone,TRUE);
    AddGoal('FeirongData', "", 2, "", "P_4_3_0_Communications", "Goal_0030L", "Localization\\P_4_3_0ChineseEmbassy", "P_4_3_0_Communications", "Goal_0031L", "Localization\\P_4_3_0ChineseEmbassy");
    AddGoal('Infiltrate', "", 1, "", "P_4_3_0_Communications", "Goal_0037L", "Localization\\P_4_3_0ChineseEmbassy", "P_4_3_0_Communications", "Goal_0038L", "Localization\\P_4_3_0ChineseEmbassy");
    AddGoal('DeadFeirong', "", 6, "", "P_4_3_0_Communications", "Goal_0032L", "Localization\\P_4_3_0ChineseEmbassy", "P_4_3_0_Communications", "Goal_0033L", "Localization\\P_4_3_0ChineseEmbassy");
    Speech(Localize("P_4_3_0_Communications", "Speech_0001L", "Localization\\P_4_3_0ChineseEmbassy"), Sound'S4_3_0Voice.Play_43_05_01', 1, 2, TR_HEADQUARTER, 0, false);
    Speech(Localize("P_4_3_0_Communications", "Speech_0003L", "Localization\\P_4_3_0ChineseEmbassy"), Sound'S4_3_0Voice.Play_43_05_02', 0, 0, TR_HEADQUARTER, 0, false);
    Speech(Localize("P_4_3_0_Communications", "Speech_0004L", "Localization\\P_4_3_0ChineseEmbassy"), Sound'S4_3_0Voice.Play_43_05_03', 1, 0, TR_HEADQUARTER, 0, false);
    Close();
CommAlreadyDone:
    End();
ThermalKeypadExplanationA:
    Log("Communicator 43_09");
    Speech(Localize("P_4_3_0_Communications", "Speech_0023L", "Localization\\P_4_3_0ChineseEmbassy"), Sound'S4_3_0Voice.Play_43_09_01', 1, 0, TR_HEADQUARTER, 0, false);
    Close();
    End();
GenericFail:
    Log("If Sam fails something");
    PlayerMove(false);
    DisableMessages(TRUE, TRUE);
    Speech(Localize("P_4_3_0_Communications", "Speech_0036L", "Localization\\P_4_3_0ChineseEmbassy"), Sound'Lambert.Play_41_95_01', 1, 0, TR_HEADQUARTER, 0, true);
    Close();
    GameOver(false, 0);
    End();

}

