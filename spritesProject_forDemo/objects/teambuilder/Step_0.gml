
// check if onlineWaiting
if !(onlineWaiting) {
	if (selectedSpriteSlot == -1) {
		// reset msg in case controller type changed
		if (global.controllerType == controllerTypes.keyboard) {
			msg = "PRESS ENTER TO ACCEPT";
		}
	
		if (global.controllerType == controllerTypes.gamepad) {
			msg = "PRESS START TO ACCEPT";
		}
	}
	else {
		if !(recentSelection) {
			msg = "SELECT A SPRITE!";	
		}	
		else {
			msg = "SPRITE SELECTED!";	
		}
	}	
	
	// set next alarm for cascading alarm system
	if (optionsChangingUp) 
	|| (optionsChangingDown) {
		if (alarm[0] == -1)	alarm[0] = alarmTime;	
	}
			
	#region MANAGE SELECTOR MOVEMENT
if !(optionsChangingUp)
	&& !(optionsChangingDown) {
	if (global.menu_up) 
	&& (currentRow > 0) {
		selectedNameSlot -= rowWidth;
		
		if (selectorIndex <= 1) {
			// set rowOneFrame to 1
			rowOneFrame = 1;
			
			// set optionsChangingDown to true
			optionsChangingDown = true;
			
			// decrement bottomRowNum
			bottomRowNum -= 1;
			
			//@TODO BUILD CASCADING ALARM SYSTEM AND SET ALARM HERE
			alarm[0] = alarmTime;
		}
	}
	
	if (global.menu_down)
	&& (selectedNameSlot + 2 < rosterHeight) {
		selectedNameSlot += rowWidth;
		
		if (selectorIndex >= 6) {
			// set rowFiveFrame to 1
			rowFiveFrame = 1;
			
			// set optionsChangingUp to true
			optionsChangingUp = true;
			
			// increment bottomRowNum
			bottomRowNum	+= 1;
			
			//@TODO BUILD CASCADING ALARM SYSTEM AND SET ALARM HERE
			alarm[0] = alarmTime;
		}
	}
	
	if (global.menu_left)
	&& (selectedNameSlot > 0) {
		selectedNameSlot -= 1;	
		
		if (selectorIndex == 0) {
			// set rowOneFrame to 1
			rowOneFrame = 1;
			
			// set optionsChangingDown to true
			optionsChangingDown = true;
			
			// decrement bottomRowNum
			bottomRowNum -= 1;
			
			//@TODO BUILD CASCADING ALARM SYSTEM AND SET ALARM HERE
			alarm[0] = alarmTime;
		}
	}
	
	if (global.menu_right) 
	&& (selectedNameSlot < rosterHeight - 1) {
		selectedNameSlot += 1;
		
		if (selectorIndex == 7) {
			// set rowFiveFrame to 1
			rowFiveFrame = 1;
			
			// set optionsChangingUp to true
			optionsChangingUp = true;
			
			// increment bottomRowNum
			bottomRowNum += 1;
		
			//@TODO BUILD CASCADING ALARM SYSTEM AND SET ALARM HERE
			alarm[0] = alarmTime;
		}
	}
}

// correct for overshooting the first or last name
if (selectedNameSlot < 0)					selectedNameSlot = 0;
if (selectedNameSlot > rosterHeight - 1)	selectedNameSlot = rosterHeight - 1;

#endregion
	
	// reset currentRow and currentColumn
	currentRow = selectedNameSlot div rowWidth;
	currentColumn = (rowWidth - 1) - ((selectedNameSlot + 1) mod rowWidth);
	
	#region CORRECT SELECTOR INDEX AND POSIITON
	if !(recentSelection) {
		// reset selectorIndex
		var start = (bottomRowNum * rowWidth);
		
		selectorIndex = selectedNameSlot - start;
		
		switch (selectorIndex) {
			case 0:		selectorX = nameSlotColumnOne;		selectorY = nameSlotRowTwo;		break;
			case 1:		selectorX = nameSlotColumnTwo;		selectorY = nameSlotRowTwo;		break;
			
			case 2:		selectorX = nameSlotColumnOne;		selectorY = nameSlotRowThree;	break;
			case 3:		selectorX = nameSlotColumnTwo;		selectorY = nameSlotRowThree;	break;
			
			case 4:		selectorX = nameSlotColumnOne;		selectorY = nameSlotRowFour;	break;
			case 5:		selectorX = nameSlotColumnTwo;		selectorY = nameSlotRowFour;	break;
			
			case 6:		selectorX = nameSlotColumnOne;		selectorY = nameSlotRowFive;	break; 
			case 7:		selectorX = nameSlotColumnTwo;		selectorY = nameSlotRowFive;	break;
		}		
	}
#endregion
	
	#region MANAGE SELECTION
	
	if !(optionsChangingUp) 
	&& !(optionsChangingDown) {
		// manage spriteslot selection
		if (global.click) {
			// spriteSlotOne
			if collision_rectangle(spriteSlotOne_bboxLeft, spriteSlot_bboxTop, spriteSlotOne_bboxRight, spriteSlot_bboxBottom, mouse, true, false) {
				selectedSpriteSlot = 0;
			}
			
			// spriteSlotTwo
			else if collision_rectangle(spriteSlotTwo_bboxLeft, spriteSlot_bboxTop, spriteSlotTwo_bboxRight, spriteSlot_bboxBottom, mouse, true, false) {
				selectedSpriteSlot = 1;	
			}
			
			// spriteSlotThree
			else if collision_rectangle(spriteSlotThree_bboxLeft, spriteSlot_bboxTop, spriteSlotThree_bboxRight, spriteSlot_bboxBottom, mouse, true, false) {
				selectedSpriteSlot = 2;
			}
			
			// spriteSlotFour
			else if collision_rectangle(spriteSlotFour_bboxLeft, spriteSlot_bboxTop, spriteSlotFour_bboxRight, spriteSlot_bboxBottom, mouse, true, false) {
				selectedSpriteSlot = 3;
			}
			
			// set to -1
			else {
				selectedSpriteSlot = -1;	
			}
		}
		
		// manage nameSlot selection
		if (global.select) {
			if (selectedSpriteSlot >= 0) 
			&& !(recentSelection) {
				recentSelection = true;
				alarm[2] = 24;
				
				if (ds_list_find_index(teamList, talismanList[| selectedNameSlot]) == -1) {
					teamList[| selectedSpriteSlot] = talismanList[| selectedNameSlot];
				}
				else {
					// load error SFX	
				}
			}
		}
	}
	
	#endregion
	
	if !(instance_exists(onlineEnemy)) {
		if (global.start) {
			if (ds_list_size(teamList) == 4)
			&& (selectedSpriteSlot == -1) {			
				// set player.teamString
				player.teamString = "";
				player.teamString = encode_list(teamList);
			
				instance_destroy(id);	
			}
		}
	}
	
	if (instance_exists(onlineEnemy)) {
		if (global.start) {
			if (ds_list_size(teamList) == 4)
			&& (selectedSpriteSlot == -1) {
				// set player.teamList
				player.teamList = teamList			
				
				// set player.teamString
				player.teamString = "";
				player.teamString = encode_list(teamList);
				
				// call function to submit team
				submit_team_begin();
				
				// set onlineWaiting
				onlineWaiting = true;
			}
		}
	}
}

if (onlineWaiting) {
	// send a request for the enemy team every couple of seconds	
	if (global.gameTime mod 120 == 0)	request_team_begin();
}

if !(recentSelection) {
	teambuilder_get_sprite_parameters();	
}