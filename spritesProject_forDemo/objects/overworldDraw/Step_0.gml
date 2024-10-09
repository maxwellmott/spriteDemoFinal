pSundown	= player.sundown;
pdAlpha		= player.darkAlpha;

// animate lights
if (pSundown) {
	lightBoost = ((1 / 12) * sin(global.gameTime / 272));
}