class ESBRopeActor extends ESoftBodyActor native placeable;

#exec OBJ LOAD FILE=..\textures\ETexIngredient.utx 

var(SBRope) float		scaleU;
var(SBRope) float		lengthV;
var(SBRope) int			nbSeg;
var(SBRope) float		Length;
var(SBRope) float		Radius;
var			int			prevNbSeg;
var			float		prevLength;

defaultproperties
{
    scaleU=2.0000000
    lengthV=2.0000000
    nbSeg=10
    Length=10.0000000
    Radius=0.7500000
    prevNbSeg=10
    prevLength=10.0000000
    windMin=(X=-50.0000000,Y=-50.0000000,Z=0.0000000)
    windMax=(X=50.0000000,Y=50.0000000,Z=0.0000000)
    windUScale=0.5000000
    windVScale=0.5000000
    windUPan=0.2000000
    windVPan=0.1100000
    nbNormalizeIter=8
    pillsTest=true
    Texture=Texture'ETexIngredient.Object.Rope'
    CollisionRadius=2.0000000
}