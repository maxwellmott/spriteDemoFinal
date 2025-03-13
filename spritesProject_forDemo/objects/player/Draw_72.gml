// check if the player is wearing a hat
if (hat != hats.nothing) {
	// check if hatSurface doesn't exist	
	if !(surface_exists(hatSurface)) {
		// create it again
		hatSurface = surface_create(24, 42);
	}
	// if it already exists
	else {
		// copy a section to the hatSurface
		surface_copy_part(hatSurface, 0, 0, application_surface, drawX, drawY, 24, 11);
		
		// draw to the surface
		surface_set_target(hatSurface);
			
			// set blendmode to subtractive
			gpu_set_blendmode(bm_subtract);
				
				// cut the hat out of the rectangle
				draw_sprite_part_ext(hatSheet,		0, (facing * (humanSpriteWidth * 4)) + (frame * humanSpriteWidth),	humanSheetHeight * hat,			humanSpriteWidth, humanSpriteHeight, drawX, drawY, 1, 1, c_black,		1.0);
				
			// reset blendmode
			gpu_set_blendmode(bm_normal);
		// reset target
		surface_reset_target();
	}
}