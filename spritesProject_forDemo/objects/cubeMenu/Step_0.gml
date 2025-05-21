// create a state machine using the phase variable
switch (phase) {
	case CUBE_MENU_PHASES.OPENING:
		if (topOpen) {
			// check if rectangleSurfaceY is greater than rectTargetY
			if (rectangleY > rectTargetY) {
				// move rectangleY toward rectTargetY
				rectangleY--;
			}
			// if rectangleSurfaceY is less than or equal to rectTargetY
			else {	
				// move to display phase
				phase = CUBE_MENU_PHASES.DISPLAY;
			}		
		}
		else {
			// check if image_index has hit openingFinalFrame
			if (image_index >= openingFinalFrame) {
				// switch sprite index to frontLight
				sprite_index = spr_cubeMenu_frontlight;
				
				// reset image_index
				image_index = 0;
				
				// set topOpen to true
				topOpen = true;
			}		
		}
	break;
	
	case CUBE_MENU_PHASES.DISPLAY:
		// use a switch statement to manage button input
		switch(index) {
			case CUBE_MENU_BUTTONS.TALISMANS:
			
			break;
			
			case CUBE_MENU_BUTTONS.WAVEPHONE:
			
			break;
			
			case CUBE_MENU_BUTTONS.INVENTORY:
			
			break;
			
			case CUBE_MENU_BUTTONS.WARDROBE:
			
			break;
			
			case CUBE_MENU_BUTTONS.SPELLBOOK:
			
			break;
		}
		
		// check for a click
			// check all bboxes for collisions with the mouse
	break;
	
	case CUBE_MENU_PHASES.CLOSING:
		// check if image_index has hit finalFrame
	break;
}

// check if sprite_index is set to frontLight
if (sprite_index == spr_cubeMenu_frontlight) {
	var modVar = glowBarFrame mod frontLightFrameCount;
	
	// check if glowBarFrame needs to be incremented
	if (floor(image_index) != (modVar)) {
		// reset glowBarFrame
		glowBarFrame = floor(image_index) + (frontLightCount * frontLightFrameCount);
		
		// check if image_idnex has reached frontLightCount
		if (floor(image_index) >= frontLightFrameCount - 1) {
			frontLightCount++;
		}
		
		// check if frontLightCount has reached frontLightCycle
		if (frontLightCount >= frontLightCycle) {
			frontLightCount = 0;	
		}
	}
}