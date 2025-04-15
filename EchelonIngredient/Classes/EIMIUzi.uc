class EIMIUzi extends EOneHandedWeapon;

#exec OBJ LOAD FILE=..\Sounds\Gun.uax

defaultproperties
{
    Ammo=64
    MaxAmmo=64
    ClipAmmo=32
    ClipMaxAmmo=32
    RateOfFire=0.1000000
    BaseDamage=100
    FireNoiseRadius=2000
    FireSingleShotSound=Sound'Gun.Play_UZIISingleShot'
    FireAutomaticSound=Sound'Gun.Play_UZIIInfiniteShot'
    FireAutomaticEndSound=Sound'Gun.StopGo_UZIIShotEnd'
    ReloadSound=Sound'Gun.Play_UZIIReload'
    EmptySound=Sound'GunCommon.Play_RifleEmpty'
    EjectedClass=Class'EShellCaseSmall'
    EjectedOffset=(X=2.2116000,Y=0.9177000,Z=11.0073000)
    MuzzleFlashClass=Class'EMuzzleFlash'
    MuzzleOffset=(X=29.6071100,Y=0.0000200,Z=9.4592600)
    StaticMesh=StaticMesh'EMeshIngredient.weapon.Uzi'
}