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
					spar_set_target();
					spar.selectionPhase = selectionPhases.ally;
				}
			}
		}
	}
}

// check if selectedTarget is set
if (selectedTarget != -4) {
	// check if readyDisplay has been built
	if !(readyDisplayBuilt) {
		// if not, build readyDisplay
		sprite_build_ready_display();
	}
}

if (spar.sparPhase == sparPhases.process)
&& (readyDisplayBuilt) {
	readyDisplayBuilt = false;	
}

// check if swapping is true
if (swapping) {
	// if swapping, change sprite to swapCloud
	sprite = spr_sparSwapCloud;
}