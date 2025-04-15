class EUmp extends ETwoHandedWeapon;

#exec OBJ LOAD FILE=..\Sounds\Gun.uax

defaultproperties
{
    Ammo=60
    MaxAmmo=60
    ClipAmmo=30
    ClipMaxAmmo=30
    RateOfFire=0.0750000
    BaseDamage=100
    FireNoiseRadius=200
    FireSingleShotSound=Sound'Gun.Play_HKMP5SingleShot'
    FireAutomaticSound=Sound'Gun.Play_HKMP5InfiniteShot'
    FireAutomaticEndSound=Sound'Gun.StopGo_HKMP5ShotEnd'
    ReloadSound=Sound'Gun.Play_HKMP5Reload'
    EmptySound=Sound'GunCommon.Play_RifleEmpty'
    EjectedClass=Class'EShellCaseBig'
    EjectedOffset=(X=14.7495000,Y=1.0892000,Z=11.0597000)
    MuzzleFlashClass=Class'EMuzzleFlash'
    MuzzleOffset=(X=44.0000000,Y=0.0000000,Z=11.0000000)
    StaticMesh=StaticMesh'EMeshIngredient.weapon.Mp5A4'
}