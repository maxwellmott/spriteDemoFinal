if (global.select) {
	var i = 0;	repeat (ds_list_size(swapList)) {
		// get sprite's instance id
		var inst = swapList[| i];
		
		var swapperSpotNum = inst.spotNum;
		
		// get swap partner inst
		var partnerSpotNum	= spar.turnGrid[# selectionPhases.target, swapperSpotNum];
		var partnerInst		= spar.spriteList[| partnerSpotNum];
		
		// check if their swap partner has already processed their swap
		if (partnerInst.swapping) {
			// if they have not, set the cost for the swap so you can charge the player's MP
			var c = swap_get_cost(inst, partnerInst);
			
			// charge the MP cost
			inst.team.currentMP -= c;
		}
		
		// reset all of this sprites parameters
		with (inst) {
			if (team == player) {
				spar.allyList[| newTeamListPos] = id;	
			}
			else {
				spar.enemyList[| newTeamListPos] = id;	
			}
			
			spar.spriteList[| newGlobalListPos] = id;
			spriteID = newSpriteID;

			newSpriteID			= -1;
			newTeamListPos		= -1;
			newGlobalListPos	= -1;
			swapping = false;
			sprite_load_parameters();
		}
		
		i++;
	}
	
	instance_destroy(id);
}