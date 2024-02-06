// create a list of all the sprites who are swapping this turn
swapList = ds_list_create();

// populate the list
var i = 0;	repeat (ds_grid_height(spar.turnGrid)) {
	// get the spotNum of the active sprite
	var activeSpot = spar.turnGrid[# selectionPhases.ally, i];
	
	// get the instance id of the active sprite
	var inst = spot_num_get_instance(activeSpot);
	
	// get the action of the i row
	var a = spar.turnGrid[# selectionPhases.action, i];
	
	// check if the action is a swap
	if (a == sparActions.swap) {
		// if so, set the sprite's swapping var to true
		inst.swapping = true;
		
		// get the target
		var t = spar.turnGrid[# selectionPhases.target, i];
		
		// get the target's instance id
		var targ = spar.spriteList[| t];
		
		// set the sprite's newSpriteID to equal their target
		inst.newSpriteID = targ.spriteID;
		
		// add the instance id to the swapList
		ds_list_add(swapList, inst);
		
		// clear this sprite's spot on the turn grid
		var ii = 0;	repeat (selectionPhases.height) {
			spar.turnGrid[# ii, i] = -1;
			
			ii++;
		}
	}
	
	i++;
}

// load swap turn message
spar.turnMsg = turn_message_get_number_text(ds_list_size(swapList)) + " sprites are swapping position";