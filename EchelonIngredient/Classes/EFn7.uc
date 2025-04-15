class EFn7 extends EHandGun;

#exec OBJ LOAD FILE=..\Sounds\FisherEquipement.uax

function PostBeginPlay()
{
    Super.PostBeginPlay();
    HUDTex       = EchelonLevelInfo(Level).TICON.qi_ic_beretta;
    InventoryTex = EchelonLevelInfo(Level).TICON.inv_ic_beretta;
    ItemName     = "FN7";
	ItemVideoName = "gd_fn702.bik";
    Description  = "FN7Desc";
	HowToUseMe  = "FN7HowToUseMe";
}

function bool SwitchROF()
{
	switch( eROFMode )
	{
	case ROF_Single : eROFMode = ROF_Single; return false;
	}
}

function bool IsROFModeAvailable(ERateOfFireMode rof)
{
    switch( rof )
	{
        case ROF_Single:
            return true;
        default:
            return false;
    }
}

// ----------------------------------------------------------------------
// state s_Inventory - Must keep this gun always Visible
// ----------------------------------------------------------------------
state s_Inventory
{
	function BeginState()
	{
		Super.BeginState();
		bHidden	= false;
	}
}

defaultproperties
{
    Ammo=40
    MaxAmmo=60
    ClipAmmo=20
    ClipMaxAmmo=20
    RateOfFire=0.1870000
    BaseDamage=100
    FireNoiseRadius=400
    FireSingleShotSound=Sound'FisherEquipement.Play_FisherPistolSingleShot'
    ReloadSound=Sound'FisherEquipement.Play_FNPistolReload'
    EmptySound=Sound'GunCommon.Play_PistolEmpty'
    EjectedClass=Class'EShellCaseSmall'
    EjectedOffset=(X=2.4255000,Y=0.7639000,Z=7.0271000)
    MuzzleOffset=(X=38.9110000,Y=0.0000000,Z=7.3130000)
    MagazineMesh=StaticMesh'EMeshIngredient.weapon.F7MAG'
    MagazineOffset=(X=2.9850000,Y=0.0000000,Z=5.4310000)
    RecoilStrength=1.0000000
    RecoilAngle=10.0000000
    RecoilStartAlpha=1.0000000
    RecoilFadeOut=4.0000000
    UseAccuracy=true
    AccuracyMovementModifier=5.0000000
    AccuracyReturnModifier=10.0000000
    AccuracyBase=0.5000000
    ObjectHudClass=Class'EF2000Reticle'
    StaticMesh=StaticMesh'EMeshIngredient.weapon.F7'
    CollisionRadius=6.0000000
    CollisionHeight=6.0000000
}