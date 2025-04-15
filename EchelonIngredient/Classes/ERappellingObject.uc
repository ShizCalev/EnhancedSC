class ERappellingObject extends EGameplayObject;

var()	float			RappellingHeight;
var		ERapelRopeActor	Rope;

defaultproperties
{
    RappellingHeight=2000.0000000
    bDamageable=false
    StaticMesh=StaticMesh'EMeshIngredient.Object.VentExit'
    DrawScale=0.5000000
    CollisionRadius=13.0000000
    CollisionHeight=37.0000000
    bBlockPlayers=true
    bBlockActors=true
    InteractionClass=Class'ERappellingInteraction'
    bDirectional=true
}