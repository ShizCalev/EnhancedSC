class EOpticCableView extends EObjectHUD;

state s_Sneaking
{
	function DrawView( HUD hud, ECanvas Canvas )
	{
		DrawSniperMask(Canvas);
	}
}

