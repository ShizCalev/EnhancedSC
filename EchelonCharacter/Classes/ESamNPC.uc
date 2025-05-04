//===============================================================================
//  [spetsnaz] 
//===============================================================================

class ESamNPC extends EAIPawn
	placeable;

//---------------------------------------[David Kalina - 29 Oct 2001]-----
// 
// Description
//		Set randomized animation rate for AI pawns.
// 
//------------------------------------------------------------------------

function PostBeginPlay()
{
	local EWeapon Weapon;
	local MeshAnimation Anim;
	local int i;

	RandomizedAnimRate = 0.97f + RandRange(0.0f, 0.06f);

	// load generic anim packages
	Mesh = EchelonLevelInfo(Level).SamMesh;
	Anim = MeshAnimation(DynamicLoadObject("ESam.samAnims", class'MeshAnimation'));
	LinkSkelAnim( Anim );

	//
	// Weaponry
	//
	for( i=0; i<DynInitialInventory.Length; i++ )
	{
		if( DynInitialInventory[i] == class'EF2000' )
		{
			Weapon = Spawn(class'EF2000', self);
			AttachToBone(Weapon, Weapon.AttachAwayTag);
		}
		else if( DynInitialInventory[i] == class'EFn7' )
		{
			Weapon = Spawn(class'EFn7', self);
			AttachToBone(Weapon, Weapon.AttachAwayTag);
		}
	}

	// Remove everything to prevent the weapons to be in inventory
	DynInitialInventory.Remove(0, DynInitialInventory.Length);

	Super(EPawn).PostBeginPlay();		// skip AIPawn initialization -- don't want to link incompatible NPC animations
}




//----------------------------------------[David Kalina - 1 Aug 2001]-----
// 
// Description
//		Initialize anims for THE UNHOLY SAM
// 
//------------------------------------------------------------------------

function InitAnims()
{
	// fill most anim reference's w/ dummy names so if something is called w/out being set,
	// we know which animation is missing

	AWait								= 'AWait';
	AWaitCrouch							= 'AWaitCrouch';
	AJumpStart							= 'AJumpStart';
	AFallFree							= 'AFallFree';
	AFallQuiet							= 'AFallQuiet';
	ALandHi								= 'ALandHi';
	ALandLow							= 'ALandLow';
	ALandQuiet							= 'ALandQuiet';
	
	ASearchBody							= 'ASearchBody';
	AThrowGrenade	   				    = 'ThroStAlFdH';

	AReload						= 'reloStAlFd2';
	AReloadCrouch				= 'reloCrAlFd2';
	
	AWaitCrouch					= 'waitCrAlFd2';
	AGrabStart					= 'grabstalbg0';
	AGrabWait					= 'grabstalnt0';
	AGrabSqeeze					= 'GrabStAlIn0';
	AGrabRetinalStart			= 'GrabStCpBg0';
	AGrabRetinalWait			= 'GrabStCpNt0';
	AGrabRetinalEnd				= 'GrabStCpEd0';
	AGrabRelease				= 'grabstaled0';
	AGrabReleaseKnock			= 'grabstalko0';
	
	// ladder climbing
	ANLUpRight					= 'LaddStNmUpR';
	ANLUpLeft					= 'LaddStNmUpL';
	ANLOutBottomLeft			= 'LaddStAlIOL';
	ANLOutBottomRight			= 'LaddStAlIOR';
	ANLTopUpLeft				= 'LaddStNmEuL';
	ANLTopUpRight				= 'LaddStNmEuR';
	ANLInTop					= 'LaddStNmBu0';
	ANLTopDownRight				= 'LaddStNmBuR';	
	ANLInBottom					= 'LaddStNmBd0';
	ANLWaitLeft					= 'LaddStNmNtL';
	ANLWaitRight				= 'LaddStNmNtR';
	ANLWaitTop					= 'LaddStNmNt0';	
	ANLSlideDown				= 'LaddStNmDn0';


	// place a wallmine
	APlaceWallMine				= 'ThroStAlFdH';	// temp


	// door interactions
	ADoorOpenLt					= 'doorStNmLt0';
	ADoorOpenRt					= 'doorStNmRt0';
	ADoorTryOpenLt				= 'doorStNmLt2';	// temp
	ADoorTryOpenRt				= 'doorStNmRt2';	// temp
	ARetinalScanBegin			= 'ScanStNmBg0';
	ARetinalScan				= 'ScanStNmNt0';
	ARetinalScanEnd				= 'ScanStNmEd0';
	
	// falling
	AFall						= 'fallstalfr0';

	// Unconscious Revival Animations
	ARecover					= 'WakeStAlUp2';
	AReviveBody					= 'WakeStAlDn2';

	// ahem
	ACough						= 'SmokStAlFd0';

	// death
	ADeathForward				= 'XxxxStAlFD2';
	ADeathBack					= 'XxxxstalBK2';
	ADeathLeft					= 'XxxxstalLT2';
	ADeathRight					= 'XxxxstalRT2';

}


//---------------------------------------[David Kalina - 10 Apr 2001]-----
// 
// Description
//		Set up NPC Animations based on current BaseMoveFlags
// 
//------------------------------------------------------------------------
function SwitchAnims()
{
	//
	//
	//		SWITCH ON "WAIT FLAGS" 
	//		Crouch v. UnCrouch v. Sitting
	//
	// 

	switch (BaseMoveFlags)
	{
		case MOVE_CrouchJog :
		case MOVE_CrouchWalk :
			
			// CROUCHED ANIMS
			
			bWantsToCrouch = true;
			
			break;

		default : 

			// UNCROUCHED ANIMS

			bWantsToCrouch = false;
									
			break;
	}

	// switch anims based on WeaponStance / BaseMoveFlags
	switch (WeaponStance)
	{

		// no weapon :
			
		case 0 :
		
		// one handed weapon :

		case 1 :

		// two handed weapon :

		case 2 :

			switch (BaseMoveFlags)
			{
				case MOVE_NotSpecified :
				
					Log("SwitchAnims called with MOVE_NotSpecified -- using MOVE_WalkRelaxed and forcing BaseMoveFlags.");
					BaseMoveFlags = MOVE_WalkRelaxed;

				case MOVE_WalkRelaxed :				// note : MOVE_WalkRelaxed ==> s_Default
				case MOVE_WalkNormal:				// note : MOVE_WalkNormal ==> s_Investigate
				case MOVE_Search:
				case MOVE_WalkAlert:				// note : MOVE_WalkAlert ==> s_Alert
				case MOVE_Snipe:

					AWaitIn							= '';
					AWait							= 'waitStAlFd0';
					AWaitOut						= '';

					ABlendMovement.m_forward		= 'walkStAlFd0';

					SoundWalkingRatio = 0.60;

					break;

				case MOVE_JogAlert :
				case MOVE_JogNoWeapon :

					AWaitIn							= '';
					AWait							= 'waitStAlFd0';
					AWaitOut						= 'joggStAlEd0';

					ABlendMovement.m_forward		= 'joggStAlFd0';

					SoundWalkingRatio = 1.0;
					
					break;
				
				case MOVE_CrouchWalk :  
					
					AWaitIn							= '';
					AWait							= 'waitCrAlFd0';
					AWaitOut						= '';

					ABlendMovement.m_forward		= 'walkCrAlFd0';

					SoundWalkingRatio = 0.60;
					
					break;

				case MOVE_CrouchJog : 

					AWaitIn							= '';
					AWait							= 'waitCrAlFd0';
					AWaitOut						= '';

					ABlendMovement.m_forward		= 'joggCrAlFd0';	

					SoundWalkingRatio = 1.0;

					break;
	
			}
	}
}

defaultproperties
{
    bNoBlending=true
    bDontCheckChangedActor=true
    m_VisibilityConeAngle=0.000000
    m_VisibilityMaxDistance=0.000000
    m_VisibilityAngleVertical=0.000000
    m_MaxPeripheralVisionDistance=0.000000
}