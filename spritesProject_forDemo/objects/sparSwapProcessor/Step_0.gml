if (swapBegin) {
	var i = 0;	repeat (ds_list_size(global.swapList)) {
		// get sprite's instance id
		var inst = global.swapList[| i];
		
		if (inst.swapping) {
			var swapperSpotNum = inst.spotNum;
		
			// get swap partner inst
			var partnerSpotNum	= spar.turnGrid[# TURN_GRID.TARGET, swapperSpotNum];
			var partnerInst		= spar.spriteList[| partnerSpotNum];
		
			// check if their swap partner has already processed their swap
			if (partnerInst.swapping) {
				// if they have not, set the cost for the swap so you can charge the player's MP
				var c = swap_get_cost(inst, partnerInst);
			
				// set mpSpendingSprite
				global.mpSpendingSprite = inst;
			
				// charge the MP cost
				deplete_mp(inst.team, c);
				
				// reset mpSpendingSprite
				global.mpSpendingSprite = -1;
			}
			
			// maintain sprite mindsets during swap
			var m1 = inst.mindset;
			var m2 = partnerInst.mindset;
		
			// reset all of this sprites parameters
			with (inst) {
				spriteID = real(newSpriteID);
				newSpriteID  = -1;
				
				swapping = false;
				sprite_load_parameters();
			}
		
			with (partnerInst) {
				spriteID = real(newSpriteID);
				newSpriteID = -1;
				
				swapping = false;
				sprite_load_parameters();
			}
			
			// swap their mindsets to maintain
			inst.mindset = m2;
			partnerInst. mindset = m1;
		}
		
		i++;
	}
	
	ability_check(ABILITY_TYPES.SWAP_SUCCESS);
	
	instance_destroy(id);
}