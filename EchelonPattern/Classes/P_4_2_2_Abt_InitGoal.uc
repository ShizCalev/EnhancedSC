//=============================================================================
// P_4_2_2_Abt_InitGoal
//=============================================================================
class P_4_2_2_Abt_InitGoal extends EPattern;

// FLAGS ///////////////////////////////////////////////////////////////////////



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

    if( !bInit )
    {
    bInit=TRUE;
    }

}


// PATTERN /////////////////////////////////////////////////////////////////////

state Pattern
{

Begin:
LastMapGoal:
    Log("goal and note from 421");
    AddGoal('DestroyAntenna', "", 8, "", "P_4_2_2_Abt_InitGoal", "Goal_0001L", "Localization\\P_4_2_2_Abattoir", "P_4_2_2_Abt_InitGoal", "Goal_0004L", "Localization\\P_4_2_2_Abattoir");
    GoalCompleted('DestroyAntenna');
    AddGoal('StopSoldier', "", 4, "", "P_4_2_2_Abt_InitGoal", "Goal_0002L", "Localization\\P_4_2_2_Abattoir", "P_4_2_2_Abt_InitGoal", "Goal_0005L", "Localization\\P_4_2_2_Abattoir");
    GoalCompleted('StopSoldier');
    AddRecon(class 'EReconPicGrinko');
    AddRecon(class 'EReconFullTextGrinko');
NextGoal:
    Log("");
    AddGoal('LocateSoldier', "", 6, "", "P_4_2_2_Abt_InitGoal", "Goal_0003L", "Localization\\P_4_2_2_Abattoir", "P_4_2_2_Abt_InitGoal", "Goal_0006L", "Localization\\P_4_2_2_Abattoir");
    Sleep(1);
    SendUnrealEvent('Mover3');
    End();

}

