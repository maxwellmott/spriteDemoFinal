// check if the mouse is being clicked
	// use a repeat loop to check all skintones for mouse collisions
	
	// check each outfit arrow for mouse collisions
	
	// use a repeat loop to check all outfit colors for mouse collisions
	
	// check each hairstyle arrow for mouse collisions
	
	// use a repeat loop to check all hair colors for mouse collisions
	
// use a switch statement to check each possible phase
switch (phase) {
	case CHARACTER_CREATOR_PHASES.SKINTONE_SELECTION:
		// navigate index based on player input
		
		// check if select is being pressed
			// advance to the next selection phase
	break;
	
	case CHARACTER_CREATOR_PHASES.OUTFIT_SELECTION:
		// navigate index based on player input
	
		// check if select is being pressed
			// advance to the next selection phase
			
			// set index based on the current selection for the next phase
	break;
	
	case CHARACTER_CREATOR_PHASES.OUTFIT_COLOR_SELECTION:
		// navigate index based on player input
		
		// check if select is being pressed
			// advance to the next selection phase
			
			// set index based on the current selection for the next phase
	break;
	
	case CHARACTER_CREATOR_PHASES.HAIRSTYLE_SELECTION:
		// navigate index based on player input
	
		// check if select is being pressed
			// advance to the next selection phase
			
			// set index based on the current selection for the next phase
	break;
	
	case CHARACTER_CREATOR_PHASES.HAIR_COLOR_SELECTION: 	
		// navigate index based on player input

		// check if select is being pressed
			// advance to the next selection phase
			
			// set index based on the current selection for the next phase
	break;
	
	case CHARACTER_CREATOR_PHASES.CONFIRM_SELECTION:
		// navigate index based on player input
		
		// check if select is being pressed
			// check if index is 0
				// return to the last selection phase
				
			// check if index is 1
				// transition to the keyboard menu to enter a name
	break;
}