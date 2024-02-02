// create a list to store the instance ids of all the sprites who are resting this turn
restList = ds_list_create();

restFrameCount = 15;
animationStopped = false;

// populate the list
var i = 0;	repeat (ds_grid_height(spar.turnGrid)) {
	// get the spotNum of the active sprite
	var activeSpot = spar.turnGrid[# selectionPhases.ally, i];
	
	// get the instance id of the active sprite
	var inst = spot_num_get_instance(activeSpot);
	
	// get the action of the i row
	var a = spar.turnGrid[# selectionPhases.action, i];
	
	// check if the action is a swap
	if (a == sparActions.rest) {
		// if so, set the sprite's swapping var to true
		inst.resting = true;
		
		// add the instance id to the restList
		ds_list_add(restList, inst);
		
		// clear this sprite's spot on the turn grid
		var ii = 0;	repeat (selectionPhases.height) {
			spar.turnGrid[# ii, i] = -1;
			
			ii++;
		}
	}
	
	i++;
}

frame = 0;