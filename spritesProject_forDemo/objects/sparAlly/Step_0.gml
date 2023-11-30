/// @description Insert description here
// You can write your code in this editor

// check if the player is selecting a sprite to command
if (spar.sparPhase == sparPhases.select) {
	// check if it's either the select phase or the action phase
	if (spar.selectionPhase == selectionPhases.ally) 
	|| (spar.selectionPhase == selectionPhases.action) {
		// if player clicks on sprite, set sprite as selected
		if collision_rectangle(bbLeft, bbTop, bbRight, bbBottom, mouse, false, true) {
			if (global.click) {
				player.selectedAlly = id;
				spar.selectionPhase = selectionPhases.action;
			}
		}
	}
}

// check if the player is selecting a target
if (spar.sparPhase == sparPhases.select) {
	// check that it is the target phase
	if (spar.selectionPhase == selectionPhases.target) {
		// check that this sprite is not the selectedAlly
		if (player.selectedAlly != id) {
	
			// if player clicks on sprite, set sprite as target
			if collision_rectangle(bbLeft, bbTop, bbRight, bbBottom, mouse, false, true) {
				if (global.click) {
					player.selectedAlly.target = id;	
					spar.selectionPhase = selectionPhases.ally;
				}
			}
		}
	}
}