/// @desc draw guiSurface to GUI layer

if !(surface_exists(guiSurface)) {
	guiSurface = surface_create(guiWidth, guiHeight);
}

draw_surface_stretched(guiSurface, 0, 0, display_get_gui_width(), display_get_gui_height());