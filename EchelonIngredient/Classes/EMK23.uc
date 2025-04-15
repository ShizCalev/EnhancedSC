class EMK23 extends EOneHandedWeapon;

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
    EjectedOffset=(X=8.7864000,Y=1.1104000,Z=10.1073000)
    MuzzleFlashClass=Class'EMuzzleFlash'
    MuzzleOffset=(X=21.5561400,Y=0.0000200,Z=9.8127400)
    StaticMesh=StaticMesh'EMeshIngredient.weapon.Mk23'
}