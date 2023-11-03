/// @desc clear guiSurface

if !(surface_exists(guiSurface)) {
	guiSurface = surface_create(guiWidth, guiHeight);
}

surface_set_target(guiSurface);
	draw_clear_alpha(c_black, 0.0);
surface_reset_target();