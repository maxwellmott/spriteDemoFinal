// check if this is the overworld
if (instance_exists(overworld)) {
	// check if the player is wearing a hat
	if (hat != hats.nothing) {
		// check if hatSurface is missing
		if !(surface_exists(hatSurface)) {
			// create hatSurface
			hatSurface = surface_create(display_get_gui_width(), display_get_gui_height());
		}
		
		// set target to hatSurface
		surface_set_target(hatSurface);
		
			// clear hatSurface
			draw_clear_alpha(c_black, 0);
		
			// calculate the x and y scale for drawing the app surface to the hat surface
			var xScale = display_get_width() div guiWidth;
			var yScale = round(display_get_height() / guiHeight);
			
		
			// draw application surface onto hatSurface
			draw_surface_ext(application_surface, drawX - (display_get_gui_width() / 2), drawY - (display_get_gui_height() / 2), 1/ xScale, 1 / yScale, 0, c_white, 1);
			
			// create a list of any collisions with the hatSurface
			var l = ds_list_create();
			
			if (collision_rectangle_list(drawX, drawY, drawX + 24, drawY + 11, overworldDrawObjectParent, true, false, l, false)) {
				// set blendmode to subtractive
				gpu_set_blendmode(bm_subtract);
				
					// use a repeat loop to cut out a hole for any collision objects 
					var i = 0;	repeat (ds_list_size(l)) {
						event_perform_object(l[|i], ev_draw, 0);
						
						// increment i
						i++;
					}
				
				// reset blendmode	
				gpu_set_blendmode(bm_normal);
			}
		
		// reset surface target
		surface_reset_target();
	}
}