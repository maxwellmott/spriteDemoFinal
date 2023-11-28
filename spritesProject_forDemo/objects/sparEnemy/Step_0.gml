/// @description Insert description here
// You can write your code in this editor

// check if the player is selecting a target
if (spar.sparPhase == sparPhases.select) {
	// check that it is the target phase
	if (spar.selectionPhase == selectionPhases.target) {
		// if player clicks on sprite, set sprite as target
		if (place_meeting(mouse.x, mouse.y, id)) {
			if (global.click) {
				player.selectedAlly.target = id;	
				spar.selectionPhase = selectionPhases.ally;
			}
		}
	}
}