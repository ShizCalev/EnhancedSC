class EOceanInfo extends Info
	noexport
	native
	placeable;

///////////////////////////////////////////////////
// editor variables ///////////////////////////////
///////////////////////////////////////////////////	 
var(OceanProperties) Texture	SkyTexture;
var(OceanProperties) Texture	DropTexture;
var(OceanProperties) Texture	CutoutTexture;
var(OceanProperties) Texture	OceanWaterTexture;
var(OceanProperties) Material	GF2OceanWaterTexture;

var(OceanProperties) array<name>	DoNotRenderInShadowBufferList;

var(OceanProperties) FLOAT		SizeX;
var(OceanProperties) FLOAT		SizeY;

var(OceanProperties) FLOAT		TileX;
var(OceanProperties) FLOAT		TileY;

var(OceanProperties) BOOL		m_bTransparent;

var const transient native EOceanPrimitive oceanPrimitive;

var(OceanSettings)		FLOAT	m_fDropletFreq;
var(OceanSettings)		FLOAT	m_fDropletMinSize;
var(OceanSettings)		FLOAT	m_fDropletMaxSize;
var(OceanSettings)		FLOAT	m_fWindX;
var(OceanSettings)		FLOAT	m_fWindY;
var(OceanSettings)		FLOAT	m_fScrollU;
var(OceanSettings)		FLOAT	m_fScrollV;
var(OceanSettings)		FLOAT	m_fBlurDist;
var(OceanSettings)		FLOAT	m_fForceFactor;
var(OceanSettings)		FLOAT	m_fVelFactor;
var(OceanSettings)		FLOAT	m_fEqRestore_factor;
var(OceanSettings)		FLOAT	m_fPosAtten;
var(OceanSettings)		FLOAT	m_fNrmlSTScale;
var(OceanSettings)		FLOAT	m_fDispSc;
var(OceanSettings)		FLOAT	m_fTxCrdDispScale;
var(OceanSettings)		Color	m_cFresnelColor;
var(OceanSettings)		BOOL	m_bReset;

var						FLOAT	m_fElapsedTime;
var(OceanSettings)		FLOAT	m_fUpdateTime;
var						FLOAT	m_fLastFrameTime;

var(OceanSettings)		FLOAT	m_fFresnelScale;
var(OceanSettings)		FLOAT	m_fFresnelOffset;

event BulletWentTru(Actor Instigator, vector HitLocation, vector HitNormal, vector Momentum, Material HitMaterial)
{
	// Takes care of wallhit. No damage or momentum added
	Instigator.SpawnWallHit(self, HitLocation, HitNormal, HitMaterial);
}

///////////////////////////////////////////////////
// default properties /////////////////////////////
///////////////////////////////////////////////////

defaultproperties
{
    SizeX=5000.0000000
    SizeY=5000.0000000
    TileX=10.0000000
    TileY=10.0000000
    m_fDropletFreq=0.1750000
    m_fDropletMinSize=0.2500000
    m_fDropletMaxSize=0.3500000
    m_fBlurDist=0.1100000
    m_fForceFactor=0.5000000
    m_fVelFactor=0.5000000
    m_fEqRestore_factor=0.1700000
    m_fPosAtten=0.9800000
    m_fNrmlSTScale=0.2300000
    m_fDispSc=0.8000000
    m_fTxCrdDispScale=0.3000000
    m_cFresnelColor=(R=34,G=34,B=120,A=255)
    m_fUpdateTime=0.0333330
    m_fFresnelScale=1.0000000
    bHidden=false
    bWorldGeometry=true
    bUnlit=true
    bStaticLighting=true
}