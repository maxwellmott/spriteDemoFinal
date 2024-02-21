// create a list to store the instance ids of all the sprites who are resting this turn
restList = ds_list_create();

animationStarted = false;

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

if (ds_list_size(restList) == 1) {
	spar.turnMsg = "One sprite is resting to regain energy";	
}
else {
	spar.turnMsg = turn_message_get_number_text(ds_list_size(restList)) + " sprites are resting to regain energy";
}