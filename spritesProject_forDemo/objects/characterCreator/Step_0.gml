// check if there is a currentOutfitArrow
if (currentOutfitArrow >= 0) {
	// check if the outfitClickFrame has been reached
	if (global.gameTime mod 24 == outfitClickFrame) {
		currentOutfitArrow = -1;
		outfitClickFrame = 0;
	}
}

// check if there is a currentHairstyleArrow
if (currentHairstyleArrow >= 0) {
	// check if the hairstyleClickFrame has been reached
	if (global.gameTime mod 24 == hairstyleClickFrame) {
		currentHairstyleArrow = -1;
		hairstyleClickFrame = 0;
	}
}

// check if the mouse is being clicked
if (global.click) {
	// use a repeat loop to check all skintones for mouse collisions
	var i = 0;	repeat (ds_list_size(skintones)) {
		// get all bbox dimensions
		var left	= skintoneLefts[| i];
		var right	= skintoneRights[| i];
		var top		= skintoneTops[| i];
		var bottom	= skintoneBottoms[| i];
		
		// check for a collision
		if (collision_rectangle(left, top, right, bottom, mouse, true, false)) {
			// set this skintone as the selected skintone
			skintone = colorList[| skintones[| i]];
			
			// set the phase to skintone selection
			phase = CHARACTER_CREATOR_PHASES.SKINTONE_SELECTION;
		}
		
		// increment i
		i++;
	}
	
	// use a repeat loop to check each outfit arrow for mouse collisions
	var i = 0;	repeat (2) {
		// get all bbox dimensions
		var left	= outfitArrowLefts[| i];
		var right	= outfitArrowRights[| i];
		var top		= outfitArrowTops[| i];
		var bottom	= outfitArrowBottoms[| i];
		
		// find the current outfitNum
		var outfitNum = ds_list_find_index(usableOutfits, outfit);
		
		// check for a collision
		if (collision_rectangle(left, top, right, bottom, mouse, true, false)) {
			// set the phase to outfit selection
			phase = CHARACTER_CREATOR_PHASES.OUTFIT_SELECTION;
			
			// check if currentOutfitArrow is unset
			if (currentOutfitArrow == -1) {
				// if this is the left arrow
				if (i == 0) {
					// check that the current outfit is not the first outfit
					if (outfitNum != 0) {
						// move to the last outfit
						outfit = usableOutfits[| outfitNum - 1];
						
						// set currentOutfitArrow to i
						currentOutfitArrow = i;
						
						// set outfitClickFrame
						outfitClickFrame = global.gameTime mod 24;
					}
				}
				
				// if this is the right arrow
				if (i == 1) {
					// check that the current outfit is not the last outfit
					if (outfitNum != ds_list_size(usableOutfits) - 1) {						
						// move to the next outfit
						outfit = usableOutfits[| outfitNum + 1];
						
						// set currentOutfitArrow to i
						currentOutfitArrow = i;
						
						// set outfitClickFrame
						outfitClickFrame = global.gameTime mod 24;
					}
				}
			}
		}
		
		// increment i
		i++;
	}
	
	// use a repeat loop to check all outfit colors for mouse collisions
	var i = 0;	repeat (ds_list_size(usableDyes)) {
		// get all bbox dimensions
		var left	= outfitColorLefts[| i];
		var right	= outfitColorRights[| i];
		var top		= outfitColorTops[| i];
		var bottom	= outfitColorBottoms[| i];
		
		// check for a collision
		if (collision_rectangle(left, top, right, bottom, mouse, true, false)) {
			// set this outfitColor as the selected outfitColor
			outfitColor = colorList[| usableDyes[| i]];
			
			// set the phase to outfitColor selection
			phase = CHARACTER_CREATOR_PHASES.OUTFIT_COLOR_SELECTION;
		}
		
		// increment i
		i++;
	}
	
	// use a repeat loop to check each hairstyle arrow for mouse collisions
	var i = 0;	repeat (2) {
		// get all bbox dimensions
		var left	= hairArrowLefts[| i];
		var right	= hairArrowRights[| i];
		var top		= hairArrowTops[| i];
		var bottom	= hairArrowBottoms[| i];

		// find the current hairstylNum
		var hairstyleNum = ds_list_find_index(usableHairstyles, hairstyle);
		
		// check for a collision
		if (collision_rectangle(left, top, right, bottom, mouse, true, false)) {
			// set the phase to hairstyle selection
			phase = CHARACTER_CREATOR_PHASES.HAIRSTYLE_SELECTION;
			
			// check if currentHairstyleArrow is unset
			if (currentHairstyleArrow == -1) {
				// if this is the left arrow
				if (i == 0) {
					// check that the current hairstyle is not the first hairstyle
					if (hairstyleNum != 0) {
						// move to the last hairstyle
						hairstyle = usableHairstyles[| hairstyleNum - 1];
						
						// set currentHairstyleArrow to i
						currentHairstyleArrow = i;
						
						// set hairstyleClickFrame
						hairstyleClickFrame = global.gameTime mod 24;
					}
				}
				
				// if this is the right arrow
				if (i == 1) {
					// check that the current hairstyle is not the last hairstyle
					if (hairstyleNum != ds_list_size(usableHairstyles) - 1) {
						// move to the next hairstyle
						hairstyle = usableHairstyles[| hairstyleNum + 1];
						
						// set currentHairstyleArrow to i
						currentHairstyleArrow = i;
						
						// set hairstyleClickFrame
						hairstyleClickFrame = global.gameTime mod 24;
					}
				}
			}
		}
		
		// increment i
		i++;
	}
	
	// use a repeat loop to check all hair colors for mouse collisions
	var i = 0;	repeat (ds_list_size(usableHairColors)) {
		// get all bbox dimensions
		var left	= hairColorLefts[| i];
		var right	= hairColorRights[| i];
		var top		= hairColorTops[| i];
		var bottom	= hairColorBottoms[| i];
		
		// check for a collision
		if (collision_rectangle(left, top, right, bottom, mouse, true, false)) {
			// set this hairColor as the selected hairColor
			hairColor = colorList[| usableHairColors[| i]];
			
			// set the phase to hairColor selection
			phase = CHARACTER_CREATOR_PHASES.HAIR_COLOR_SELECTION;
		}
		
		// increment i
		i++;
	}
}

// use a switch statement to properly manage directional input
switch (phase) {
	case CHARACTER_CREATOR_PHASES.SKINTONE_SELECTION:
		// get colorNum
		var colorNum = ds_list_find_index(colorList, skintone);
		
		// get index
		var index = ds_list_find_index(skintones, colorNum);
	
		// check for left input
		if (global.menuLeft) {
			if (index > 0)	skintone = colorList[| skintones[| index - 1]];
		}
		
		// check for right input
		if (global.menuRight) {
			if (index < ds_list_size(skintones) - 1)	skintone = colorList[| skintones[| index + 1]];
		}
	break;
	
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
	
	case CHARACTER_CREATOR_PHASES.HAIRSTYLE_SELECTION:
		// check that an arrow is not already clicked
		if (currentHairstyleArrow == -1) {
			// find the current hairstylNum
			var hairstyleNum = ds_list_find_index(usableHairstyles, hairstyle);
			
			// check for left input
			if (global.menuLeft) {
				// check that the current hairstyle is not the first hairstyle
				if (hairstyleNum > 0) {
					// move to the last hairstyle
					hairstyle = usableHairstyles[| hairstyleNum - 1];
					
					// set currentHairstyleArrow to 0
					currentHairstyleArrow = 0;
				
					// set hairstyleClickFrame
					hairstyleClickFrame = global.gameTime mod 24;
				}
			}
			
			// check for right input
			if (global.menuRight) {
				// check that the current hairstyle is not the last hairstyle
				if (hairstyleNum != ds_list_size(usableHairstyles) - 1) {
					// move to the next hairstyle
					hairstyle = usableHairstyles[| hairstyleNum + 1];
					
					// set currentHairstyleArrow to 1
					currentHairstyleArrow = 1;
					
					// set hairstyleClickFrame
					hairstyleClickFrame = global.gameTime mod 24;
				}
			}
		}
	break;
	
	case CHARACTER_CREATOR_PHASES.HAIR_COLOR_SELECTION:
		// get colorNum
		var colorNum = ds_list_find_index(colorList, hairColor);
		
		// get index
		var index = ds_list_find_index(usableHairColors, colorNum);
		
		// check for left input
		if (global.menuLeft) {
			if (index > 0)									hairColor = colorList[| usableHairColors[| index - 1]];
		}
		
		// check for right input
		if (global.menuRight) {
			if (index < ds_list_size(usableHairColors) - 1)	hairColor = colorList[| usableHairColors[| index + 1]];
		}
	break;
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
			// push failure haptic
			audio_push_failure_haptic();
			
			// set phase to confirm window exit
			phase = CHARACTER_CREATOR_PHASES.CONFIRM_WINDOW_EXIT;	
		}
		// check if index is 1
		if (ynSelection == 1) {
			// push success haptic
			audio_push_success_haptic();
			
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
		// push failure haptic
		audio_push_failure_haptic();
		
		// check that this is not the first phase
		if (phase > 0) {		
			// decrement phase
			phase--;
		}
	}
	
	// check for down input
	if (global.menuDown) {
		// push success haptic
		audio_push_success_haptic();
		
		// increment phase
		phase++;
	}
	
	// check if select is being pressed
	if (global.select) {
		// push success haptic
		audio_push_success_haptic();
		
		// increment phase
		phase++;
	}

	// check if back is being pressed
	if (global.back) {
		// push failure haptic
		audio_push_failure_haptic();
		
		// check that the current phase is not skintone_selection
		if (phase != CHARACTER_CREATOR_PHASES.SKINTONE_SELECTION) {
			// decrement phase
			phase--;
		}
	}
	
	// check if start is being pressed
	if (global.start) {
		// push success haptic
		audio_push_success_haptic();
		
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