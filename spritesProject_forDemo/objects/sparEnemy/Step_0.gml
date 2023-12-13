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
				if (ds_list_find_index(spar.inRangeSprites, id) != -1){
					spar_set_target();
					spar.selectionPhase = selectionPhases.ally;
				}
				
				// @TODO else, load ERROR sound effect
			}
		}
	}
}