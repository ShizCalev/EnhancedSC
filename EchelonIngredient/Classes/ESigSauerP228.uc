class ESigSauerP228 extends EOneHandedWeapon;

#exec OBJ LOAD FILE=..\Sounds\Gun.uax

defaultproperties
{
    Ammo=45
    MaxAmmo=45
    ClipAmmo=15
    ClipMaxAmmo=155
    RateOfFire=0.1870000
    BaseDamage=100
    FireNoiseRadius=400
    FireSingleShotSound=Sound'Gun.Play_BER9SingleShot'
    ReloadSound=Sound'Gun.Play_BER9Reload'
    EmptySound=Sound'GunCommon.Play_PistolEmpty'
    EjectedClass=Class'EShellCaseSmall'
    EjectedOffset=(X=7.6551000,Y=0.8115000,Z=9.3100000)
    MuzzleOffset=(X=16.4919800,Y=-0.0000200,Z=8.9052000)
    StaticMesh=StaticMesh'EMeshIngredient.weapon.P228'
    CollisionRadius=6.0000000
    CollisionHeight=6.0000000
}