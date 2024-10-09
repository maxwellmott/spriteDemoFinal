///@desc clear both surfaces

if !(surface_exists(lightingSurface)) {
	lightingSurface		= surface_create(locationWidth, locationHeight);
}

surface_set_target(lightingSurface);
	draw_clear_alpha(c_black, 0.0);
surface_reset_target();

surface_set_target(upperStorySurface);
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

// draw all tilemaps except upstairs
var i = 0;	repeat (ds_list_size(overworld.tilemapList) - 1) {
	draw_tilemap(overworld.tilemapList[| i], 0, 0);

	i++;	
}

// prepare the upper story surface
surface_set_target(upperStorySurface);
	draw_tilemap(overworld.tilemapList[| tilemaps.upperStory], 0, 0);

	// change blendmode to subtractive
	gpu_set_blendmode(bm_subtract);
	
	if (instance_exists(mainMenu)) {
		with (mainMenu) {
			// check that outro has not yet started
			if !(outroStarted) {
				// check that intro is not yet finished
				if !(introFinished) {
					draw_sprite(sprite_index, image_index, x, y);	
				}
				else {
					draw_sprite(sprite_index, 8, x, y);	
				}
			}
			// if outro has started
			else {
				// draw closing animation
				draw_sprite(spr_soulStoneClose, image_index, x, y);
			}
		}
	}

	// set circle radius
	var r = 20 + (sin(global.gameTime / 40) * 2);

	// draw a circle over the player
	draw_circle(player.x - 1, player.y - 6, r, false);

	// reset alpha
	draw_set_alpha(1.0);

	// change blendmode back to normal
	gpu_set_blendmode(bm_normal);
surface_reset_target();