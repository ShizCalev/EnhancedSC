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
	if (bThermalOverride)
		bNoThermalAvailable = false;
	
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