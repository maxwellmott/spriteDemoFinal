// check if there is a currentOutfitArrow
if (currentOutfitArrow >= 0) {
	// check if the outfitClickFrame has been reached
	if (global.gameTime mod 40 == outfitClickFrame) {
		currentOutfitArrow = -1;
		outfitClickFrame = 0;
	}
}

// check if there is a currentHairstyleArrow
if (currentHairstyleArrow >= 0) {
	// check if the hairstyleClickFrame has been reached
	if (global.gameTime mod 40 == hairstyleClickFrame) {
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
						outfitClickFrame = global.gameTime mod 40;
						
						// set the phase to outfit selection
						phase = CHARACTER_CREATOR_PHASES.OUTFIT_SELECTION;
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
						outfitClickFrame = global.gameTime mod 40;
						
						// set the phase to outfit selection
						phase = CHARACTER_CREATOR_PHASES.OUTFIT_SELECTION;
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
						hairstyleClickFrame = global.gameTime mod 40;
						
						// set the phase to hairstyle selection
						phase = CHARACTER_CREATOR_PHASES.HAIRSTYLE_SELECTION;
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
						hairstyleClickFrame = global.gameTime mod 40;
						
						// set the phase to hairstyle selection
						phase = CHARACTER_CREATOR_PHASES.HAIRSTYLE_SELECTION;
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