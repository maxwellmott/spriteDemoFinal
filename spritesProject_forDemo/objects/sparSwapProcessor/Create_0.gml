// initialize swapComplete
swapComplete = false;

// create a list of all the sprites who are swapping this turn
swapList = ds_list_create();

// populate the list
var i = 0;	repeat (ds_grid_height(spar.turnGrid)) {
	// get the spotNum of the active sprite
	var activeSpot = spar.turnGrid[# 0, i];
	
	// get the instance id of the active sprite
	var inst = spot_num_get_instance(activeSpot);
	
	// get the action of the i row
	var a = spar.turnGrid[# 2, i];
	
	// check if the action is a swap
	if (a == sparActions.swap) {
		// if so, set the sprite's swapping var to true
		inst.swapping = true;
		
		// get the target
		var t = spar.turnGrid[# 1, i];
		
		// get the target's instance id
		var targ = spar.spriteList[| t];
		
		// set the sprite's newSpotNum to equal their target
		inst.newSpriteID = targ.spriteID;
		
		// add the instance id to the swapList
		ds_list_add(swapList, inst);
	}
	
	i++;
}

// load swap turn message