/// @description Insert description here
// You can write your code in this editor

// check if the player is selecting a target
if (spar.sparPhase == sparPhases.select) {
	// check that there is a selectedAlly
	if (player.selectedAlly >= 0) {
	
		// if player clicks on sprite, set sprite as target
		if (place_meeting(mouse.x, mouse.y, id)) {
			if (global.click) {
				player.selectedAlly.target = id;	
			}
		}
	}
}