class ELada extends EGameplayObject;

#exec OBJ LOAD FILE=..\textures\ETexIngredient.utx

// Joshua - Commented out because the PSK file exported from UModel doesn't seem to be compatible with the SC engine.
// This actor does not appear to be used in the final game.
/*
#exec MESH  MODELIMPORT MESH=ladaMesh MODELFILE=models\lada.PSK LODSTYLE=10
#exec MESH  ORIGIN MESH=ladaMesh X=0 Y=0 Z=0 YAW=192 PITCH=0 ROLL=0
#exec ANIM  IMPORT ANIM=ladaAnims ANIMFILE=models\lada.PSA COMPRESS=1 MAXKEYS=999999
#exec MESHMAP   SCALE MESHMAP=ladaMesh X=1.0 Y=1.0 Z=1.0
#exec MESH  DEFAULTANIM MESH=ladaMesh ANIM=ladaAnims

#exec MESHMAP SETTEXTURE MESHMAP=ladaMesh NUM=0 TEXTURE=lada
#exec MESHMAP SETTEXTURE MESHMAP=ladaMesh NUM=1 TEXTURE=tire

#exec ANIM DIGEST  ANIM=ladaAnims USERAWINFO VERBOSE

defaultproperties
{
    DrawType=DT_Mesh
    Mesh=SkeletalMesh'ladaMesh'
}
*/