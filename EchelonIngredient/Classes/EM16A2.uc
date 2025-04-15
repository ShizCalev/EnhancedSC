class EM16A2 extends ETwoHandedWeapon;

#exec OBJ LOAD FILE=..\Sounds\Gun.uax

defaultproperties
{
    Ammo=90
    MaxAmmo=90
    ClipAmmo=30
    ClipMaxAmmo=30
    RateOfFire=0.0720000
    BaseDamage=125
    FireNoiseRadius=2000
    FireSingleShotSound=Sound'Gun.Play_M16ASingleShot'
    ReloadSound=Sound'Gun.Play_M16AReload'
    EmptySound=Sound'GunCommon.Play_RifleEmpty'
    EjectedClass=Class'EShellCaseBig'
    EjectedOffset=(X=14.2145000,Y=1.4406000,Z=5.8501000)
    MuzzleFlashClass=Class'EMuzzleFlash'
    MuzzleOffset=(X=73.3863400,Y=-0.0000200,Z=10.2317300)
    StaticMesh=StaticMesh'EMeshIngredient.weapon.M16A2'
}