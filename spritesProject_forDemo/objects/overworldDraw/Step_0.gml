pSundown	= player.sundown;
pdAlpha		= player.darkAlpha;

// animate lights
if (pSundown) {
	lightBoost = ((1 / 12) * sin(current_time / 272));
}

/*
populate_object_draw_list();
if sortDepthNow	 object_depth_sort();
sortDepthNow = false;
*/