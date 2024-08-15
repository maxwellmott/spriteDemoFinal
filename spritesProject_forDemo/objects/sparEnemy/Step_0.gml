/// @description Insert description here
// You can write your code in this editor

// check for mindset
sprite_check_mindset();

#region TARGET SELECTION

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

if (instance_exists(sparSpellFX)) {
	if (sparActionProcessor.activeSprite != id)
	&& (sparActionProcessor.targetSprite != id) {
		if (alpha > 0.0) {alpha -= 0.05;}
	}	else	{
		if (alpha < 1.0) {alpha += 0.05;}	
	}
}

if !(instance_exists(sparRestProcessor))
&& !(instance_exists(sparSpellFX)) {
	if (alpha < 1.0)	alpha += 0.05;
}

#endregion