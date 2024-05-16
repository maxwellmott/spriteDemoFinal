/// @description Insert description here
// You can write your code in this editor

#region HANDLE ALLY AND TARGET SELECTION

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
			// select for a swap
			if (global.action == sparActions.swap)	{
				if collision_rectangle(bbLeft, bbTop, bbRight, bbBottom, mouse, false, true) {				
					if (swap_set_potential_cost(player.selectedAlly, id)) {
						if (global.click) {
							spar.totalSelectionCost += spar.potentialCost;
							spar.potentialCost = 0;
							
							spar_set_target();
							spar.selectionPhase = selectionPhases.ally;
						}
					}
					else {
						// indicate that you can't select this sprite
					}
				}
			}
			else {
	
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
}

#endregion

#region HANDLE READY DISPLAY

// check if selectedTarget is set
if (selectedTarget != -4) {
	// check if readyDisplay has been built
	if !(readyDisplayBuilt) {
		// if not, build readyDisplay
		sprite_build_ready_display();
	}
}

// set ready display to false
if (spar.sparPhase == sparPhases.process)
&& (readyDisplayBuilt) {
	readyDisplayBuilt = false;	
}

#endregion

#region CHANGE SPRITE FOR RESTING, SWAPPING, ETC
// check if swapping is true and sprite has yet to change
if (swapping) && (sprite != spr_sparSwapCloud) {
	// if swapping, change sprite to swapCloud
	sprite = spr_sparSwapCloud;
}

if (instance_exists(sparRestProcessor))
&& (sparRestProcessor.animationStarted) {
	// check if resting is true and sprite has yet to change
	if (resting) && (sprite != spr_sparRestEye) {
		// if resting, change sprite to restEye
		sprite = spr_sparRestEye;
	}
	
	// fade out sprite if they aren't resting during the rest process
	if !(resting) {
		if (alpha > 0.0) {alpha -= 0.05;}	
	}
	else {
		if (alpha < 1.0) {alpha += 0.05;}	
	}
}

if !(instance_exists(sparRestProcessor))
&& !(instance_exists(sparSpellFX)) {
	if (alpha < 1.0)	alpha += 0.05;
}

#endregion