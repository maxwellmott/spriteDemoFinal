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
		// get their swap partner's ID
		var t = spar.turnGrid[# selectionPhases.target, i];
		var pid = spar.spriteList[| t];
		
		// perform an ability check for swap attempt for inst
		ability_check(inst, ABILITY_CHECKS.SWAP_ATTEMPT, pid);
		
		// perform an ability check for swap attempt for pid
		ability_check(pid, ABILITY_CHECKS.SWAP_ATTEMPT, inst);
		
		if !(spar_check_bound(inst))	{
			if	!(spar_check_bound(pid))	{
				// if swapping and neither are bound, 
				// set the sprite's swapping var to true
				inst.swapping = true;
				
				// reset all statuses
				inst.hexed			= false;
				inst.invulnerable	= false;
				inst.berserk		= false;

			
				// get the target
				var t = spar.turnGrid[# selectionPhases.target, i];
			
				// get the target's instance id
				var targ = spar.spriteList[| t];
			
				// set the sprite's new ID to equal their targets current ID
				inst.newSpriteID		= targ.spriteID;
			
				// add the instance id to the swapList
				ds_list_add(swapList, inst);
			
				// set this sprite's action to -1 on the turn grid
				spar.turnGrid[# selectionPhases.action, i] = -1;
			}
			else	{
				// set both swappers' action to -1 on the turn grid
				spar.turnGrid[# selectionPhases.action, i] = -1;
				spar.turnGrid[# selectionPhases.action, t] = -1;
			}
		}
		else	{
				// set both swappers' action to -1 on the turn grid
				spar.turnGrid[# selectionPhases.action, i] = -1;
				spar.turnGrid[# selectionPhases.action, t] = -1;
		}
	}
	
	i++;
}

// load swap turn message
spar.turnMsg = turn_message_get_number_text(ds_list_size(swapList)) + " sprites are swapping position";