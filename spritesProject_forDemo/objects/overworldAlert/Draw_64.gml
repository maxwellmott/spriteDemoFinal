if !(surface_exists(game.guiSurface)) {
	game.guiSurface = surface_create(guiWidth, guiHeight);
}

surface_set_target(game.guiSurface);
	draw_sprite_stretched(spr_overworldAlert, 0, x, y, guiWidth, guiHeight);
	draw_set_font(overworldFont);
	draw_set(fa_left, fa_top, 1.0, c_white);
	draw_text(textX - 1, textY - 1, writtenText);
	draw_set(fa_left, fa_top, 1.0, c_black);
	draw_text(textX, textY, writtenText);

	if ynPrompt
	&& writtenText == text
		yesNo.method_draw();
		
surface_reset_target();