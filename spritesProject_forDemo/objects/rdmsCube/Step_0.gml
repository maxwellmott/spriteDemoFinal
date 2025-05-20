// create a state machine using the phase variable
switch (phase) {
	case CUBE_MENU_PHASES.OPENING:
		// check if image_index has hit topOpenFrame
		if (image_index >= topOpenFrame)
		|| (topOpen) {
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
		
		// check if image_index has hit openingFinalFrame
		if (image_index >= openingFinalFrame) {
			// set topOpen to true
			topOpen = true;
		}		
	break;
	
	case CUBE_MENU_PHASES.DISPLAY:
		// use a switch statement to manage button input
		
		// check for a click
			// check all bboxes for collisions with the mouse
	break;
	
	case CUBE_MENU_PHASES.CLOSING:
		// check if image_index has hit finalFrame
	break;
}