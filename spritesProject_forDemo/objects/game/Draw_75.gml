/// @desc draw guiSurface to GUI layer

if (instance_exists(mouse)) {
	event_perform_object(mouse, ev_gui, 0);
}

if !(surface_exists(guiSurface)) {
	guiSurface = surface_create(guiWidth, guiHeight);
}

if (surface_exists(application_surface)) {
	draw_surface_stretched(application_surface, 0, 0, display_get_gui_width(), display_get_gui_height());
}

if (instance_exists(overworldDraw)) {
	if (overworld.tilemapList[| tilemaps.upperStory] != -1) {
		if (surface_exists(overworldDraw.upperStorySurface)) {
			draw_surface_part_ext(overworldDraw.upperStorySurface, camera.x - (guiWidth / 2), camera.y - (guiHeight / 2), guiWidth, guiHeight, 0, 0, display_get_gui_width() / guiWidth, display_get_gui_height() / guiHeight, c_white, 1.0);
		}
	}
}

draw_surface_stretched(guiSurface, 0, 0, display_get_gui_width(), display_get_gui_height());