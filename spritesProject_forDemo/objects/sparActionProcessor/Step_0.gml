/// @description Insert description here
// You can write your code in this editor

// if waiting for input
if (state == ACTION_PROCESSOR_STATES.APPLY_DAMAGE) {
	
	// fade out darkAlpha
	if (shadeAlpha >= 0) {
		shadeAlpha -= 0.05;	
	}
	
	// check if hpmp bars are up to date and
	// shadeAlpha is at 0
	if (spar_check_hpmp()) 
	&& (shadeAlpha <= 0.0) 
	&& (check_sprites_done_flashing()) {
		instance_destroy(id);
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
			// if dodge has started
			if (dodgeStarted) {
				// and if spar frame has reached dodgeFrameCount
				 if (spar.image_index >= dodgeFrameCount - 1) {
					 // stop dodge animation
					dodgeStopped = true;	 
				 }
			}
			
			// if dodge animation has not been started
			if !(dodgeStarted) {
				// increment dodgeCount for targetSprite
				targetSprite.dodgeCount += 1;
					
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
				if !(dodgeSuccess) {
					dodgeSuccess = get_dodge_success();
				}
			}
		}
		
		if !(dodgeSuccess) {
			// if this is an elemental damage spell spell:
			if (spellType < SPELL_TYPES.PHYSICAL) 
			&& (spellPower > 0) {
				// if target is deflective:
				if (spar_check_deflective(activeSprite, targetSprite, damage, currentSpell)) {
					// destroy processor
					instance_destroy(id);
				}
			}
		}
		
		state = ACTION_PROCESSOR_STATES.WAIT_FOR_FX;
	}
	else /*		IF CURRENT ACTION IS A SPELL		*/ {	
		
		// check if there is enough MP to cast the spell
		if (activeSprite.team.currentMP - spellCost >= 0) {
		
			// set mpSpendingSprite
			global.mpSpendingSprite = activeSprite;
			
			// subtract spellCost from player's MP
			deplete_mp(activeSprite.team, spellCost);
			
			// reset mpSpendingSprite
			global.mpSpendingSprite = -1;
			
			// check for dodge
			if (targetSprite.dodging) 
			|| (targetSprite.sneaking) {
				if (spellDodgeable) {
					if !(dodgeSuccess) {
						dodgeSuccess = get_dodge_success();
					}
				}
			}
			
			state = ACTION_PROCESSOR_STATES.WAIT_FOR_FX;
		}
		else {
			if (alarm[0] == -1) {
				alarm[0] = 90;
				spar.turnMsg = activeSprite.name + " didn't have the energy to make a move...";
			}
			
			exit;
		}
	}
}

// check if current state is display msg
if (state == ACTION_PROCESSOR_STATES.DISPLAY_MSG) {
	if (alarm[0] != -1) {
		exit;	
	}
	
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
				
				if !(spellFailed) {
					// perform an ability check for spell success
					ability_check(ABILITY_TYPES.ACTION_SUCCESS);						
				}				
				
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
			
			if (alarm[0] == -1)		alarm[0] = 90;
			exit;
		}
	}
	// SPELL
	else {	
		// check that this is NOT a self targeting spell
		if (targetSprite != activeSprite) {
			// set turnMsg to indicate the spell and its target
			spar.turnMsg = activeSprite.name + " cast " + spellName + " against " + targetSprite.name;
		}
		// if this IS a self targeting spell
		else {
			spar.turnMs = activeSprite.name + " cast " + spellName;
		}
		
		// check if the target is controlled by an ai enemy
		if (targetSprite.team.object_index == enemyAI) {
			// check that this spell is not already on the seenSpells list
			if (ds_list_find_index(targetSprite.team.seenSpells, currentSpell) == -1) {
				// add it to the list
				ds_list_add(targetSprite.team.seenSpells, currentSpell);
			}
		}		
		
		if !(dodgeSuccess) {
			if !(spar_check_parrying()) {
				// check if the caster of this spell is hexed
				spar_check_hexed(activeSprite);
				
				if !(spellFailed) {
					// perform an ability check for spell success
					ability_check(ABILITY_TYPES.ACTION_SUCCESS);						
				}
				
				if (spellEffect >= 0)
				&& !(spellFailed) {
					spellEffect();
				}
				
				if (spellFailed) {
					spar.turnMsg = "But the spell failed!";
					if (alarm[0] == -1)		alarm[0] = 90;
					exit;
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
			}
		}
		else {
			// change turnMsg	
			spar.turnMsg = targetSprite.name + " dodged " + activeSprite.name + "'s spell!";
			
			if (alarm[0] == -1)		alarm[0] = 90;
			exit;
		}
	}
	
	// check if there was no successful dodge
	if !(dodgeSuccess) {
		// regardless of anything else, after the rest is finished, move to input pause
		state = ACTION_PROCESSOR_STATES.APPLY_DAMAGE;
	}
}