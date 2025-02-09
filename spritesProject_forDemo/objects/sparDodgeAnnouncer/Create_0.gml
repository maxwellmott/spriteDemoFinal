dodgeList = ds_list_create();

animationStarted = false;

dodgeFrameCount = 3;
animationStopped = false;

// populate the list
var i = 0;	repeat (ds_grid_height(spar.turnGrid)) {
	// get the spotNum of the active sprite
	var activeSpot = spar.turnGrid[# TURN_GRID.ALLY, i];
	
	// get the instance id of the active sprite
	var inst = spot_num_get_instance(activeSpot);
	
	// get the action of the i row
	var a = spar.turnGrid[# TURN_GRID.ACTION, i];
	
	// check if the action is a swap
	if (a == sparActions.dodge) {
		// if so, set the sprite's swapping var to true
		inst.dodging = true;
		
		// add the instance id to the restList
		ds_list_add(dodgeList, inst);
		
		// clear this sprite's spot on the turn grid
		var ii = 0;	repeat (TURN_GRID.HEIGHT - 1) {
			spar.turnGrid[# ii, i] = -1;
			
			ii++;
		}
	}
	
	i++;
}

if (ds_list_size(dodgeList) == 1) {
	spar.turnMsg = "One sprite is planning to dodge";	
}
else {
	spar.turnMsg = turn_message_get_number_text(ds_list_size(dodgeList)) + " sprites are planning to dodge";
}

dodgeBegin = false;

alarm[0] = 60;