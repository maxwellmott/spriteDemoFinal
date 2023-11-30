/// @desc

surface_set_target(game.guiSurface);
	draw_set_alpha(alpha);
	
	draw_sprite(spr_mouse, frame, x, y);
	
	draw_set_alpha(1.0);
surface_reset_target();