class EF2000 extends EMainGun;

var int numShellIn;
var int numShellToEject;
var float lastEjectTime;

const MAX_SHELL_IN = 3;
const EJECT_DELAY = 0.04;

#exec OBJ LOAD FILE=..\Sounds\FisherEquipement.uax

function PostBeginPlay()
{
    Super.PostBeginPlay();

    HUDTex       = EchelonLevelInfo(Level).TICON.qi_ic_maingun;
    InventoryTex = EchelonLevelInfo(Level).TICON.inv_ic_maingun;
    ItemName     = "FN2000";
	ItemVideoName = "gd_f2000.bik";
    Description  = "FN2000Desc";
	HowToUseMe  = "FN2000HowToUseMe";
}

function CheckShellCase()
{
	if(numShellToEject > 0 && (lastEjectTime + EJECT_DELAY < Level.TimeSeconds))
	{
		lastEjectTime = Level.TimeSeconds;
		numShellToEject--;
		Super.SpawnShellCase();
	}
}

function SpawnShellCase()
{
	if ( numShellIn == MAX_SHELL_IN )
	{
		numShellToEject = 1;
	}
	else
	{
	numShellIn++;
	}
}

function bool Reload()
	{
	numShellToEject = numShellIn;
		numShellIn = 0;
	return Super.Reload();
}

defaultproperties
{
    FOVs(0)=14.000000
    Ammo=60
    MaxAmmo=60
    ClipAmmo=30
    ClipMaxAmmo=30
    RateOfFire=0.0720000
    BaseDamage=100
    FireNoiseRadius=800
    FireSingleShotSound=Sound'FisherEquipement.Play_FN2000SingleShot'
    FireAutomaticSound=Sound'FisherEquipement.Play_FN2000InfiniteShot'
    FireAutomaticEndSound=Sound'FisherEquipement.StopGo_FN2000ShotEnd'
    ReloadSound=Sound'FisherEquipement.Play_FN2000Reload'
    EmptySound=Sound'GunCommon.Play_RifleEmpty'
    EjectedClass=Class'EShellCaseBig'
    EjectedOffset=(X=22.0000000,Y=2.5025000,Z=9.0000000)
    MuzzleOffset=(X=53.0620000,Y=0.0000000,Z=7.4747900)
    MagazineMesh=StaticMesh'EMeshIngredient.weapon.F2000MAG'
    MagazineOffset=(X=-11.6460000,Y=0.0000100,Z=3.5576100)
    RecoilStrength=1.0000000
    RecoilAngle=0.2500000
    RecoilFadeIn=20.0000000
    RecoilFadeOut=6.0000000
    UseAccuracy=true
    AccuracyMovementModifier=5.0000000
    AccuracyReturnModifier=13.0000000
    AccuracyBase=0.2000000
    ObjectHudClass=Class'EF2000Reticle'
    StaticMesh=StaticMesh'EMeshIngredient.weapon.f2000'
}