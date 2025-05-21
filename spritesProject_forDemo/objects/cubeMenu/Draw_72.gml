// check if rectangleSurface doesn't exist
if !(surface_exists(cubeMenuSurface)) {
	// create rectangleSurface
	cubeMenuSurface = surface_create(112, 100);	
}

// set surfaceTarget
surface_set_target(cubeMenuSurface);
	
	// clear the surface
	draw_clear_alpha(c_white, 0);

	// create a state machine using the phase variable
	switch (phase) {
		case CUBE_MENU_PHASES.OPENING:
			// add the backlight sprite
			draw_sprite(spr_cubeMenu_backlight, image_index, centerX, centerY);
			
			// lower alpha
			draw_set_alpha(0.25);
			
				// draw the backlight sprite again
				draw_sprite(spr_cubeMenu_backlight, image_index, centerX, centerY);
			
			// reset alpha
			draw_set_alpha(1.0);
		
			// if top is not yet open
			if !(topOpen) {
				// draw opening animation
				draw_sprite(spr_cubeMenu_opening, image_index, cubeX, cubeY);
			}
			// if top is open
			else {
				// draw still frame
				draw_sprite(spr_cubeMenu_opening, openingFinalFrame, cubeX, cubeY);
			}
			
			// draw all buttons
			draw_sprite(spr_cubeMenu_wavephoneButton,	0,	wavephoneButtonX,	wavephoneButtonY);
			draw_sprite(spr_cubeMenu_talismanButton,	0,	talismanButtonX,	talismanButtonY);
			draw_sprite(spr_cubeMenu_inventoryButton,	0,	inventoryButtonX,	inventoryButtonY);
			draw_sprite(spr_cubeMenu_mirrorButton,		0,	wardrobeButtonX,	wardrobeButtonY);
			draw_sprite(spr_cubeMenu_spellbookButton,	0,	spellbookButtonX,	spellbookButtonY);
			
			// add the backlight sprite
			draw_sprite(spr_cubeMenu_frontlight, image_index, centerX, centerY);
			
			// lower alpha
			draw_set_alpha(0.25);
			
				// draw the frontlight sprite again
				draw_sprite(spr_cubeMenu_frontlight, image_index, centerX, centerY);
			
			// reset alpha
			draw_set_alpha(1.0);
			
			// check that glowBarFrame is not past glowBarFrameCount
			if (glowBarFrame < glowBarFrameCount) {
				// draw glowbar
				draw_sprite(spr_cubeMenu_glowBar, glowBarFrame, centerX, centerY);
			}
			
			// set blendmode to subtractive
			gpu_set_blendmode(bm_subtract);
			
				// draw rectangle
				draw_rectangle_color(centerX - (rectangleWidth / 2), rectangleY - (rectangleHeight / 2), centerX + (rectangleWidth / 2), rectangleY + (rectangleHeight / 2), c_black, c_black, c_black, c_black, false);
			
			// reset blendmode
			gpu_set_blendmode(bm_normal);
			
		break;
		
		case CUBE_MENU_PHASES.DISPLAY:
			// add the backlight sprite
			draw_sprite(spr_cubeMenu_backlight, image_index, centerX, centerY);
		
			// lower alpha
			draw_set_alpha(0.25);
			
				// draw the backlight sprite again
				draw_sprite(spr_cubeMenu_backlight, image_index, centerX, centerY);
			
			// reset alpha
			draw_set_alpha(1.0);
		
			// draw still frame
			draw_sprite(spr_cubeMenu_opening, openingFinalFrame, cubeX, cubeY);
		
			// draw all buttons
			draw_sprite(spr_cubeMenu_wavephoneButton,	0,	wavephoneButtonX,	wavephoneButtonY);
			draw_sprite(spr_cubeMenu_talismanButton,	0,	talismanButtonX,	talismanButtonY);
			draw_sprite(spr_cubeMenu_inventoryButton,	0,	inventoryButtonX,	inventoryButtonY);
			draw_sprite(spr_cubeMenu_mirrorButton,		0,	wardrobeButtonX,	wardrobeButtonY);
			draw_sprite(spr_cubeMenu_spellbookButton,	0,	spellbookButtonX,	spellbookButtonY);
			
			// add the backlight sprite
			draw_sprite(spr_cubeMenu_frontlight, image_index, centerX, centerY);
			
			// lower alpha
			draw_set_alpha(0.25);
			
				// draw the frontlight sprite again
				draw_sprite(spr_cubeMenu_frontlight, image_index, centerX, centerY);
			
			// reset alpha
			draw_set_alpha(1.0);
			
			// check that glowBarFrame is not past glowBarFrameCount
			if (glowBarFrame < glowBarFrameCount) {
				// draw glowbar
				draw_sprite(spr_cubeMenu_glowBar, glowBarFrame, centerX, centerY);
			}
		break;
		
		case CUBE_MENU_PHASES.CLOSING:
			// check if rectangleSurface doesn't exist
				// create rectangleSurface
				
			// copy a section to rectangleSurface
		
			// draw all elements
			
			// draw rectangle surface
			
			// draw main animation
		break;
	}

// reset surface target
surface_reset_target();