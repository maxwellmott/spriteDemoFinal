pSundown	= player.sundown;
pdAlpha		= player.darkAlpha;

// animate lights
if (pSundown) {
	lightBoost = ((1 / 8) * sin(global.gameTime / 16));
}