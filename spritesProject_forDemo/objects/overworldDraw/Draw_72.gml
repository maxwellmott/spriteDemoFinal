///@desc clear both surfaces

if !(surface_exists(lightingSurface)) {
	lightingSurface		= surface_create(locationWidth, locationHeight);
}

if !(surface_exists(upperStorySurface)) {
	upperStorySurface = surface_create(overworld.locationWidth, overworld.locationHeight);
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

			if (instance_exists(mouse)) {
				with (mouse) {
					draw_self();	
				}
			}
			
			if (instance_exists(wavephoneController)) {
				with (wavephoneController) {
					// check that outro has not yet started
					if !(outroStarted) {
						// check that intro is not yet finished
						if !(introFinished) {
							draw_sprite(sprite_index, image_index, x, y);	
						}
						else {
							draw_sprite(sprite_index, image_number - 1, x, y);
							
							wavephone_draw_keys();
						}
					}
					// if outro has started
					else {
						// draw closing animation
						draw_sprite(sprite_index, (image_number - 1) - image_index, x, y);
					}	
				}
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
			
			if (instance_exists(emoteMenu)) {
				with (emoteMenu) {
					// check that outro has not yet started
					if !(outroStarted) {
						// check that intro is not yet finished
						if !(introFinished) {
							draw_sprite(sprite_index, image_index, x, y);	
						}
						else {
							draw_sprite(sprite_index, image_number - 1, x, y);	
						}
					}
					// if outro has started
					else {
						// draw closing animation
						draw_sprite(sprite_index, (image_number - 1) - image_index, x, y);
					}
				}
			}
			
			if (instance_exists(actionMenu)) {
				with (actionMenu) {
					// check that outro has not yet started
					if !(outroStarted) {
						// check that intro is not yet finished
						if !(introFinished) {
							draw_sprite(sprite_index, image_index, x, y);	
						}
						else {
							draw_sprite(sprite_index, image_number - 1, x, y);	
						}
					}
					// if outro has started
					else {
						// draw closing animation
						draw_sprite(sprite_index, (image_number - 1) - image_index, x, y);
					}	
				}
			}
		
			if (instance_exists(responseMenu)) {
				with (responseMenu) {
					var i = 0;	repeat (responseCount) {
						var left	= leftList[| i];
						var right	= rightList[| i];
						var top		= topList[| i];
						var bottom	= bottomList[| i];
						
						draw_sprite(buttonSprite, 0, left, top);
						
						i++;
					}

					draw_sprite(questionDisplaySprite, 0, questionDisplayX, questionDisplayY);	
				}
			}
		
			if (instance_exists(unlockAlert)) {
				with (unlockAlert) {
					draw_set_alpha(alpha);
					
					draw_sprite(spr_unlockAlerts, num, x, y);	
				
					draw_set_alpha(1.0);
				}
			}
		
			if (instance_exists(window)) {
				with (window) {
					if (window.frame == 1) {
						draw_scenery();
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

#region create upperStorySurface
	surface_set_target(upperStorySurface);
	
		draw_tilemap(overworld.tilemapList[| tilemaps.upperStory], 0, 0);
		
		if (instance_exists(door)) {
			with (door) {
				if (upperFloor) {
					draw_sprite_part(doorSheet, frame, 0, spriteTop, spriteWidth, spriteHeight, x, y);
				}
			}
		}
		
		// change blendmode to subtractive
		gpu_set_blendmode(bm_subtract);
		
		if (instance_exists(wavephoneController)) {
			with (wavephoneController) {
				// check that outro has not yet started
				if !(outroStarted) {
					// check that intro is not yet finished
					if !(introFinished) {
						draw_sprite(sprite_index, image_index, x, y);	
					}
					else {
						draw_sprite(sprite_index, image_number - 1, x, y);	
						
						wavephone_draw_keys();
					}
				}
				// if outro has started
				else {
					// draw closing animation
					draw_sprite(sprite_index, (image_number - 1) - image_index, x, y);
				}	
			}
		}
		
		if (instance_exists(mouse)) {
			with (mouse) {
				draw_self();	
			}
		}	
		
		if (instance_exists(mainMenu)) {
			with (mainMenu) {
				// check that outro has not yet started
				if !(outroStarted) {
					// check that intro is not yet finished
					if !(introFinished) {
						draw_sprite(sprite_index, image_index, x, y);	
					}
					else {
						draw_sprite(sprite_index, image_number - 1, x, y);	
					}
				}
				// if outro has started
				else {
					// draw closing animation
					draw_sprite(spr_soulStoneClose, image_index, x, y);
				}
			}
		}
		
		if (instance_exists(emoteMenu)) {
			with (emoteMenu) {
				// check that outro has not yet started
				if !(outroStarted) {
					// check that intro is not yet finished
					if !(introFinished) {
						draw_sprite(sprite_index, image_index, x, y);	
					}
					else {
						draw_sprite(sprite_index, image_number - 1, x, y);	
					}
				}
				// if outro has started
				else {
					// draw closing animation
					draw_sprite(sprite_index, (image_number - 1) - image_index, x, y);
				}
			}
		}
		
		if (instance_exists(actionMenu)) {
			with (actionMenu) {
				// check that outro has not yet started
				if !(outroStarted) {
					// check that intro is not yet finished
					if !(introFinished) {
					draw_sprite(sprite_index, image_index, x, y);	
				}
					else {
						draw_sprite(sprite_index, image_number - 1, x, y);	
					}
				}
				// if outro has started
				else {
					// draw closing animation
					draw_sprite(sprite_index, (image_number - 1) - image_index, x, y);
				}	
			}
		}
		
		if (instance_exists(responseMenu)) {
			with (responseMenu) {
				var i = 0;	repeat (responseCount) {
					var left	= leftList[| i];
					var right	= rightList[| i];
					var top		= topList[| i];
					var bottom	= bottomList[| i];
					
					draw_sprite(buttonSprite, 0, left, top);
					
					i++;
				}
		
				draw_sprite(questionDisplaySprite, 0, questionDisplayX, questionDisplayY);	
			}
		}
	
		if (instance_exists(talkBubble)) {
			with (talkBubble) {
				// draw talk bubble
				draw_sprite(bubbleSprite, 0, bubbleX, bubbleY);
			}
		}
		
		if (instance_exists(unlockAlert)) {
			with (unlockAlert) {
				draw_set_alpha(alpha);
				
				draw_sprite(spr_unlockAlerts, num, x, y);	
			
				draw_set_alpha(1.0);
			}
		}
		
		// set circle radius
		var r = 10 + (sin(global.gameTime / 40) * 1.5);
	
		// draw a circle over the player
		draw_circle(player.x - 1, player.y - 7, r, false);
	
		if (instance_exists(window)) {
			with (window) {
					draw_sprite(spriteID, frame, x, y);
					draw_sprite(spriteID, frame, x, y);
					draw_sprite(spriteID, frame, x, y);
			}
		}
		
	
		// change blendmode back to normal
		gpu_set_blendmode(bm_normal);
	surface_reset_target();
#endregion