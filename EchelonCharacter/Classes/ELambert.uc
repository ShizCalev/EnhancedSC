class ELambert extends EAINonHostile
	placeable;

function PostBeginPlay()
{
	// set bone names
	EyeBoneName = 'B Head';

    Super.PostBeginPlay();
}


function SwitchAnims()
{

	Super.SwitchAnims();

	AWait = 'waitstnmfd0';

}

defaultproperties
{
    GearSoundWalk=Sound'GearCommon.Play_Random_CivilGearWalk'
    GearSoundRun=Sound'GearCommon.Play_Random_CivilGearRun'
    bCanWhistle=false
    bDontCheckChangedActor=true
    m_VisibilityConeAngle=0.0000000
    m_VisibilityMaxDistance=0.0000000
    m_VisibilityAngleVertical=0.0000000
    m_MaxPeripheralVisionDistance=0.0000000
    DrawType=DT_Sprite
    CollisionRadius=34.0000000
    CollisionHeight=88.0000000
}