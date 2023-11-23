if !(surface_exists(game.guiSurface)) {
	game.guiSurface = surface_create(guiWidth, guiHeight);
}

surface_set_target(game.guiSurface);
	draw_set_font(plainFont);
	draw_set(fa_left, fa_top, 1.0, c_black);
	draw_text(textX - 1, textY - 1, writtenText);
		
surface_reset_target();