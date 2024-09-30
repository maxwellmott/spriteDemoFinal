///@desc clear both surfaces

if !(surface_exists(lightingSurface)) {
	lightingSurface		= surface_create(locationWidth, locationHeight);
}

surface_set_target(lightingSurface);
	draw_clear_alpha(c_black, 0.0);
surface_reset_target();

#region create darkSurface

if (overworld.sceneryCreated) {
	surface_set_target(lightingSurface);
		draw_clear_alpha(darkColor, pdAlpha);

		gpu_set_blendmode(bm_subtract);
		
			var ls	= lightBoost;
		
			with (lamppost) {
				draw_sprite_ext(lightMask, 0, x, lightY, lightScale + ls, lightScale + ls, 0, c_white, 1.0);
			}
			
			if (instance_exists(mainMenu)) {
				with (mainMenu) {
					if !(introFinished) {
						draw_sprite(spr_soulStone, image_index, x, y);	
					}
					
					if (introFinished) {
						if !(outroStarted) {
							draw_sprite(spr_soulStone, 8, x, y);
						}
						else {
							draw_sprite(spr_soulStoneClose, image_index, x, y);	
						}
					}
				}
			}
		
		gpu_set_blendmode(bm_normal);
	
	surface_reset_target();
}

#endregion