/// @desc draw guiSurface to GUI layer

if (instance_exists(mouse)) {
	event_perform_object(mouse, ev_gui, 0);
}

if !(surface_exists(guiSurface)) {
	guiSurface = surface_create(guiWidth, guiHeight);
}

draw_surface_stretched(guiSurface, 0, 0, display_get_gui_width(), display_get_gui_height());