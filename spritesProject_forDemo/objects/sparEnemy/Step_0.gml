/// @description Insert description here
// You can write your code in this editor

if (spar_check_complete()) {
	exit;
}

if !(spar_check_hpmp()) {
	exit;
}

if !(check_sprites_done_flashing()) {
	exit;	
}

if (instance_exists(sparEffectAlert)) {
	exit;	
}

if (instance_exists(processorParent)) {
	exit;
}

if (instance_exists(sparSpellFX)) {
	exit;	
}

if (ds_list_size(effectAlertList) > 0) {
	exit;
}

if (onlineWaiting) {
	exit;
}

// check for mindset
sprite_check_mindset();

#region TARGET SELECTION

// check if the player is selecting a target
if (spar.sparPhase == SPAR_PHASES.SELECT) {
	// check that it is the target phase
	if (spar.selectionPhase == SELECTION_PHASES.TARGET)
	&& (global.action != sparActions.swap) {
		// if player clicks on sprite, set sprite as target
		if collision_rectangle(bbLeft, bbTop, bbRight, bbBottom, mouse, false, true) {
			if (global.click) {
				// set this sprite as the target of the current selection
				spar_set_target();
				
				// check if this sprite is OUT OF RANGE
				if (ds_list_find_index(spar.inRangeSprites, id) == -1) {
					// push a spar effect alert for out of range selection
					spar_effect_push_alert(SPAR_EFFECTS.OUT_OF_RANGE_SELECTION, id);
				}
				
				spar.selectionPhase = SELECTION_PHASES.ALLY;
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