class EGameInteraction extends EInteraction;

#exec OBJ LOAD FILE=..\Sounds\Interface.uax

var EInteractObject ExitInteraction;
var bool bInteracting;

function bool KeyEvent( EInputKey Key, EInputAction Action, FLOAT Delta )
{
	local string actionName;
	actionName = FindAction(Key);

	if( Epc.Level.Pauser != None )
		return false;

	if( Action == IST_Press || Action == IST_Hold )
	{

		//clauzon 9/17/2002 replaced a switch checking the key pressed by the mapped action test.
		if(actionName == "Interaction")
		{
			if( Epc.IManager.GetNbInteractions() > 0 && 
				Epc.CanInteract() &&
				!Epc.bStopInput )							// Prevent interacting in cinematic
			{			
				bInteracting = true;

				// Go into GameInteraction menu
				//Log("Interaction pressed with"$Epc.IManager.GetNbInteractions()$" interaction on stack");
				GotoState('s_GameInteractionMenu');
				 
				return true; // grabbed
			}		
		}
	}

//=============================================================================
// Joshua - Bind controller input based on scheme
//=============================================================================

switch (Epc.ControllerScheme)
{
    case CS_Default:
        Epc.SetKey("Joy1 Interaction", "P");
        Epc.SetKey("Joy2 Duck", "P");
        Epc.SetKey("Joy3 Scope", "P");
        Epc.SetKey("Joy4 Jump", "P");
        Epc.SetKey("Joy5 BackToWall", "P");
        Epc.SetKey("Joy6 QuickInventory", "P");
        Epc.SetKey("Joy7 AltFire", "P");
        Epc.SetKey("Joy8 Fire", "P");
        Epc.SetKey("Joy10 FullInventory", "P");
        Epc.SetKey("Joy11 SwitchROF", "P");
        Epc.SetKey("Joy12 ResetCamera", "P");
        Epc.SetKey("Joy13 DPadUp", "P");
        Epc.SetKey("Joy14 DPadDown", "P");
        Epc.SetKey("Joy15 DPadLeft", "P");
        Epc.SetKey("Joy16 DPadRight", "P");
        Epc.SetKey("AnalogUp MoveForward", "P");
        Epc.SetKey("AnalogDown MoveBackward", "P");
        Epc.SetKey("AnalogLeft StrafeLeft", "P");
        Epc.SetKey("AnalogRight StrafeRight", "P");
        
        if (Epc.GetStateName() == 's_FirstPersonTargeting' || Epc.GetStateName() == 's_PlayerSniping')
        {
            Epc.SetKey("Joy4 ToggleSnipe", "P");
            Epc.SetKey("Joy5 ReloadGun", "P");
        }
        break;

    case CS_Pandora:
        Epc.SetKey("Joy1 Interaction", "P");
        Epc.SetKey("Joy2 Duck", "P");
        Epc.SetKey("Joy3 Scope", "P");
        Epc.SetKey("Joy4 Jump", "P");
        Epc.SetKey("Joy5 QuickInventory", "P");
        Epc.SetKey("Joy6 QuickInventory", "P"); // Joshua - Pandora used whistling here.
        Epc.SetKey("Joy7 AltFire", "P");
        Epc.SetKey("Joy8 Fire", "P");
        Epc.SetKey("Joy10 FullInventory", "P");
        Epc.SetKey("Joy11 BackToWall", "P");
        Epc.SetKey("Joy12 ResetCamera", "P");
        Epc.SetKey("Joy13 DPadUp", "P");
        Epc.SetKey("Joy14 DPadDown", "P");
        Epc.SetKey("Joy15 DPadLeft", "P");
        Epc.SetKey("Joy16 DPadRight", "P");
        Epc.SetKey("AnalogUp MoveForward", "P");
        Epc.SetKey("AnalogDown MoveBackward", "P");
        Epc.SetKey("AnalogLeft StrafeLeft", "P");
        Epc.SetKey("AnalogRight StrafeRight", "P");

        if (Epc.GetStateName() == 's_FirstPersonTargeting' || Epc.GetStateName() == 's_PlayerSniping')
        {
			Epc.SetKey("Joy1 ReloadGun", "P");
			Epc.SetKey("Joy11 SwitchROF", "P"); // Joshua - Pandora used both thumbsticks to snipe because it had no ROF.
            Epc.SetKey("Joy12 ToggleSnipe", "P");
        }
        break;

    case CS_PlayStation:
        Epc.SetKey("Joy1 Interaction", "P");
        Epc.SetKey("Joy2 Duck", "P");
        Epc.SetKey("Joy3 QuickInventory", "P");
        Epc.SetKey("Joy4 Jump", "P");
        Epc.SetKey("Joy5 ReloadGun", "P");
        Epc.SetKey("Joy6 Scope", "P");
        Epc.SetKey("Joy7 AltFire", "P");
        Epc.SetKey("Joy8 Fire", "P");
        Epc.SetKey("Joy10 FullInventory", "P");
        Epc.SetKey("Joy11 BackToWall", "P");
        Epc.SetKey("Joy12 ResetCamera", "P");
        Epc.SetKey("Joy13 DPadUp", "P");
        Epc.SetKey("Joy14 DPadDown", "P");
        Epc.SetKey("Joy15 DPadLeft", "P");
        Epc.SetKey("Joy16 DPadRight", "P");
        Epc.SetKey("AnalogUp MoveForward", "P");
        Epc.SetKey("AnalogDown MoveBackward", "P");
        Epc.SetKey("AnalogLeft StrafeLeft", "P");
        Epc.SetKey("AnalogRight StrafeRight", "P");

        if (Epc.GetStateName() == 's_FirstPersonTargeting' || Epc.GetStateName() == 's_PlayerSniping')
        {
			Epc.SetKey("Joy11 SwitchROF", "P");
            Epc.SetKey("Joy12 ToggleSnipe", "P");
        }
        break;
}

//=============================================================================
// Joshua - Shared state bindings
//=============================================================================

	// Joshua - Workaround to prevent controller from interrupting mission failed before it reloads the last save.
	if(Epc.GetStateName() == 's_Dead')
	{
		Epc.SetKey( "Joy1 None", "P");
		Epc.SetKey( "Joy8 None", "P");
		Epc.SetKey( "Joy10 None", "P");
	}

	return false; // continue input processing
} 

state s_GameInteractionMenu
{
	function BeginState()
	{
		Epc.SetPause(true);
		Epc.IManager.SelectedInteractions = 1;
		
		// Add exit button, spawn it only the first time in
		if( ExitInteraction == None )
			ExitInteraction = Epc.IManager.spawn(class'EExitInteraction', Epc.IManager);
		Epc.IManager.ShowExit(ExitInteraction);

		//Log("Interaction menu in");
	}

	function EndState()
	{
		if( Epc.IManager.GetCurrentInteraction() == None )
			Log("ERROR: Interaction not valid on stack.");

		Epc.SetPause(false);

		//Log("Interaction menu .. Interaction released .. initInteract");
		Epc.IManager.GetCurrentInteraction().InitInteract(Epc);
		Epc.IManager.SelectedInteractions = -1;

		// Remove exit button
		Epc.IManager.ShowExit(None);
	}

	function bool KeyEvent( EInputKey Key, EInputAction Action, FLOAT Delta )
	{
		local string actionName;
		actionName = FindAction(Key);
		
		if( Action == IST_Press )
		{
			if( Epc.eGame.bUsingController ) // Joshua - Adding controller support for interaction box
			{
				if(actionName == "DPadUp")
				{
					if( Epc.IManager.SelectNextItem() )
					{
						Epc.EPawn.playsound(Sound'Interface.Play_ActionChoice', SLOT_Interface);
					}
				}
				else if(actionName == "DPadDown")
				{
					if( Epc.IManager.SelectPreviousItem() )
					{
						Epc.EPawn.playsound(Sound'Interface.Play_ActionChoice', SLOT_Interface);
					}
				}
			}
			else
			{
				//clauzon 9/17/2002 replaced a switch checking the key pressed by the mapped action test.
				if(actionName=="MoveForward" || Key == IK_MouseWheelUp)
				{
					if( Epc.IManager.SelectNextItem() )
					{
						//Log("Interaction menu UP");
						Epc.EPawn.playsound(Sound'Interface.Play_ActionChoice', SLOT_Interface);
					}				
				}
				else if(actionName == "MoveBackward" || Key == IK_MouseWheelDown)
				{
					if( Epc.IManager.SelectPreviousItem() )
					{
						//Log("Interaction menu DOWN");
						Epc.EPawn.playsound(Sound'Interface.Play_ActionChoice', SLOT_Interface);
					}
				}
			}
		}
		else if( Action == IST_Release )
		{
			if(actionName=="Interaction")
			{
				bInteracting = false;
				// Exit GameInteraction menu
				//Log("Interaction released");
				GotoState('');
			}
		}

		return true;
	} 
}

