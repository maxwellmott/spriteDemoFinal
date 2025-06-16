
#region	ANIMATE SELECTED ALLY

	if (id == player.selectedAlly) {
		if (gameTimeDiff == -1) {
			gameTimeDiff = (sin(global.gameTime / (8 * currentSize) + 8) * 2);
		}
		
		y = startY + (sin(global.gameTime / (8 * currentSize) + 8) * 2) - gameTimeDiff;	
	}
	else {
		y = startY;	
		
		if (gameTimeDiff != -1) {
			gameTimeDiff = -1;	
		}
	}

#endregion

#region HANDLE READY DISPLAY

// check if selectedTarget is set
if (selectedTarget >= -1) {
	// check if readyDisplay has been built
	if !(readyDisplayBuilt) {
		// if not, build readyDisplay
		sprite_build_ready_display();
	}
}

// set ready display to false
if (spar.sparPhase == SPAR_PHASES.PROCESS)
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

if (instance_exists(sparActionProcessor)) {
	if (sparActionProcessor.activeSprite != id)
	&& (sparActionProcessor.targetSprite != id) {
		alpha = 1.0 - sparActionProcessor.shadeAlpha;
	}
}

if !(instance_exists(sparRestProcessor))
&& !(instance_exists(sparSpellFX)) {
	if (alpha < 1.0)	alpha += 0.05;
}

#endregion

if (instance_exists(winLoseDisplay)) {
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

if (ds_list_size(spar.effectAlertList) > 0) {
	exit;
}

if (spar.onlineWaiting) {
	exit;
}

// check for mindset
sprite_check_mindset();

#region HANDLE ALLY AND TARGET SELECTION

// check if the player is selecting a sprite to command
if (spar.sparPhase == SPAR_PHASES.SELECT) {
	// check if it's either the select phase or the action phase
	if (spar.selectionPhase == SELECTION_PHASES.ALLY) 
	|| (spar.selectionPhase == SELECTION_PHASES.ACTION) {
		if !(turnRepeat) 
		&& !(immobilized) {
			// if player clicks on sprite, set sprite as selected
			if collision_rectangle(bbLeft, bbTop, bbRight, bbBottom, mouse, false, true) {
				if (global.click) {
					player.selectedAlly = id;
					spar.selectionPhase = SELECTION_PHASES.ACTION;
					
					if (instance_exists(sparSpellMenu)) {
						sparSpellMenu.usableSpells = player.selectedAlly.usableSpells;
					}
				}
			}
		}
	}

	// check that it is the target phase
	if (spar.selectionPhase == SELECTION_PHASES.TARGET) {
		// check that this sprite is not the selectedAlly
		if (player.selectedAlly != id) {
			// select for a swap
			if (global.action == sparActions.swap)	{
				if !(turnRepeat) 
				&& !(immobilized) {
					if collision_rectangle(bbLeft, bbTop, bbRight, bbBottom, mouse, false, true) {
						if !(spar_check_bound(id)) 
						&& !(spar_check_berserk(id)) {
							swap_set_potential_cost(player.selectedAlly, id);
							
							if (global.click) {							
								spar_set_target();
								spar.selectionPhase = SELECTION_PHASES.ALLY;
							}
						}
					}
				}
			}
			// if not selecting for a swap
			else {
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
	}
}

#endregion