if !(outroStarted) {
	draw_self();
	
	if (introFinished) {
		draw_set_alpha(0.7);
		draw_sprite(spr_wavephoneTrackerLines, trackerLineFrame, x, y);
		draw_set_alpha(1.0);
		
		draw_sprite(spr_wavephoneTracker, 0, indicatorX, indicatorY);	
		
		wavephone_draw_keys();
	}
}
else {
	draw_sprite(sprite_index, image_number - image_index - 1, x, y);
}