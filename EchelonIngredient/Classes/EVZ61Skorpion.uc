class EVZ61Skorpion extends EOneHandedWeapon;

#exec OBJ LOAD FILE=..\Sounds\Gun.uax

defaultproperties
{
    Ammo=60
    MaxAmmo=60
    ClipAmmo=20
    ClipMaxAmmo=20
    RateOfFire=0.0710000
    BaseDamage=100
    FireNoiseRadius=2000
    FireSingleShotSound=Sound'Gun.Play_VZ61SingleShot'
    FireAutomaticSound=Sound'Gun.Play_VZ61InfiniteShot'
    FireAutomaticEndSound=Sound'Gun.StopGo_VZ61ShotEnd'
    ReloadSound=Sound'Gun.Play_VZ61Reload'
    EmptySound=Sound'GunCommon.Play_RifleEmpty'
    EjectedClass=Class'EShellCaseSmall'
    EjectedOffset=(X=13.1692000,Y=1.3098000,Z=8.4461000)
    MuzzleFlashClass=Class'EMuzzleFlash'
    MuzzleOffset=(X=25.6491500,Y=0.0000200,Z=10.1104100)
    StaticMesh=StaticMesh'EMeshIngredient.weapon.SubCZ61'
}