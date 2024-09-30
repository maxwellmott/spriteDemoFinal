if !(instance_exists(overworld)) {
	// set surface target
	surface_set_target(game.guiSurface);
	
		draw_self();
	
	surface_reset_target();
}