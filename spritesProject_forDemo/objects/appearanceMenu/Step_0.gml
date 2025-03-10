// check if there is a currentOutfitArrow
if (currentOutfitArrow >= 0) {
	// check if the outfitClickFrame has been reached
	if (global.gameTime mod 24 == outfitClickFrame) {
		currentOutfitArrow = -1;
		outfitClickFrame = 0;
	}
}

// check if there is a currentHatArrow
if (currentHatArrow >= 0) {
	// check if the hatClickFrame has been reached
	if (global.gameTime mod 24 == hatClickFrame) {
		currentHatArrow = -1;
		hatClickFrame = 0;
	}
}

// check if there is a currentShoeArrow
if (currentShoeArrow >= 0) {
	// check if the shoeClickFrame has been reached
	if (global.gameTime mod 24 == shoeClickFrame) {
		currentShoeArrow = -1;
		shoeClickFrame = 0;
	}
}

// check if there is a currentEyewearArrow
if (currentEyewearArrow >= 0) {
	// check if the eyewearClickFrame has been reached
	if (global.gameTime mod 24 == eyewearClickFrame) {
		currentEyewearArrow = -1;
		eyewearClickFrame = 0;
	}
}

// check if there is a currentAccessoryArrow
if (currentAccessoryArrow >= 0) {
	// check if the hatClickFrame has been reached
	if (global.gameTime mod 24 == accessoryClickFrame) {
		currentAccessoryArrow = -1;
		accessoryClickFrame = 0;
	}
}

// check that the phase is not past accessorySelection (this would mean that the confirmWindow is open
if (phase <= APPEARANCE_EDITOR_PHASES.ACCESSORY_SELECTION) {
	// check if the mouse is being clicked
	if (global.click) {
		// use a repeat loop to check for a collision with each dye
			// if there is a collision, set that dye as the color of the
			// given element, then set the phase to the selection of that color
			
		// check for a collision with each arrow
		
		// check for a collision with the nameChangeButton
	}
}

// use a switch statement to properly manage directional input
switch (phase) {
	case CHARACTER_CREATOR_PHASES.OUTFIT_SELECTION:
		// check that an arrow is not already clicked
		if (currentOutfitArrow == -1) {
			// find the current outfitNum
			var outfitNum = ds_list_find_index(usableOutfits, outfit);
		
			// check for left input
			if (global.menuLeft) {
				// check that the current outfit is not the first outfit
				if (outfitNum > 0) {
					// move to the last outfit
					outfit = usableOutfits[| outfitNum - 1];
					
					// set currentOutfitArrow to 0
					currentOutfitArrow = 0;
					
					// set outfitClickFrame
					outfitClickFrame = global.gameTime mod 24;
				}
				}
		
			// check for right input
			if (global.menuRight) {
				// check that the current outfit is not the last outfit
				if (outfitNum != ds_list_size(usableOutfits) - 1) {				
					// move to the next outfit
					outfit = usableOutfits[| outfitNum + 1];
					
					// set currentOutfitArrow to 1
					currentOutfitArrow = 1;
					
					// set outfitClickFrame
					outfitClickFrame = global.gameTime mod 24;
				}
			}
		}
	break;
	
	case CHARACTER_CREATOR_PHASES.OUTFIT_COLOR_SELECTION:
		// get colorNum
		var colorNum = ds_list_find_index(colorList, outfitColor);
		
		// get index
		var index = ds_list_find_index(usableDyes, colorNum);
		
		// check for left input
		if (global.menuLeft) {
			if (index > 0)								outfitColor = colorList[| usableDyes[| index - 1]];
		}
		
		// check for right input
		if (global.menuRight) {
			if (index < ds_list_size(usableDyes) - 1)	outfitColor = colorList[| usableDyes[| index + 1]];
		}
	break;

	//@TODO COMPLETE THIS SWITH STATEMENT (SIMPLY LADD ALL THE OTHER ELEMENT AND COLOR SELECTION PHASES)
}

// check if the current phase is confirm_window_enter
if (phase == CHARACTER_CREATOR_PHASES.CONFIRM_WINDOW_ENTER) {
	if (image_index >= confirmWindowMaxFrame) {
		phase = CHARACTER_CREATOR_PHASES.CONFIRM_SELECTION;
	}
}

// check if the current phase is confirm_selection
if (phase == CHARACTER_CREATOR_PHASES.CONFIRM_SELECTION) {
	// clamp image index
	image_index = confirmWindowMaxFrame;
	
	// check for a click
	if (global.click) {
		// check for a collision with the yes button
		if (collision_rectangle(yesButtonLeft, yesButtonTop, yesButtonRight, yesButtonBottom, mouse, true, false)) {
			// set yn selection
			ynSelection = 1;
			
			// set keyboard prompt
			global.keyboardPrompt = KEYBOARD_PROMPTS.CHARACTER_NAME;
			
			// transition to keyboard menu for name entry
			room_transition(128, 160, player.facing, rm_keyboardMenu, bgm_menuTheme);
		}
		
		// check for a collision with the no button
		if (collision_rectangle(noButtonLeft, noButtonTop, noButtonRight, noButtonBottom, mouse, true, false)) {
			// set yn selection
			ynSelection = 0;
			
			// set image index back to 0
			image_index = 0;
			
			// set phase to confirm window exit
			phase = CHARACTER_CREATOR_PHASES.CONFIRM_WINDOW_EXIT;
		}
	}
	
	// check for back input
	if (global.back) {
		// set image index back to 0
		image_index = 0;
		
		// set phase to confirm window exit
		phase = CHARACTER_CREATOR_PHASES.CONFIRM_WINDOW_EXIT;
	}
	
	// navigate index based on player input
	if (global.menuLeft)
	|| (global.menuRight) {
		ynSelection = !ynSelection;	
	}
	
	// check if select is being pressed
	if (global.select) {
		// check if index is 0
		if (ynSelection == 0) {
			// set phase to confirm window exit
			phase = CHARACTER_CREATOR_PHASES.CONFIRM_WINDOW_EXIT;	
		}
		// check if index is 1
		if (ynSelection == 1) {
			// set keyboard prompt
			global.keyboardPrompt = KEYBOARD_PROMPTS.CHARACTER_NAME;
			
			// transition to the keyboard menu to enter a name
			room_transition(128, 160, player.facing, rm_keyboardMenu, bgm_menuTheme);
		}
	}
}

// check if the current phase is confirm window exit
if (phase == CHARACTER_CREATOR_PHASES.CONFIRM_WINDOW_EXIT) {
	// check if	image_index has reached the end
	if (image_index >= confirmWindowMaxFrame) {
		// reset phase to skintone selection
		phase = CHARACTER_CREATOR_PHASES.SKINTONE_SELECTION;
	}
}

// check that the current phase is NOT confirm_selection
if (phase < CHARACTER_CREATOR_PHASES.CONFIRM_WINDOW_ENTER) {
	// check for up input
	if (global.menuUp) {
		// check that this is not the first phase
		if (phase > 0) {		
			// decrement phase
			phase--;
		}
	}
	
	// check for down input
	if (global.menuDown) {
		// check that this is not the final phase before confirm selection
		if (phase < CHARACTER_CREATOR_PHASES.CONFIRM_WINDOW_ENTER) {
			// increment phase
			phase++;
		}
	}
	
	// check if select is being pressed
	if (global.select) {
		// increment phase
		phase++;
	}

	// check if back is being pressed
	if (global.back) {
		// check that the current phase is not skintone_selection
		if (phase != CHARACTER_CREATOR_PHASES.SKINTONE_SELECTION) {
			// decrement phase
			phase--;
		}
	}
	
	// check if start is being pressed
	if (global.start) {
		// set phase to confirm_window_enter
		phase = CHARACTER_CREATOR_PHASES.CONFIRM_WINDOW_ENTER;
	}
}

// check if it has been 16 frames
if !(global.gameTime mod 24) {
	// increment playerFacing
	playerFacing++;
}

// check if playerFacing is greater than west (last direction on the enum)
if (playerFacing > directions.west) {
	// subtract directions.west from playerFacing
	playerFacing -= (directions.west + 1);
}