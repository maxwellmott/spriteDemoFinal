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

// calculate the x and y scale for drawing the app surface to the hat surface
var xScale = display_get_width() div guiWidth;
var yScale = round(display_get_height() / guiHeight);

if (instance_exists(overworldDraw)) {
	if (overworld.tilemapList[| tilemaps.upperStory] != -1) {
		if (surface_exists(overworldDraw.upperStorySurface)) {
			draw_surface_part_ext(overworldDraw.upperStorySurface, camera.x - (guiWidth / 2), camera.y - (guiHeight / 2), guiWidth, guiHeight, 0, 0, display_get_gui_width() / guiWidth, display_get_gui_height() / guiHeight, c_white, 1.0);
		}
	}
}

if (instance_exists(overworldDraw)) {
	with (overworldDraw) {
		if (instance_exists(player)) {
			if (pSundown) {
				if !(surface_exists(lightingSurface)) {			
					lightingSurface = surface_create(locationWidth, locationHeight);
				}
				
				// draw shadow surface
				draw_surface_part_ext(lightingSurface, camera.x - (guiWidth / 2), camera.y - (guiHeight / 2), guiWidth, guiHeight, 0, 0, display_get_gui_width() / guiWidth, display_get_gui_height() / guiHeight, c_white, 0.65);
			}
		}		
	}
}

if (instance_exists(cubeMenu)) {
	with (cubeMenu) {
		// set alpha as relative to the distance between rectangleY and rectTargetY and the height of the rectangle
		var a = ((80 - (rectangleY + 40)) / rectangleHeight) * 0.85;
		draw_set_alpha(a);
		
		// draw a rectangle over the screen
		draw_rectangle_color(0, 0, display_get_gui_width(), display_get_gui_height(), c_black, c_black, c_black, c_black, false);
		
		draw_set_alpha(1);
		
		// check if rectangleSurface doesn't exist
		if !(surface_exists(cubeMenuSurface)) {
			// create rectangleSurface
			cubeMenuSurface = surface_create(surfaceWidth, surfaceHeight);
		}
		
		// draw cubeMenuSurface
		draw_surface_ext(cubeMenuSurface, (display_get_gui_width() / 2) - ((surfaceWidth / 2) * (display_get_gui_width() / guiWidth)), (display_get_gui_height() / 2) - (((surfaceHeight / 2) - 24) * (display_get_gui_height() / guiHeight)), display_get_gui_width() / guiWidth, display_get_gui_height() / guiHeight, 0, c_white, 1.0);
	
		// redraw mouse
		draw_sprite_ext(mouse.sprite_index, mouse.image_index, device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), display_get_gui_width() / guiWidth, display_get_gui_height() / guiHeight, 0, c_white, 1.0);
	}
}

draw_surface_stretched(guiSurface, 0, 0, display_get_gui_width(), display_get_gui_height());