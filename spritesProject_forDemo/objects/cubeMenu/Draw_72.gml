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
			draw_sprite(spr_cubeMenu_wavephoneButton,	wavephoneButtonFrame,	wavephoneButtonDrawX,	wavephoneButtonDrawY);
			draw_sprite(spr_cubeMenu_talismanButton,	talismanButtonFrame,	talismanButtonDrawX,	talismanButtonDrawY);
			draw_sprite(spr_cubeMenu_inventoryButton,	inventoryButtonFrame,	inventoryButtonDrawX,	inventoryButtonDrawY);
			draw_sprite(spr_cubeMenu_mirrorButton,		wardrobeButtonFrame,	wardrobeButtonDrawX,	wardrobeButtonDrawY);
			draw_sprite(spr_cubeMenu_spellbookButton,	spellbookButtonFrame,	spellbookButtonDrawX,	spellbookButtonDrawY);
			
			// add the backlight sprite
			draw_sprite(spr_cubeMenu_frontlight, image_index, centerX, centerY);
			
			// check that glowBarFrame is not past glowBarFrameCount
			if (glowBarFrame < glowBarFrameCount) {
				// draw glowbar
				draw_sprite(spr_cubeMenu_glowBar, glowBarFrame, centerX, centerY);
			}
			
			// set blendmode to subtractive
			gpu_set_blendmode(bm_subtract);
			
				// draw rectangle
				draw_rectangle_color(centerX - (rectangleWidth / 2), rectangleY - (rectangleHeight / 2), centerX + (rectangleWidth / 2), rectangleY + (rectangleHeight / 2) + 4, c_black, c_black, c_black, c_black, false);
			
			// reset blendmode
			gpu_set_blendmode(bm_normal);
			
		break;
		
		case CUBE_MENU_PHASES.DISPLAY:
			// add the backlight sprite
			draw_sprite(spr_cubeMenu_backlight, image_index, centerX, centerY);
		
			// draw still frame
			draw_sprite(spr_cubeMenu_opening, openingFinalFrame, cubeX, cubeY);

			// draw all buttons
			draw_sprite(spr_cubeMenu_wavephoneButton,	wavephoneButtonFrame,	wavephoneButtonDrawX,	wavephoneButtonDrawY);
			draw_sprite(spr_cubeMenu_talismanButton,	talismanButtonFrame,	talismanButtonDrawX,	talismanButtonDrawY);
			draw_sprite(spr_cubeMenu_inventoryButton,	inventoryButtonFrame,	inventoryButtonDrawX,	inventoryButtonDrawY);
			draw_sprite(spr_cubeMenu_mirrorButton,		wardrobeButtonFrame,	wardrobeButtonDrawX,	wardrobeButtonDrawY);
			draw_sprite(spr_cubeMenu_spellbookButton,	spellbookButtonFrame,	spellbookButtonDrawX,	spellbookButtonDrawY);
			
			// add the frontlight sprite
			draw_sprite(spr_cubeMenu_frontlight, image_index, centerX, centerY);
			
			// check that glowBarFrame is not past glowBarFrameCount
			if (glowBarFrame < glowBarFrameCount) {
				// draw glowbar
				draw_sprite(spr_cubeMenu_glowBar, glowBarFrame, centerX, centerY);
			}
		break;
		
		case CUBE_MENU_PHASES.CLOSING:
			// check if top is still open
			if (topOpen) {
				// draw the backlight sprite
				draw_sprite(spr_cubeMenu_backlight, image_index, centerX, centerY);
				
				// draw still frame of cube
				draw_sprite(spr_cubeMenu_closing, 0, cubeX, cubeY);
				
				// draw all buttons
				draw_sprite(spr_cubeMenu_wavephoneButton,	wavephoneButtonFrame,	wavephoneButtonDrawX,	wavephoneButtonDrawY);
				draw_sprite(spr_cubeMenu_talismanButton,	talismanButtonFrame,	talismanButtonDrawX,	talismanButtonDrawY);
				draw_sprite(spr_cubeMenu_inventoryButton,	inventoryButtonFrame,	inventoryButtonDrawX,	inventoryButtonDrawY);
				draw_sprite(spr_cubeMenu_mirrorButton,		wardrobeButtonFrame,	wardrobeButtonDrawX,	wardrobeButtonDrawY);
				draw_sprite(spr_cubeMenu_spellbookButton,	spellbookButtonFrame,	spellbookButtonDrawX,	spellbookButtonDrawY);
				
				// add the frontlight sprite
				draw_sprite(spr_cubeMenu_frontlight, image_index, centerX, centerY);
				
				// check that glowBarFrame is not past glowBarFrameCount
				if (glowBarFrame < glowBarFrameCount) {
					// draw glowbar
					draw_sprite(spr_cubeMenu_glowBar, glowBarFrame, centerX, centerY);
				}
				
				// set blendmode to subtractive
				gpu_set_blendmode(bm_subtract);
				
					// draw rectangle
					draw_rectangle_color(centerX - (rectangleWidth / 2), rectangleY - (rectangleHeight / 2), centerX + (rectangleWidth / 2), rectangleY + (rectangleHeight / 2) + 4, c_black, c_black, c_black, c_black, false);
				
				// reset blendmode
				gpu_set_blendmode(bm_normal);
			}
			// if top is no longer open
			else {
				// draw still frame of cube
				draw_sprite(spr_cubeMenu_closing, image_index, cubeX, cubeY);
			}
		break;
	}

// reset surface target
surface_reset_target();