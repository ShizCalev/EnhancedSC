class EBeretta92FS extends EOneHandedWeapon;

#exec OBJ LOAD FILE=..\Sounds\Gun.uax

defaultproperties
{
    Ammo=45
    MaxAmmo=45
    ClipAmmo=15
    ClipMaxAmmo=15
    RateOfFire=0.1870000
    BaseDamage=100
    FireNoiseRadius=400
    FireSingleShotSound=Sound'Gun.Play_BER9SingleShot'
    ReloadSound=Sound'Gun.Play_BER9Reload'
    EmptySound=Sound'GunCommon.Play_PistolEmpty'
    EjectedClass=Class'EShellCaseSmall'
    EjectedOffset=(X=-0.4836000,Y=0.6594000,Z=7.9458000)
    MuzzleOffset=(X=30.0000000,Y=0.0000000,Z=9.0000000)
    StaticMesh=StaticMesh'EMeshIngredient.weapon.beretta'
    CollisionRadius=6.0000000
    CollisionHeight=6.0000000
}