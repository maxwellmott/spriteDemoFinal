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

// check if nameChangeButtonTime has been set
if (nameChangeButtonTime != -1) {
	// check if the nameChangeButtonTime has been reached
	if (global.gameTime mod 24 == nameChangeButtonTime) {
		nameChangeButtonFrame = 0;
		nameChangeButtonTime = -1;
	}
}

// check that the phase is not past accessorySelection (this would mean that the confirmWindow is open
if (phase <= APPEARANCE_EDITOR_PHASES.ACCESSORY_SELECTION) {
	// check if the mouse is being clicked
	if (global.click) {
		// use a repeat loop to check for a collision with each dye
		var i = 0;	repeat (ds_list_size(usableDyes)) {
			// get all bbox dimensions
			var left	= dyeLefts[| i];
			var right	= dyeRights[| i];
			
			var outfitTop		= outfitColorTops[| i];
			var outfitBottom	= outfitColorBottoms[| i];
			
			var hatTop			= hatColorTops[| i];
			var hatBottom		= hatColorBottoms[| i];
			
			var shoeTop			= shoeColorTops[| i];
			var shoeBottom		= shoeColorBottoms[| i];
					
			// check for a collision with the given outfit dye splotch
			if (collision_rectangle(left, outfitTop, right, outfitBottom, mouse, true, false)) {
				// set that dye as the current outfitColor
				outfitColor = colorList[| usableDyes[| i]];
				
				// set the phase to outfit color selection
				phase = APPEARANCE_EDITOR_PHASES.OUTFIT_COLOR_SELECTION;
			}
			
			// check for a collision with the given hat dye splotch
			if (collision_rectangle(left, hatTop, right, hatBottom, mouse, true, false)) {
				// set that dye as the current hatColor
				hatColor = colorList[| usableDyes[| i]];
				
				// set the phase to hat color selection
				phase = APPEARANCE_EDITOR_PHASES.HAT_COLOR_SELECTION;
			}
			
			// check for a collision with the given shoe dye splotch
			if (collision_rectangle(left, shoeTop, right, shoeBottom, mouse, true, false)) {
				// set that dye as the current shoeColor
				shoeColor = colorList[| usableDyes[| i]];
				
				// set the phase to shoe color selection
				phase = APPEARANCE_EDITOR_PHASES.SHOE_COLOR_SELECTION;
			}
			
			// increment i
			i++;
		}
		
		// check that there is not already an outfitArrow being clicked
		if (currentOutfitArrow == -1) {
			// find the current outfitNum
			var outfitNum = ds_list_find_index(usableOutfits, outfit);
			
			// check for a collision with the left outfitArrow
			if (collision_rectangle(leftArrowLeft, outfitArrowTop, leftArrowRight, outfitArrowBottom, mouse, true, false)) {
				// check that this is not the first outfit
				if (outfitNum > 0) {
					// move to the last outfit
					outfit = real(usableOutfits[| outfitNum - 1]);
					
					// set currentOutfitArrow to 0
					currentOutfitArrow = 0;
					
					// set outfitClickFrame
					outfitClickFrame = global.gameTime mod 24;
				}
			}
			
			// check for a collision with the right outfitArrow
			if (collision_rectangle(rightArrowLeft, outfitArrowTop, rightArrowRight, outfitArrowBottom, mouse, true, false)) {
				// check that this is not the last outfit
				if (outfitNum < ds_list_size(usableOutfits) - 1) {
					// move to the next outfit
					outfit = real(usableOutfits[| outfitNum + 1]);
					
					// set currentOutfitArrow to 1
					currentOutfitArrow = 1;
					
					// set outfitClickFrame
					outfitClickFrame = global.gameTime mod 24;
				}
			}
		}
		
		// check that there is not already a hatArrow being clicked
		if (currentHatArrow == -1) {
			// find the current hatNum
			var hatNum = ds_list_find_index(usableHats, hat);
			
			// check for a collision with the left hatArrow
			if (collision_rectangle(leftArrowLeft, hatArrowTop, leftArrowRight, hatArrowBottom, mouse, true, false)) {
				// check that this is not the first hat
				if (hatNum > 0) {
					// move to the last hat
					hat = real(usableHats[| hatNum - 1]);
					
					// set currentHatArrow to 0
					currentHatArrow = 0;
					
					// set hatClickFrame
					hatClickFrame = global.gameTime mod 24;
				}
			}
			
			// check for a collision with the right hatArrow
			if (collision_rectangle(rightArrowLeft, hatArrowTop, rightArrowRight, hatArrowBottom, mouse, true, false)) {
				// check that this is not the last hat
				if (hatNum < ds_list_size(usableHats) - 1) {
					// move to the next hat
					hat = real(usableHats[| hatNum + 1]);
					
					// set currentHatArrow to 1
					currentHatArrow = 1;
					
					// set hatClickFrame
					hatClickFrame = global.gameTime mod 24;
				}
			}
		}
		
		// check that there is not already a shoeArrow being clicked
		if (currentShoeArrow == -1) {
			// find the current shoeNum
			var shoeNum = ds_list_find_index(usableFootwear, shoes);
			
			// check for a collision with the left shoeArrow
			if (collision_rectangle(leftArrowLeft, shoeArrowTop, leftArrowRight, shoeArrowBottom, mouse, true, false)) {
				// check that this is not the first shoes
				if (shoeNum > 0) {
					// move to the last shoes
					shoes = real(usableFootwear[| shoeNum - 1]);
					
					// set currentShoeArrow to 0
					currentShoeArrow = 0;
					
					// set shoeClickFrame
					shoeClickFrame = global.gameTime mod 24;
				}
			}
			
			// check for a collision with the right shoeArrow
			if (collision_rectangle(rightArrowLeft, shoeArrowTop, rightArrowRight, shoeArrowBottom, mouse, true, false)) {
				// check that this is not the last shoes
				if (shoeNum < ds_list_size(usableFootwear) - 1) {
					// move to the next shoes
					shoes = real(usableFootwear[| shoeNum + 1]);
					
					// set currentShoeArrow to 1
					currentShoeArrow = 1;
					
					// set shoeClickFrame
					shoeClickFrame = global.gameTime mod 24;
				}
			}
		}
		
		// check that there is not already an eyewearArrow being clicked
		if (currentEyewearArrow == -1) {
			// find the current eyewearNum
			var eyewearNum = ds_list_find_index(usableEyewear, eyewear);
			
			// check for a collision with the left eyewearArrow
			if (collision_rectangle(leftArrowLeft, eyewearArrowTop, leftArrowRight, eyewearArrowBottom, mouse, true, false)) {
				// check that this is not the first eyewear
				if (eyewearNum > 0) {
					// move to the last eyewear
					eyewear = real(usableEyewear[| eyewearNum - 1]);
					
					// set currentEyewearArrow to 0
					currentEyewearArrow = 0;
					
					// set eyewearClickFrame
					eyewearClickFrame = global.gameTime mod 24;
				}
			}
			
			// check for a collision with the right eyewearArrow
			if (collision_rectangle(rightArrowLeft, eyewearArrowTop, rightArrowRight, eyewearArrowBottom, mouse, true, false)) {
				// check that this is not the last eyewear
				if (eyewearNum < ds_list_size(usableEyewear) - 1) {
					// move to the next eyewear
					eyewear = real(usableEyewear[| eyewearNum + 1]);
					
					// set currentEyewearArrow to 1
					currentEyewearArrow = 1;
					
					// set eyewearClickFrame
					eyewearClickFrame = global.gameTime mod 24;
				}
			}
		}
		
		// check that there is not already an accessoryArrow being clicked
		if (currentAccessoryArrow == -1) {
			// find the current accessoryNum
			var accessoryNum = ds_list_find_index(usableAccessories, accessory);
			
			// check for a collision with the left accessoryArrow
			if (collision_rectangle(leftArrowLeft, accessoryArrowTop, leftArrowRight, accessoryArrowBottom, mouse, true, false)) {
				// check that this is not the first accessory
				if (accessoryNum > 0) {
					// move to the last accessory
					accessory = real(usableAccessories[| accessoryNum - 1]);
					
					// set the currentAccessoryArrow to 0
					currentAccessoryArrow = 0;
					
					// set accessoryClickFrame
					accessoryClickFrame = global.gameTime mod 24;
				}
			}
			
			// check for a collision with the right accessoryArrow
			if (collision_rectangle(rightArrowLeft, accessoryArrowTop, rightArrowRight, accessoryArrowBottom, mouse, true, false)) {
				// check that this is not the first accessory
				if (accessoryNum < ds_list_size(usableAccessories) - 1) {
					// move to the next accessory
					accessory = real(usableAccessories[| accessoryNum + 1]);
					
					// set the currentAccessoryArrow to 1
					currentAccessoryArrow = 1;
					
					// set accessoryClickFrame
					accessoryClickFrame = global.gameTime mod 24;
				}
			}
		}
		
		// check for a collision with the nameChangeButton
		if (collision_rectangle(nameChangeButtonLeft, nameChangeButtonTop, nameChangeButtonRight, nameChangeButtonBottom, mouse, true, false)) {
			// set nameChangeButtonFrame to 1
			nameChangeButtonFrame = 1;
			
			// set nameChangeButtonTime
			nameChangeButtonTime = global.gameTime mod 24;
			
			// set the keyboard prompt
			global.keyboardPrompt = KEYBOARD_PROMPTS.CHARACTER_NAME;
			
			// begin a transition into the keyboard room
			room_transition(player.x, player.y, player.facing, rm_keyboardMenu, bgm_loveStarvedLandscape);
		}
	}
}

// use a switch statement to properly manage directional input
switch (phase) {
	case APPEARANCE_EDITOR_PHASES.OUTFIT_SELECTION:
		// check that an arrow is not already clicked
		if (currentOutfitArrow == -1) {
			// find the current outfitNum
			var outfitNum = ds_list_find_index(usableOutfits, outfit);
		
			// check for left input
			if (global.menuLeft) {
				// check that the current outfit is not the first outfit
				if (outfitNum > 0) {
					// move to the last outfit
					outfit = real(usableOutfits[| outfitNum - 1]);
					
					// set currentOutfitArrow to 0
					currentOutfitArrow = 0;
					
					// set outfitClickFrame
					outfitClickFrame = global.gameTime mod 24;
				}
				}
		
			// check for right input
			if (global.menuRight) {
				// check that the current outfit is not the last outfit
				if (outfitNum < ds_list_size(usableOutfits) - 1) {		
					// move to the next outfit
					outfit = real(usableOutfits[| outfitNum + 1]);
					
					// set currentOutfitArrow to 1
					currentOutfitArrow = 1;
					
					// set outfitClickFrame
					outfitClickFrame = global.gameTime mod 24;
				}
			}
			
			// check for up input
			if (global.menuUp) {
				// SFX POST NEGATIVE SFX
			}
			
			// check for down input
			if (global.menuDown) {
				phase = APPEARANCE_EDITOR_PHASES.HAT_SELECTION;
			}
		}
	break;
	
	case APPEARANCE_EDITOR_PHASES.OUTFIT_COLOR_SELECTION:
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
		
		// check for up input
		if (global.menuUp) {
			// check if the next row up is available
			if ((index - dyesPerRow) >= 0) {
				index -= dyesPerRow;	
			}
			// if the next row up is not available
			else {
				// SFX POST NEGATIVE SFX
			}
		}
		
		// check for down input
		if (global.menuDown) {
			// check if the next row down is available
			if ((index + dyesPerRow) < ds_list_size(usableDyes)) {
				// move to the next row down
				index += dyesPerRow;
			}
			// if the next row down is not available
			else {
				// move to the next dye selection
				phase = APPEARANCE_EDITOR_PHASES.HAT_COLOR_SELECTION;
			}
		}
	break;

	case APPEARANCE_EDITOR_PHASES.HAT_SELECTION:
		// check that an arrow is not already clicked
		if (currentHatArrow == -1) {
			// find the current hatNum
			var hatNum = ds_list_find_index(usableHats, hat);
		
			// check for left input
			if (global.menuLeft) {
				// check that the current hat is not the first outfit
				if (hatNum > 0) {
					// move to the last outfit
					hat = real(usableHats[| hatNum - 1]);
					
					// set currentHatArrow to 0
					currentHatArrow = 0;
					
					// set hatClickFrame
					hatClickFrame = global.gameTime mod 24;
				}
			}
		
			// check for right input
			if (global.menuRight) {
				// check that the current hat is not the last hat
				if (hatNum < ds_list_size(usableHats) - 1) {		
					// move to the next hat
					hat = real(usableOutfits[| hatNum + 1]);
					
					// set currentOutfitArrow to 1
					currentHatArrow = 1;
					
					// set outfitClickFrame
					hatClickFrame = global.gameTime mod 24;
				}
			}
		}
		
		// check for up input
		if (global.menuUp) {
			phase = APPEARANCE_EDITOR_PHASES.OUTFIT_SELECTION;
		}
		
		// check for down input
		if (global.menuDown) {
			phase = APPEARANCE_EDITOR_PHASES.SHOE_SELECTION;
		}
	break;
	
	case APPEARANCE_EDITOR_PHASES.HAT_COLOR_SELECTION:
		// get colorNum
		var colorNum = ds_list_find_index(colorList, hatColor);
		
		// get index
		var index = ds_list_find_index(usableDyes, colorNum);
		
		// check for left input
		if (global.menuLeft) {
			if (index > 0)								hatColor = colorList[| usableDyes[| index - 1]];
		}
		
		// check for right input
		if (global.menuRight) {
			if (index < ds_list_size(usableDyes) - 1)	hatColor = colorList[| usableDyes[| index + 1]];
		}
		
		// check for up input
		if (global.menuUp) {
			// check if the next row up is available
			if ((index - dyesPerRow) >= 0) {
				index -= dyesPerRow;
			}
			// if the next row up is not available
			else {
				// move to the last dye selection
				phase = APPEARANCE_EDITOR_PHASES.OUTFIT_COLOR_SELECTION;
			}
		}
		
		// check for down input
		if (global.menuDown) {
			// check if the next row down is available
			if ((index + dyesPerRow) < ds_list_size(usableDyes)) {
				// move to the next row down
				index += dyesPerRow;
			}
			// if the next row down is not available
			else {
				// move to the next dye selection
				phase = APPEARANCE_EDITOR_PHASES.SHOE_COLOR_SELECTION;
			}
		}
	break;
	
	case APPEARANCE_EDITOR_PHASES.SHOE_SELECTION:
		// check that an arrow is not already clicked
		if (currentShoeArrow == -1) {
			// find the current shoeNum
			var shoeNum = ds_list_find_index(usableFootwear, shoes);
			
			// check for left input
			if (global.menuLeft) {
				// check that the current shoes are not the first shoes
				if (shoeNum > 0) {
					// move to the last shoes
					shoes = real(usableFootwear[| shoeNum - 1]);
					
					// set currentShoeArrow to 0
					currentShoeArrow = 0;
					
					// set shoeClickFrame
					shoeClickFrame = global.gameTime mod 24;
				}
			}
			
			// check for right input
			if (global.menuRight) {
				// check that the current shoes are not the last shoes
				if (shoeNum < ds_list_size(usableFootwear) - 1) {
					// move to the next shoes
					shoes = real(usableFootwear[| shoeNum + 1]);
					
					// set currentShoeArrow to 1
					currentShoeArrow = 1;
					
					// set shoeClickFrame
					shoeClickFrame = global.gameTime mod 24;
				}
			}
			
			// check for up input
			if (global.menuUp) {
				phase = APPEARANCE_EDITOR_PHASES.HAT_SELECTION;
			}
			
			// check for down input
			if (global.menuDown) {
				phase = APPEARANCE_EDITOR_PHASES.EYEWEAR_SELECTION;
			}
		}
	break;
	
	case APPEARANCE_EDITOR_PHASES.SHOE_COLOR_SELECTION:
		// get colorNum
		var colorNum = ds_list_find_index(colorList, shoeColor);
		
		// get index
		var index = ds_list_find_index(usableDyes, colorNum);
		
		// check for left input
		if (global.menuLeft) {
			if (index > 0)								shoeColor = colorList[| usableDyes[| index - 1]];
		}
		
		// check for right input
		if (global.menuRight) {
			if (index < ds_list_size(usableDyes) - 1)	shoeColor = colorList[| usableDyes[| index + 1]];
		}
		
		// check for up input
		if (global.menuUp) {
			// check if the next row up is available
			if ((index - dyesPerRow) >= 0) {
				index -= dyesPerRow;	
			}
			// if the next row up is not available
			else {
				// move to the last dye selection
				phase = APPEARANCE_EDITOR_PHASES.HAT_COLOR_SELECTION;
			}
		}
		
		// check for down input
		if (global.menuDown) {
			// check if the next row down is available
			if ((index + dyesPerRow) < ds_list_size(usableDyes)) {
				// move to the next row down
				index += dyesPerRow;
			}
			// if the next row down is not available
			else {
				// SFX POST NEGATIVE SFX
			}
		}
	break;
	
	case APPEARANCE_EDITOR_PHASES.EYEWEAR_SELECTION:
		// check that an arrow is not already clicked
		if (currentEyewearArrow == -1) {
			// find the current eyewearNum
			var eyewearNum = ds_list_find_index(usableEyewear, eyewear);
			
			// check for left input
			if (global.menuLeft) {
				// check that the current eyewear is not the first eyewear
				if (eyewearNum > 0) {
					// move to the last eyewear
					eyewear = real(usableEyewear[| eyewearNum - 1]);
					
					// set the currentEyewearArrow to 0
					currentEyewearArrow = 0;
					
					// set eyewearClickFrame
					eyewearClickFrame = global.gameTime mod 24;
				}
			}
			
			// check for right input
			if (global.menuRight) {
				// check that the current eyewear is not the last eyewear
				if (eyewearNum < ds_list_size(usableEyewear) - 1) {
					// move to the next eyewear
					eyewear = real(usableEyewear[| eyewearNum + 1]);
					
					// set the currentEyewearArrow to 1
					currentEyewearArrow = 1;
					
					// set eyewearClickFrame
					eyewearClickFrame = global.gameTime mod 24;
				}
			}
			
			// check for up input
			if (global.menuUp) {
				phase = APPEARANCE_EDITOR_PHASES.SHOE_SELECTION;
			}
			
			// check for down input
			if (global.menuDown) {
				phase = APPEARANCE_EDITOR_PHASES.ACCESSORY_SELECTION;
			}
		}
	break;
	
	case APPEARANCE_EDITOR_PHASES.ACCESSORY_SELECTION:
		// check that an arrow is not already clicked
		if (currentAccessoryArrow == -1) {
			// find the current accessoryNum
			var accessoryNum = ds_list_find_index(usableAccessories, accessory);
			
			// check for left input
			if (global.menuLeft) {
				// check that the current accessory is not the first accessory
				if (accessoryNum > 0) {
					// move to the last accessory
					accessory = real(usableAccessories[| accessoryNum - 1]);
					
					// set the currentAccessoryArrow to 0
					currentAccessoryArrow = 0;
					
					// set accessoryClickFrame
					accessoryClickFrame = global.gameTime mod 24;
				}
			}
			
			// check for right input
			if (global.menuRight) {
				// check that the current accessory is not the last accessory
				if (accessoryNum < (ds_list_size(usableAccessories) - 1)) {
					// move to the next accessory
					accessory = real(usableAccessories[| accessoryNum + 1]);
					
					// set the currentAccessoryArrow to 0
					currentAccessoryArrow = 0;
					
					// set accessoryClickFrame
					accessoryClickFrame = global.gameTime mod 24;
				}
			}
		}
		
		// check for up input
		if (global.menuUp) {
			phase = APPEARANCE_EDITOR_PHASES.EYEWEAR_SELECTION;
		}
		
		// check for down input
		if (global.menuDown) {
			// SFX POST NEGATIVE SFX
		}
}

// check if the current phase is confirm_window_enter
if (phase == APPEARANCE_EDITOR_PHASES.CONFIRM_WINDOW_ENTER) {
	if (image_index >= confirmWindowMaxFrame) {
		phase = APPEARANCE_EDITOR_PHASES.CONFIRM_SELECTION;
	}
}

// check if the current phase is confirm_selection
if (phase == APPEARANCE_EDITOR_PHASES.CONFIRM_SELECTION) {
	// clamp image index
	image_index = confirmWindowMaxFrame;
	
	// check for a click
	if (global.click) {
		// check for a collision with the yes button
		if (collision_rectangle(yesButtonLeft, yesButtonTop, yesButtonRight, yesButtonBottom, mouse, true, false)) {
			// set yn selection
			ynSelection = 1;
			
			// transition to keyboard menu for name entry
			room_transition(player.x, player.y, player.facing, rm_overworld, bgm_magicIsInTheAir);
		}
		
		// check for a collision with the no button
		if (collision_rectangle(noButtonLeft, noButtonTop, noButtonRight, noButtonBottom, mouse, true, false)) {
			// set yn selection
			ynSelection = 0;
			
			// set image index back to 0
			image_index = 0;
			
			// set phase to confirm window exit
			phase = APPEARANCE_EDITOR_PHASES.CONFIRM_WINDOW_EXIT;
		}
	}
	
	// check for back input
	if (global.back) {
		// set image index back to 0
		image_index = 0;
		
		// set phase to confirm window exit
		phase = APPEARANCE_EDITOR_PHASES.CONFIRM_WINDOW_EXIT;
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
			phase = APPEARANCE_EDITOR_PHASES.CONFIRM_WINDOW_EXIT;	
		}
		// check if index is 1
		if (ynSelection == 1) {
			// transition to the keyboard menu to enter a name
			room_transition(player.x, player.y, player.facing, rm_overworld, bgm_magicIsInTheAir);
		}
	}
}

// check if the current phase is confirm window exit
if (phase == APPEARANCE_EDITOR_PHASES.CONFIRM_WINDOW_EXIT) {
	// check if	image_index has reached the end
	if (image_index >= confirmWindowMaxFrame) {
		// reset phase to skintone selection
		phase = APPEARANCE_EDITOR_PHASES.OUTFIT_SELECTION;
	}
}

// check that the current phase is NOT confirm_selection
if (phase < APPEARANCE_EDITOR_PHASES.CONFIRM_WINDOW_ENTER) {	
	// check if select is being pressed
	if (global.select) {
		// increment phase
		phase++;
	}

	// check if back is being pressed
	if (global.back) {
		// check that the current phase is not the first phase
		if (phase > 0) {
			// decrement phase
			phase--;
		}
	}
	
	// check if start is being pressed
	if (global.start) {
		// set phase to confirm_window_enter
		phase = APPEARANCE_EDITOR_PHASES.CONFIRM_WINDOW_ENTER;
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