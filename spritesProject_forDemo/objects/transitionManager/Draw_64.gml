
/// @desc

surface_set_target(game.guiSurface);

	draw_set_alpha(alpha);

	draw_rectangle_color(0, 0, guiWidth, guiHeight, COL_BLACK, COL_BLACK, COL_BLACK, COL_BLACK, false);

	draw_set_alpha(1.0);

surface_reset_target();