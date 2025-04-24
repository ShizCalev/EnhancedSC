class EFragGrenade extends EInventoryItem
	Config(Enhanced); // Joshua - Class, configurable in Enhanced config

#exec OBJ LOAD FILE=..\Sounds\Interface.uax

/*-----------------------------------------------------------------------------
    Function :      PostBeginPlay

    Description:    -
-----------------------------------------------------------------------------*/
function PostBeginPlay()
{
	Super.PostBeginPlay();

		// Joshua - Elite Mode will override this setting if greater than 150.0
	if (EchelonGameInfo(Level.Game).bEliteMode)
	{
		if (ExplosionDamage > 150.0)	
			ExplosionDamage = 150.0;
	}

	// manage quantity
	if( Quantity == 1 )
		SetStaticMesh(default.StaticMesh);
	else
		SetStaticMesh(StaticMesh'EMeshIngredient.Item.FragGrenadePack_6');
    
	HUDTex       = EchelonLevelInfo(Level).TICON.qi_ic_grenades;
    InventoryTex = EchelonLevelInfo(Level).TICON.inv_ic_grenades;
    ItemName     = "FragGrenade";
	ItemVideoName = "gd_grenade.bik";
    Description  = "FragGrenadeDesc";
	HowToUseMe  = "FragGrenadeHowToUseMe";
}

//---------------------------------------[David Kalina - 26 Nov 2001]-----
// 
// Description
//		Thrower wants to throw us at specified velocity.
//
//------------------------------------------------------------------------

function Throw(Controller Thrower, vector ThrowVelocity)
{
	Super.Throw(Thrower, ThrowVelocity);

	if ( Thrower.bIsPlayer )
		Level.AddChange(self, CHANGE_Grenade);
}


state s_Flying
{
	function BeginState()
	{
		Super.BeginState();

		bPickable = false;
		SetTimer(ExplodeTimer, false);
	}
	
	function Timer()
	{
		// destroy will call the explosion and related damage stuff
		PlaySound(Sound'FisherEquipement.Play_FragGrenadeExplosion', SLOT_SFX);
		DestroyObject();
	}
}

function Select( EInventory Inv )
{
	Super.Select(Inv);
	PlaySound(Sound'Interface.Play_FisherEquipFragGrenade', SLOT_Interface);
}

defaultproperties
{
    MaxQuantity=6
    HitNoiseRadius=750.0000000
    bDamageable=true
    bExplodeWhenDestructed=true
    ExplosionClass=Class'EchelonEffect.EGrenadeExplosion'
    ExplosionDamageClass=Class'Engine.Crushed'
    ExplosionDamage=100.0000000
    ExplosionMinRadius=300.0000000
    ExplosionMaxRadius=400.0000000
    ExplodeTimer=3.0000000
    StaticMesh=StaticMesh'EMeshIngredient.Item.FragGrenade'
    DrawScale=0.5000000
    CollisionRadius=4.0000000
    CollisionHeight=4.0000000
    bIsProjectile=true
    Mass=60.0000000
}