/// @description Insert description here
// You can write your code in this editor

// check if the player is selecting a sprite to command
if (spar.sparPhase == sparPhases.select) {
	// if player clicks on sprite, set sprite as selected
	if (place_meeting(mouse.x, mouse.y, id)) {
		if (global.click) {
			player.selectedAlly = id;
		}
	}
}

// check if the player is selecting a target
if (spar.sparPhase == sparPhases.select) {
	// check that there is a selected ally and that it is not this sprite
	if (player.selectedAlly >= 0) 
	&& (player.selectedAlly != id) {
	
		// if player clicks on sprite, set sprite as target
		if (place_meeting(mouse.x, mouse.y, id)) {
			if (global.click) {
				player.selectedAlly.target = id;	
			}
		}
	}
}