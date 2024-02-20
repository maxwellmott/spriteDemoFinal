/// @description Insert description here
// You can write your code in this editor

if (state == ACTION_PROCESSOR_STATES.WAIT_FOR_FX) {
	
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
		if (animationStopped) {
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
		// set pose
		targetSprite.currentPose = SPRITE_POSES.HURT;
		
		// create spellFX
		create_once(0, 0, LAYER.meta, sparSpellFX);
	}
}

if (state == ACTION_PROCESSOR_STATES.CALCULATING) {
	//			IF THIS IS A BASIC ATTACK
	if (currentSpell < 0) {
		// calculate damage
		damage = get_physical_damage(activeSprite, targetSprite, BASIC_ATTACK_POWER);
		
		// check for dodge
		if (targetSprite.dodging) {
			dodgeSuccess = get_dodge_success();
		}
		
		state = ACTION_PROCESSOR_STATES.WAIT_FOR_FX;
	}
	else /*		IF CURRENT ACTION IS A SPELL		*/ {	
		
		// calculate physical damage if it's a physical spell
		if (spellType == SPELL_TYPES.PHYSICAL) {
			// calculate damage
			damage = get_physical_damage(activeSprite, targetSprite, spellPower);
		}
		// set damage to 0 if it's a trick spell
		else if (spellType == SPELL_TYPES.TRICK) {
			damage = 0;	
		}
		// calculate elemental damage if it's an elemental spell
		else {
			// calculate damage
			damage = get_elemental_damage(targetSprite, activeSprite, spellType, spellPower);
		}
		
		// check for dodge
		if (targetSprite.dodging) {
			dodgeSuccess = get_dodge_success();
			
			state = ACTION_PROCESSOR_STATES.WAIT_FOR_FX;
		}
	}
}

// check if current state is display msg
if (state == ACTION_PROCESSOR_STATES.DISPLAY_MSG) {
	// check if basic attack
	if (currentSpell < 0) {
		if !(dodgeSuccess) {
			// apply damage and change turnMsg
			var t = targetSprite.team;
			
			deplete_hp(t, damage);
			
			spar.turnMsg = activeSprite.name + " attacked " + targetSprite.name;
		
		}
		else {
			// change turnMsg
			spar.turnMsg = targetSprite.name + " dodged " + activeSprite.name + "'s attack";
		}
	}
	// or spell
	else {
		// call effect function
		execute(spellEffect);
		
		if !(dodgeSuccess) {
			// apply damage and change turnMsg
			var t = targetsprite.team;
			
			deplete_hp(t, damage);
			
			spar.turnMsg = activeSprite.name + " cast " + spellName + " against " + targetSprite.name;
		}
		else {
			// change turnMsg	
			spar.turnMsg = targetSprite.name + " dodged " + activeSprite.name + "'s " + spellName;
		}
	}
	
	// regardless of anything else, after the rest is finished, move to input pause
	state = ACTION_PROCESSOR_STATES.INPUT_PAUSE;
}

// if waiting for input
if (state == ACTION_PROCESSOR_STATES.INPUT_PAUSE) {
	// check if hpmp bars are up to date
	if (spar_check_hpmp()) {
		// if select button is clicked, destroy self
		if (global.select)	instance_destroy(id);	
	}
}