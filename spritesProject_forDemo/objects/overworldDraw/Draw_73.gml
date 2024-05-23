///@desc draw groundSurface and lightingSurface to the application_surface

if (instance_exists(player)) {
	if (pSundown) {
		if !(surface_exists(lightingSurface)) {			
			lightingSurface = surface_create(locationWidth, locationHeight);
		}
		
		// draw shadow surface
		draw_set_alpha(0.765);
		draw_surface(lightingSurface, 0, 0);
		draw_set_alpha(1.0);
	}
}