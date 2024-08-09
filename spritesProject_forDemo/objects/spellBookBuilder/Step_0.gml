/// @description Insert description here
// You can write your code in this editor

if !(onlineWaiting) {
	if (global.shiftReleased) {
		displayingSpellSelector = !displayingSpellSelector;	
	}
	
	if (displayingSpellSelector) {
		
		if !(changingSpell) {
			if (global.menu_right) 
			&& (currentSpellIndex < spellCount - 1) {
				// increment currentSpellIndex
				currentSpellIndex++;
			
				// change necessary frames
				rightArrowFrame = 1;
				spellNameFrame = 1;
			
				// set frame resetting alarm
				alarm[0] = 24;
			
				// set changingSpell to true
				changingSpell = true;
			}
		
			if (global.menu_left) 
			&& (currentSpellIndex > 0) {
				// decrement currentSpellIndex
				currentSpellIndex--;
			
				// change necessary frames
				leftArrowFrame = 1;
				spellNameFrame = 1;
			
				// set frame resetting alarm
				alarm[0] = 24;
			
				// set changingSpell to true
				changingSpell = true;
			}
			
			if (global.click) {
				if (collision_rectangle(addButton_bboxLeft, addButton_bboxTop, addButton_bboxRight, addButton_bboxBottom, mouse, false, false)) {
					if (ds_list_find_index(spellBookList, currentSpellID) == -1) {
						// check if there are any empty slots on the spell list
						if (ds_list_size(spellBookList) < SPELLMAX) {
							// add the currentSpellID
							ds_list_add(spellBookList, currentSpellID);
						}
						else {
							var ind = ds_list_find_index(spellBookList, -1);
							
							if (ind >= 0) {
								spellBookList[| ind] = currentSpellID;	
							}
							else {
								// notify the player that they need to remove a spell
							}
						}
					}
				
					else {
						// notify the player that they have already selected that spell
				
					}
			
				// animate button
				addButtonFrame = 1;
				alarm[1] = 24;
				}
			}
		}
		
		// reset currentSpellID and currentSpellName
		currentSpellID = knownSpellList[| currentSpellIndex];
		currentSpellName = spellGrid[# SPELL_PARAMS.NAME, currentSpellID];
		spellInfoString = format_text(spellGrid[# SPELL_PARAMS.DESCRIPTION, currentSpellID], infoBannerWidth, 5.5, 1);
	
	}
	
	if !(displayingSpellSelector) {
		if (global.click) {
		// check if delete buttons are being pressed
		
			if !(deletePressed) {
				if (collision_rectangle(deleteColumnOne_bboxLeft,	deleteRowOne_bboxTop,	deleteColumnOne_bboxRight,	deleteRowOne_bboxBottom,	mouse,	false, false)) {
					spellBookList[| 0] = -1;
					deleteOneFrame = 1;
					alarm[2] = 24;
					deletePressed = true;
				}
			
				if (collision_rectangle(deleteColumnTwo_bboxLeft,	deleteRowOne_bboxTop,	deleteColumnTwo_bboxRight,	deleteRowOne_bboxBottom,	mouse,	false, false)) {
					spellBookList[| 1] = -1;
					deleteTwoFrame = 1;
					alarm[2] = 24;
					deletePressed = true;
				}
			
				if (collision_rectangle(deleteColumnOne_bboxLeft,	deleteRowTwo_bboxTop,	deleteColumnOne_bboxRight,	deleteRowTwo_bboxBottom,	mouse,	false, false)) {
					spellBookList[| 2] = -1;
					deleteThreeFrame = 1;
					alarm[2] = 24;
					deletePressed = true;
				}
			
				if (collision_rectangle(deleteColumnTwo_bboxLeft,	deleteRowTwo_bboxTop,	deleteColumnTwo_bboxRight,	deleteRowTwo_bboxBottom,	mouse,	false, false)) {
					spellBookList[| 3] = -1;
					deleteFourFrame = 1;
					alarm[2] = 24;
					deletePressed = true;
				}
			
				if (collision_rectangle(deleteColumnOne_bboxLeft,	deleteRowThree_bboxTop,	deleteColumnOne_bboxRight,	deleteRowThree_bboxBottom,	mouse,	false, false)) {
					spellBookList[| 4] = -1;
					deleteFiveFrame = 1;
					alarm[2] = 24;
					deletePressed = true;
				}
			
				if (collision_rectangle(deleteColumnTwo_bboxLeft,	deleteRowThree_bboxTop,	deleteColumnTwo_bboxRight,	deleteRowThree_bboxBottom,	mouse,	false, false)) {
					spellBookList[| 5] = -1;
					deleteSixFrame = 1;
					alarm[2] = 24;
					deletePressed = true;
				}
			
				if (collision_rectangle(deleteColumnOne_bboxLeft,	deleteRowFour_bboxTop,	deleteColumnOne_bboxRight,	deleteRowFour_bboxBottom,	mouse,	false, false)) {
					spellBookList[| 6] = -1;
					deleteSevenFrame = 1;
					alarm[2] = 24;
					deletePressed = true;
				}
			
				if (collision_rectangle(deleteColumnTwo_bboxLeft,	deleteRowFour_bboxTop,	deleteColumnTwo_bboxRight,	deleteRowFour_bboxBottom,	mouse,	false, false)) {
					spellBookList[| 7] = -1;
					deleteEightFrame = 1;
					alarm[2] = 24;
					deletePressed = true;
				}
			}
		}
	}
	acceptString = "";

	if (global.controllerType == controllerTypes.keyboard) {
		acceptString = "PRESS ENTER TO ACCEPT";
	}
	
	if (global.controllerType == controllerTypes.gamepad) {
		acceptString = "PRESS START TO ACCEPT";	
	}
	
	if (global.start) {
		if (instance_exists(onlineEnemy)) {
			client_set_match_ready();	
			onlineWaiting = true;
		}
		else	{
			player.spellBookString = "";
			player.spellBookString = encode_list(spellBookList);
			
			room_transition(player.x, player.y, player.facing, rm_overworld);
		}
	}
}

if (onlineWaiting) {
	// check if the enemy is ready every couple of turns
	if !(global.gameTime mod 120)	ready_check_begin();
}