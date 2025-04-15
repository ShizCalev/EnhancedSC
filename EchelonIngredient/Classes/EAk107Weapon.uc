class EAk107Weapon extends ETwoHandedWeapon;

#exec OBJ LOAD FILE=..\Sounds\Gun.uax

defaultproperties
{
    Ammo=90
    MaxAmmo=90
    ClipAmmo=30
    ClipMaxAmmo=30
    RateOfFire=0.1000000
    BaseDamage=125
    FireNoiseRadius=2000
    FireSingleShotSound=Sound'Gun.Play_AK47SingleShot'
    FireAutomaticSound=Sound'Gun.Play_AK47InfiniteShot'
    FireAutomaticEndSound=Sound'Gun.StopGo_AK47ShotEnd'
    ReloadSound=Sound'Gun.Play_AK47Reload'
    EmptySound=Sound'GunCommon.Play_RifleEmpty'
    EjectedClass=Class'EShellCaseBig'
    EjectedOffset=(X=-5.0000000,Y=1.0000000,Z=12.0000000)
    MuzzleFlashClass=Class'EMuzzleFlash'
    MuzzleOffset=(X=61.7112900,Y=-0.0000200,Z=9.9906900)
    StaticMesh=StaticMesh'EMeshIngredient.weapon.AK107'
}