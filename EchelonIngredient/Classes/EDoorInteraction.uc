class EDoorInteraction extends EInteractObject;

var ESwingingDoor	MyDoor;
var bool			LeftSideInteraction;
var Controller		ActiveController;

// stealth
var	bool			bStealth;
var bool			bStealthOpenDoor;
var bool			bInterrupted;
var Rotator			backupKeyRotation;
var float			backupMoveTime;
var bool			backupPlayerStayOpen;
var bool			bStoppedPushing;

function PostBeginPlay()
{
	Super.PostBeginPlay();

	MyDoor = ESwingingDoor(Owner.Owner);
	if( MyDoor == None )
		Log("WARNING : EDoorInteraction does not have a matching EDoorMover");
}

function string	GetDescription()
{
	local EPlayerController Epc;
	Epc = EPlayerController(InteractionPlayerController);
	if (Epc.eGame.bAltDoorStealth)
	{
		if (Epc.egi.bInteracting && Epc.aStrafe != 0)
			return Localize("Interaction", "Door1", "Localization\\HUD");
		else
			return Localize("Interaction", "Door0", "Localization\\HUD");
	}
	else
	{
		if (Epc.egi.bInteracting && Epc.aForward < 0)
			return Localize("Interaction", "Door1", "Localization\\HUD");
		else
			return Localize("Interaction", "Door0", "Localization\\HUD");
	}
}

function bool IsAvailable()
{
	local vector PawnDir, OwnerDir;

	// Check how high keyboard is compared to player Z.  12-15 being the perfect height.
	if( Abs(InteractionPlayerController.Pawn.Location.Z - Owner.Location.Z) > 50 )
		return false;

	return Super.IsAvailable();
}

function InitInteract( Controller Instigator )
{
	// Reset value
	bStealth = false;
	bStealthOpenDoor = false;
	bInterrupted = false;
	bStoppedPushing = false;

	// set controller's interaction
	Instigator.Interaction = self;
	ActiveController = Instigator;

	// Get door opening direction
	LeftSideInteraction = MyDoor.GetPawnSide(EPawn(Instigator.Pawn)) == ESide_Front;
	//Log("	Left side? "@LeftSideInteraction);

	if( Instigator.bIsPlayer && Instigator.GetStateName() == 's_FirstPersonTargeting' )
		EPlayerController(Instigator).JumpLabel = 'BackToFirstPerson';
	
	// If door is not locked, open it (no animation)
	if( MyDoor.Locked || !MyDoor.Usable )
	{
		//Log("		Locked");
		if( LeftSideInteraction )
			Instigator.GotoState('s_OpenDoor', 'LockedLt');
		else
			Instigator.GotoState('s_OpenDoor', 'LockedRt');
	}
	else
	{
		// Check if player wouldn't want to stealth
		if ((Instigator.bIsPlayer && !EPlayerController(Instigator).eGame.bAltDoorStealth && EPlayerController(Instigator).aForward < 0) // Joshua - Adding new control option for Open Door Stealth
    		|| Instigator.bIsPlayer &&  (EPlayerController(Instigator).eGame.bAltDoorStealth && EPlayerController(Instigator).aStrafe != 0))
		{
			//Log("		Wanna stealth");
			bStealth = true;
			MyDoor.bInUse = true;

			EPlayerController(Instigator).m_BTWSide = !LeftSideInteraction;
			Instigator.GotoState('s_OpenDoorStealth', 'BeginStealth');
		}
		// Interact left
		else if( LeftSideInteraction )
		{
			//Log("		Open left");
			Instigator.GotoState('s_OpenDoor', 'UnLockedLt');
		}
		// Interact right
		else
		{
			//Log("		Open right");
			Instigator.GotoState('s_OpenDoor', 'UnLockedRt');
		}
	}
}

function Interact( Controller Instigator )
{
	//Log("Interact"@bStealth@bStealthOpenDoor);
	if( (!MyDoor.Locked || !Instigator.bIsPlayer) && !MyDoor.IsOpened() )
	{
		// If stealth, set door appropriately
		if( Instigator.bIsPlayer && bStealth )
		{
			if( LeftSideInteraction )
			{
				//Log("	Stealth backup left FrontRotation"@MyDoor.FrontRotation);
				backupKeyRotation = MyDoor.FrontRotation;
				MyDoor.FrontRotation = MyDoor.Rotation;
				MyDoor.FrontRotation.Yaw = 2000;
			}
			else
			{
				//Log("	Stealth backup right BackRotation"@MyDoor.BackRotation);
				backupKeyRotation = MyDoor.BackRotation;
				MyDoor.BackRotation = MyDoor.Rotation;
				MyDoor.BackRotation.Yaw = -2000;
			}

			// Accelerate openning time
			backupMoveTime = MyDoor.MoveTime;
			backupPlayerStayOpen = MyDoor.bNoPlayerStayOpen;
			MyDoor.bNoPlayerStayOpen = true;
			MyDoor.bSteatlh = true;
			MyDoor.MoveTime	*= 0.5f;
			MyDoor.bTriggerOnceOnly = true;
			MyDoor.bInUse = true;

			// change state 
			//MyDoor.GotoState('TriggerToggle');
		}

		//Log("	Trigger");
		MyDoor.Trigger(Instigator.Pawn, Instigator.Pawn);
	}

	if( MyDoor.Locked )
		MyDoor.PlaySound(MyDoor.LockedSound, SLOT_SFX);
}

function PostInteract( Controller Instigator )
{
	//Log("PostInteract"@bStealth@bStealthOpenDoor@MyDoor.bClosing@MyDoor.bOpening@MyDoor.bInterpolating);
	if( MyDoor.Locked )
	{
		// Send transmission if Player
		if( Instigator.bIsPlayer && EPlayerController(Instigator) != None)
			EPlayerController(Instigator).SendTransmissionMessage(Localize("Transmission", "DoorLock", "Localization\\HUD"), TR_CONSOLE);
	}
	else if( !MyDoor.Usable )
	{
		// Send transmission if Player
		if( Instigator.bIsPlayer && EPlayerController(Instigator) != None)
			EPlayerController(Instigator).SendTransmissionMessage(Localize("Transmission", "DoorJam", "Localization\\HUD"), TR_CONSOLE);
	}
	else if( bStealth )
	{
		// Restore values
		if( LeftSideInteraction )
		{
			//Log("	Stealth restore left"@backupKeyRotation);
			MyDoor.FrontRotation = backupKeyRotation;
		}
		else
		{
			//Log("	Stealth restore right"@backupKeyRotation);
			MyDoor.BackRotation = backupKeyRotation;
		}
		MyDoor.bTriggerOnceOnly = false;
		MyDoor.bNoPlayerStayOpen = backupPlayerStayOpen;
		MyDoor.bSteatlh = false;
		MyDoor.bInUse = false;
		MyDoor.MoveTime = backupMoveTime;

		// Wanna open door in stealth mode
		if( bStealthOpenDoor )
		{
			if( !bInterrupted )
			{
				//Log("		Open door stealth");
				MyDoor.GotoState('TriggerOpenTimed','Open');
				Instigator.GotoState(,'OpenDoor');
			}
			else
			{
				//Log("		Open door stealth INTERRUPTED");
				Instigator.GotoState(,'InterruptOpening');
			}
		}
		// Interruption while trying to open door 
		else if( bInterrupted )
		{
			//Log("InterruptStealth");
			Instigator.GotoState(,'InterruptStealth');
		}
		// Wanna close it .. check for interruption
		else
		{
			//Log("		Close door stealth");
			MyDoor.GotoState('TriggerOpenTimed','Close');
			Instigator.GotoState(,'CloseDoor');
		}
	}

//	Instigator.Interaction = None;
//	ActiveController = None;
}

function KeyEvent( String Key, EInputAction Action, FLOAT Delta, optional bool bAuto )
{
	local bool StillMoving;
	//if( !bStealth ) Log("ERROR : keyEvent while not bStealth");

	StillMoving = MyDoor.bOpening || MyDoor.bInterpolating; // prevent opening before door finishes its movement

	switch( Key )
	{
	case "Neutral" :
		if( StillMoving ) break;
		bStoppedPushing = true;
		break;

	case "Forward" :
		if( StillMoving ) break;
		bStealthOpenDoor = true;
		PostInteract(ActiveController);
		break;

	case "Backward" :
		if( StillMoving || !bStoppedPushing ) break;
		bStealthOpenDoor = false;
		PostInteract(ActiveController);
		break;

	case "Interrupted" :
		bInterrupted = true;
		PostInteract(ActiveController);
		break;
	}
}

function SetInteractLocation( Pawn InteractPawn )
{
	local Vector X, Y, Z, MovePos;
	local EPawn InteractEPawn;
	local vector HitLocation, HitNormal;

	InteractEPawn = EPawn(InteractPawn);
	if( InteractEPawn == None )
		return;

	GetAxes(Owner.Rotation, X, Y, Z);

	// switch Y angle
	if( !LeftSideInteraction )
		Y = -Y;
	
	MovePos	= Owner.Location;
	if( InteractEPawn.bIsPlayerPawn )
	{
		if( bStealth )
			MovePos -= 1.2f * InteractEPawn.CollisionRadius * Y;	// front
		else
			MovePos -= 1.2f * InteractEPawn.CollisionRadius * Y;
	}
	else
	{
		MovePos	-= 1.2f * InteractEPawn.CollisionRadius * Y;
	}
	MovePos -= 1.3f * InteractEPawn.CollisionRadius * X;


	if(InteractEPawn.bIsPlayerPawn)
	{
	MovePos.Z = InteractEPawn.Location.Z;							// keep on same Z
	}
	else
	{
		if( Trace(HitLocation, HitNormal, MovePos + vect(0,0,-200), MovePos,,,,,true) != None )
		{
			HitLocation.Z += InteractEPawn.CollisionHeight;
			MovePos = HitLocation;
		}
	}
	
	InteractEPawn.m_locationStart	= InteractEPawn.Location;
	InteractEPawn.m_orientationStart= InteractEPawn.Rotation;
	InteractEPawn.m_locationEnd		= MovePos;
	InteractEPawn.m_orientationEnd	= Rotator(Y);
}

defaultproperties
{
    iPriority=5000
}