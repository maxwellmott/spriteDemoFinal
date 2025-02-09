
// check if onlineWaiting
if !(onlineWaiting) {
	if (selectedTeamSlot == -1) {
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
		
		// set selectorMoved to true
		selectorMoved = true;
		
		// check if there are more rows than can be viewed on one page
		if (rowCount > columnHeight) {
			if (selectorIndex <= 1) {
				// set rowOneFrame to 1
				rowOneFrame = 1;
				
				// set optionsChangingDown to true
				optionsChangingDown = true;
				
				// decrement bottomRowNum by the number of rows per page
				bottomRowNum -= columnHeight;
				
				// clamp bottomRowNum to columnHeight and rowCount
				bottomRowNum = clamp(bottomRowNum, 0, rowCount - 1);
				
				//@TODO BUILD CASCADING ALARM SYSTEM AND SET ALARM HERE
				alarm[0] = alarmTime;
			}
		}
	}
	
	if (global.menu_down)
	&& (selectedNameSlot + 2 < rosterHeight) {
		selectedNameSlot += rowWidth;
		
		// set selectorMoved to true
		selectorMoved = true;
		
		// check if there are more rows than can be viewed on one page
		if (rowCount > columnHeight) {
			if (selectorIndex >= 6) {
				// set rowFiveFrame to 1
				rowFiveFrame = 1;
				
				// set optionsChangingUp to true
				optionsChangingUp = true;
				
				// increment bottomRowNum by the number of rows per page
				bottomRowNum	+= columnHeight;
				
				// clamp the bottomRowNum to columnHeight and rowCount
				bottomRowNum = clamp(bottomRowNum, 0, rowCount - 1);
				
				//@TODO BUILD CASCADING ALARM SYSTEM AND SET ALARM HERE
				alarm[0] = alarmTime;
			}
		}
	}
	
	if (global.menu_left)
	&& (selectedNameSlot > 0) {
		selectedNameSlot -= 1;	
		
		// set selectorMoved to true
		selectorMoved = true;
		
		// check if there are more rows than can be viewed on one page
		if (rowCount > columnHeight) {
			if (selectorIndex == 0) {
				// set rowOneFrame to 1
				rowOneFrame = 1;
			
				// set optionsChangingDown to true
				optionsChangingDown = true;
				
				// decrement bottomRowNum by the number of rows per page
				bottomRowNum -=columnHeight;
			
				// clamp the bottomRowNum to columnHeight and rowCount
				bottomRowNum = clamp(bottomRowNum, 0, rowCount - 1);
			
				//@TODO BUILD CASCADING ALARM SYSTEM AND SET ALARM HERE
				alarm[0] = alarmTime;
			}
		}
	}
	
	if (global.menu_right) 
	&& (selectedNameSlot < rosterHeight - 1) {
		selectedNameSlot += 1;
		
		// set selectorMoved to true
		selectorMoved = true;
		
		// check if there are more rows than can be viewed on one page
		if (rowCount > columnHeight) {
			if (selectorIndex == 7) {
				// set rowFiveFrame to 1
				rowFiveFrame = 1;
			
				// set optionsChangingUp to true
				optionsChangingUp = true;
			
				// increment bottomRowNum by the number of rows per page
				bottomRowNum += columnHeight;
			
				// clamp the bottomRowNum to columnHeight and rowCount
				bottomRowNum = clamp(bottomRowNum, 0, rowCount - 1);
		
				//@TODO BUILD CASCADING ALARM SYSTEM AND SET ALARM HERE
				alarm[0] = alarmTime;
			}
		}
	}
}
	
#endregion

if (selectorMoved) {

	// correct for overshooting the first or last name
	if (selectedNameSlot < 0)					selectedNameSlot = 0;
	if (selectedNameSlot > rosterHeight - 1)	selectedNameSlot = rosterHeight - 1;

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

	teambuilder_get_sprite_parameters();
	
	selectorMoved = false;
}
	
	#region MANAGE SELECTION
	
	if !(optionsChangingUp) 
	&& !(optionsChangingDown) {
		// manage spriteslot selection
		if (global.click) {	
		
			// check all team slots for collisions
			var i = 0;	repeat (ds_list_size(teamList)) {
				var left	= teamSlotLeftList[| i];
				var right	= teamSlotRightList[| i];
				var top		= teamSlotTopList[| i];
				var bottom	= teamSlotBottomList[| i];
				
				// check for a collision with the above dimensions
				if (collision_rectangle(left, top, right, bottom, mouse, true, false)) {
					// check if there is already a selected teamSlot
					if (selectedTeamSlot != -1) {
						var temp = teamList[| i];
						teamList[| i] = teamList[| selectedTeamSlot];
						teamList[| selectedTeamSlot] = temp;
						
						// set selectedTeamSlot to -1
						selectedTeamSlot = -1;
					}
					// if there is NOT already a selected teamSlot
					else {
						selectedTeamSlot = i;
					}
					
					spotClicked = true;
					break;
				}
				
				// increment i
				i++;
			}
			
			// check if a spot has not yet been clicked
			if !(spotClicked) {
				// check that there is a selectedTeamSlot
				if (selectedTeamSlot >= 0) {
					// check that there has not been a recent selection
					if !(recentSelection) {
						// check all name slots for collisions
						var i = 0;	repeat (columnHeight * rowWidth) {
							var left	= nameSlotLeftList[| i];
							var right	= nameSlotRightList[| i];
							var top		= nameSlotTopList[| i];
							var bottom	= nameSlotBottomList[| i];
						
							// check for a collision with the above dimensions
							if (collision_rectangle(left, top, right, bottom, mouse, true, false)) {
								alarm[2] = 24;
								
								if (ds_list_find_index(teamList, talismanList[| i + (bottomRowNum * rowWidth)]) == -1) {
									teamList[| selectedTeamSlot] = talismanList[| i + (bottomRowNum * rowWidth)];
								}
								else {
									// load error SFX	
								}
							}
						
							// increment i
							i++;
						}
					}
				}
			}
			
			// check if a spot has not yet been clicked
			if !(spotClicked) {
				// check if there is a selectedTeamSlot
				if (selectedTeamSlot >= 0) {
					selectedTeamSlot = -1;	
				}
			}
		}
		
		// manage nameSlot selection
		if (global.select) {
			if (selectedTeamSlot >= 0) 
			&& !(recentSelection) {
				recentSelection = true;
				alarm[2] = 24;
				
				if (ds_list_find_index(teamList, talismanList[| selectedNameSlot]) == -1) {
					teamList[| selectedTeamSlot] = talismanList[| selectedNameSlot];
				}
				else {
					// load error SFX	
				}
			}
		}
		
		spotClicked = false;
	}
	
	#endregion
	
	if !(instance_exists(onlineEnemy)) {
		if (global.start) {
			if (ds_list_size(teamList) == 4)
			&& (selectedTeamSlot == -1) {			
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
			&& (selectedTeamSlot == -1) {
				// set player.teamList
				player.teamList = teamList;			
				
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
	if (global.back) {
		player_cancel_team();

		exit;
	}
	
	if !(cancelled) {
		// send a request for the enemy team every couple of seconds	
		if !(global.gameTime mod 600)	request_team_begin();
	}
}