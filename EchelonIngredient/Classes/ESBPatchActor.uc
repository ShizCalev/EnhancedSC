class ESBPatchActor extends ESoftBodyActor native placeable;

var(SBPatch) float		scaleU;
var(SBPatch) float		scaleV;
var(SBPatch) int		nbU;
var(SBPatch) int		nbV;
var(SBPatch) float		Ulength;
var(SBPatch) float		Vlength;
var(SBPatch) bool		TopLeftFixed;
var(SBPatch) bool		TopRightFixed;
var(SBPatch) bool		BottomLeftFixed;
var(SBPatch) bool		BottomRightFixed;
var(SBPatch) bool		TopFixed;
var(SBPatch) bool		BottomFixed;
var(SBPatch) bool		LeftFixed;
var(SBPatch) bool		RightFixed;
var			 bool		prevTopLeftFixed;
var			 bool		prevTopRightFixed;
var			 bool		prevBottomLeftFixed;
var			 bool		prevBottomRightFixed;
var			 bool		prevTopFixed;
var			 bool		prevBottomFixed;
var			 bool		prevLeftFixed;
var			 bool		prevRightFixed;
var			 int			prevNbU;
var			 int			prevNbV;
var			 float		prevUlength;
var			 float		prevVlength;

defaultproperties
{
    scaleU=1.0000000
    scaleV=1.0000000
    nbU=3
    nbV=3
    Ulength=10.0000000
    Vlength=10.0000000
    TopFixed=true
    prevNbU=3
    prevNbV=3
    prevUlength=10.0000000
    prevVlength=10.0000000
    windMin=(X=0.0000000,Y=-100.0000000,Z=0.0000000)
    windMax=(X=0.0000000,Y=300.0000000,Z=0.0000000)
    windUScale=2.0000000
    windVScale=2.0000000
    windUPan=0.7000000
    windVPan=0.3100000
    collRepulse=0.1000000
    nbIter=3
    nbNormalizeIter=2
    collSubDiv=1
    bNPCBulletGoTru=true
    bPlayerBulletGoTru=true
}