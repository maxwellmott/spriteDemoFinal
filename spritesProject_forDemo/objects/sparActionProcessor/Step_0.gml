/// @description Insert description here
// You can write your code in this editor


// if waiting for input
if (state == ACTION_PROCESSOR_STATES.INPUT_PAUSE) {
	
	// fade out darkAlpha
	if (shadeAlpha >= 0) {
		shadeAlpha -= 0.05;	
	}
	
	// check if hpmp bars are up to date and
	// shadeAlpha is at 0
	if (spar_check_hpmp()) 
	&& (shadeAlpha <= 0.0) 
	&& (check_sprites_done_flashing()) {
		// if select button is clicked, destroy self
		if (global.select)	instance_destroy(id);	
	}
}

if (state == ACTION_PROCESSOR_STATES.ANNOUNCING)
&& (global.select) {
	if (spellEffect >= 0) {
		spellEffect();
	}
	
	if (spellFailed) {
		spar.turnMsg = "But the spell failed!";
		alarm[0] = 24; 
	}	else	{
		state = ACTION_PROCESSOR_STATES.FADING_IN;
	}
}

if (state == ACTION_PROCESSOR_STATES.FADING_IN) {
	if (shadeAlpha <= shadeAlphaMax) {
		shadeAlpha += 0.05;	
	}
	else {
		state = ACTION_PROCESSOR_STATES.CALCULATING;	
	}
}

if (state == ACTION_PROCESSOR_STATES.WAIT_FOR_FX) {
	if !(spar_check_invulnerable(targetSprite)) {
		// check if physical spell
		if (spellType == SPELL_TYPES.PHYSICAL) || (currentSpell < 0) {
			// set pose 
			activeSprite.currentPose = SPRITE_POSES.ATTACK;
		}
		// if not physical spell
		else {
			// set pose
			activeSprite.currentPose = SPRITE_POSES.SPELL;	
		}
		
		// if there was a successful dodge
		if (dodgeSuccess) {
			// increment dodgeCount for targetSprite
			targetSprite.dodgeCount += 1;
			
			// if dodge has started
			if (dodgeStarted) {
				// and if spar frame has reached dodgeFrameCount
				 if (spar.image_index >= dodgeFrameCount) {
					 // stop dodge animation
					dodgeStopped = true;	 
				 }
			}
			
			// if dodge animation has not been started
			if !(dodgeStarted) {
 			// change sprite to dodge animation
			targetSprite.sprite = spr_sparDodge;
			
			// prepare spar object to draw dodge animation
			sprite_index = spr_sparDodge;
			image_speed = 1;		
			
			// reset spar's image_index
			spar.image_index = 0;
			
			// set animationStarted to true
			dodgeStarted = true;
			}
		
			// if animation is complete, switch sprite back and increment dodgeCount
			if (dodgeStopped) {
				with (targetSprite) {
					// reset params
					sprite_load_parameters();	
					
					// increment dodgeCount
				}
				
				// move to display msg state
				state = ACTION_PROCESSOR_STATES.DISPLAY_MSG;
			}	
		}
		
		// if there was no successful dodge
		else {
			
			// if this is not a self targeting spell
			if (targetSprite != activeSprite) {
				// set target sprite's pose to hurt
				targetSprite.currentPose = SPRITE_POSES.HURT;
			}	
			// create spellFX
			create_once(0, 0, LAYER.meta, sparSpellFX);
		}
	}
	// if target invulnerable, destroy processor
	else		instance_destroy(id);
}

if (state == ACTION_PROCESSOR_STATES.CALCULATING) {
	//			IF THIS IS A BASIC ATTACK
	if (currentSpell < 0) {
		// check for dodge
		if (spellDodgeable) {
			if (targetSprite.dodging) 
			|| (targetSprite.sneaking) {
				dodgeSuccess = get_dodge_success();
			}
		}
		
		state = ACTION_PROCESSOR_STATES.WAIT_FOR_FX;
	}
	else /*		IF CURRENT ACTION IS A SPELL		*/ {	
		
		// check if there is enough MP to cast the spell
		if (activeSprite.team.currentMP - spellCost >= 0) {
		
			// subtract spellCost from player's MP
			activeSprite.team.currentMP -= spellCost;
			
			// check for dodge
			if (targetSprite.dodging) 
			|| (targetSprite.sneaking) {
				if (spellDodgeable) {
					dodgeSuccess = get_dodge_success();
				}
			}
			
			state = ACTION_PROCESSOR_STATES.WAIT_FOR_FX;
		}
		else {
			spar.turnMsg = activeSprite.name + " didn't have the energy to make a move...";
			
			state = ACTION_PROCESSOR_STATES.INPUT_PAUSE;
		}
	}
}

// check if current state is display msg
if (state == ACTION_PROCESSOR_STATES.DISPLAY_MSG) {
	// BASIC ATTACK
	if (currentSpell < 0) {
		if !(dodgeSuccess) {
			if !(spar_check_parrying()) {
				// turn off dodging/sneaking for targetSprite
				if (targetSprite.dodging)
				|| (targetSprite.sneaking) {
					targetSprite.dodging = false;
					targetSprite.sneaking = false;
				}
				
				// check for berserk damage increase
				spar_check_berserk_increase_damage(activeSprite);
				
				// apply damage and change turnMsg
				var t = targetSprite.team;
				
				deplete_hp(t, damage);
				
				spar.turnMsg = activeSprite.name + " attacked " + targetSprite.name;
			
			}
			// if target was parrying, destroy the processor
			else {				
				instance_destroy(id);				
			}
		// if target dodged change turnMsg
		}	else {
			spar.turnMsg = targetSprite.name + " dodged " + activeSprite.name + "'s attack";
		}
	}
	// SPELL
	else {	
		spar_check_black_hole_absorb_spell();
		spar_check_ball_lightning_absorb_spell();
		
		if !(dodgeSuccess) {
			if !(spar_check_parrying()) {
				// check if the caster of this spell is hexed
				spar_check_hexed(activeSprite);
				
				// if this is an elemental or trick spell:
				if (spellType < SPELL_TYPES.PHYSICAL) {
					// if target is deflective:
					if (spar_check_deflective(activeSprite, targetSprite, damage * 1.3)) {
						// destroy processor
						instance_destroy(id);
					}
				}
				
				// turn off dodging/sneaking for targetSprite
				if (targetSprite.dodging) 
				|| (targetSprite.sneaking) {
					targetSprite.dodging	= false;
					targetSprite.sneaking	= false;
				}
				
				// apply damage and change turnMsg
				var t = targetSprite.team;
				
				deplete_hp(t, damage);
				
				if (targetSprite != activeSprite) {
					spar.turnMsg = activeSprite.name + " cast " + spellName + " against " + targetSprite.name;
				}	else {
					spar.turnMs = activeSprite.name + " cast " + spellName;	
				}
			}
		}
		else {
			// change turnMsg	
			spar.turnMsg = targetSprite.name + " dodged " + activeSprite.name + "'s " + spellName;
		}
	}
	
	// regardless of anything else, after the rest is finished, move to input pause
	state = ACTION_PROCESSOR_STATES.INPUT_PAUSE;
}