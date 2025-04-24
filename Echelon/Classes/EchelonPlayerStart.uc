class EchelonPlayerStart extends PlayerStart
	config(Enhanced); // Joshua - Class, configurable in Enhanced config

struct InventoryInfo
{
	var() class<EInventoryItem> ItemClass;
	var() int					Qty;
};

var() array<InventoryInfo>	DynInitialInventory;
var() array<Sound>			m_StartSounds;
var() bool					bNoThermalAvailable;
var() config bool			bThermalOverride;

var()  Name					GroupTag;
var()  Name					JumpLabel;
var	   int					NbTicks;

function PostBeginPlay()
{
	if (bThermalOverride && !EchelonGameInfo(Level.Game).bEliteMode)
		bNoThermalAvailable = false;

	// Joshua - Dirty fix to move Vselka Infiltration spawn point to Xbox version
	if (GetCurrentMapName() == "1_7_1_1VselkaInfiltration")
	{
		SetLocation(vect(12801.27, 4688.78, -1214.32));
		SetRotation(rot(0, 38088, 0));
	}

	// Joshua - Severonickel Part 2 spawn point lowered so Sam doesn't fall in air at start
	if (GetCurrentMapName() == "3_4_3Severonickel")
	{
		SetLocation(vect(3528.004150, 1708.404541, 592.0));
	}
	
	super.PostBeginPlay();
}

auto state s_initial
{
	function Tick( float Other )
	{
		local INT iSoundNb;

		NbTicks++;

		if ( NbTicks > 1 )
		{
		if (m_StartSounds.Length != 0)
		{
			for(iSoundNb = 0; iSoundNb < m_StartSounds.Length; iSoundNb++)
			{
				//Play sounds
				PlaySound(m_StartSounds[iSoundNb], SLOT_Ambient);
			}
		}
			Disable('Tick');
		}
	}
}

function SendInitialPattern()
{
	local EGroupAI Group;

	//send AI event
	if( (GroupTag != '') && (JumpLabel != '') )
	{
		foreach DynamicActors( class'EGroupAI', Group, GroupTag)
		{
			Group.SendJumpEvent(JumpLabel,false,false);
			break; 
		}	
	}
}

defaultproperties
{
    bFindBaseOnBuild=false
    bStatic=false
    bCollideActors=true
}