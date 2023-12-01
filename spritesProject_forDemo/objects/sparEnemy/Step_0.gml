/// @description Insert description here
// You can write your code in this editor

// check if the player is selecting a target
if (spar.sparPhase == sparPhases.select) {
	// check that it is the target phase
	if (spar.selectionPhase == selectionPhases.target)
	&& (global.action != sparActions.swap) {
		// if player clicks on sprite, set sprite as target
		if collision_rectangle(bbLeft, bbTop, bbRight, bbBottom, mouse, false, true) {
			if (global.click) {
				player.selectedAlly.selectedAction = global.action;
				player.selectedAlly.selectedTarget = spotNum;
				player.selectedAlly.turnReady = true;
				spar.selectionPhase = selectionPhases.ally;
			}
		}
	}
}