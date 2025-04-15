class E9mmMakarovPMM extends EOneHandedWeapon;

#exec OBJ LOAD FILE=..\Sounds\Gun.uax

defaultproperties
{
    Ammo=36
    MaxAmmo=36
    ClipAmmo=12
    ClipMaxAmmo=12
    RateOfFire=0.1870000
    BaseDamage=100
    FireNoiseRadius=2000
    FireSingleShotSound=Sound'Gun.Play_MAKASingleShot'
    ReloadSound=Sound'Gun.Play_MAKAReload'
    EmptySound=Sound'GunCommon.Play_PistolEmpty'
    EjectedClass=Class'EShellCaseSmall'
    EjectedOffset=(X=2.5964000,Y=0.9221000,Z=7.2461000)
    MuzzleFlashClass=Class'EMuzzleFlash'
    MuzzleOffset=(X=14.4818600,Y=0.0000200,Z=7.9742200)
    StaticMesh=StaticMesh'EMeshIngredient.weapon.Makarov'
}