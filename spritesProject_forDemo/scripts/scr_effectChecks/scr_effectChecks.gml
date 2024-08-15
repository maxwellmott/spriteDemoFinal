///@desc This function should be called by the spar object during the turnBegin phase.
/// It checks to see if either player has miasma and then queues up the apply miasma effect.
function spar_check_miasma() {
	if (playerOne.miasma) {
		spar_effect_push_alert(SPAR_EFFECTS.APPLY_MIASMA, playerOne);
	}
	
	if (playerTwo.miasma) {
		spar_effect_push_alert(SPAR_EFFECTS.APPLY_MIASMA, playerTwo);
	}
}

///@desc This function should be called by the spar object during the turnEnd phase.
/// It checks to see if either player has any timers that need to be incremented or turned off.
function spar_check_effect_timers() {
	with (sparAlly) {
		deflective = false;
		
		if (invulnerable) {
			if (invulnerableCounter == 1)	spar_effect_push_alert(SPAR_EFFECTS.END_INVULNERABLE, id);
		}
		
		if (bound) {
			if (boundCounter == 2)			spar_effect_push_alert(SPAR_EFFECTS.REMOVE_BOUND, id);	
					else					boundCounter++;
		}
		
		if (hexed) {
			if (hexedCounter == 2)			spar_effect_push_alert(SPAR_EFFECTS.REMOVE_HEXED, id);	
					else					hexedCounter++;
		}
		
		if (berserk) {
			if (berserkCounter == 3)		spar_effect_push_alert(SPAR_EFFECTS.END_BERSERK, id);
					else					berserkCounter++;	
		}
	}
	
	with (sparEnemy) {
		deflective = false;
		
		if (invulnerable) {
			if (invulnerableCounter == 1)	spar_effect_push_alert(SPAR_EFFECTS.END_INVULNERABLE, id);
		}
		
		if (bound) {
			if (boundCounter == 2)			spar_effect_push_alert(SPAR_EFFECTS.REMOVE_BOUND, id);	
					else					boundCounter++;
		}
		
		if (hexed) {
			if (hexedCounter == 2)			spar_effect_push_alert(SPAR_EFFECTS.REMOVE_HEXED, id);	
					else					hexedCounter++;
		}
		
		if (berserk) {
			if (berserkCounter == 3)		spar_effect_push_alert(SPAR_EFFECTS.END_BERSERK, id);
					else					berserkCounter++;	
		}
	}
}

///@desc This function checks the grid of timed blasts for any entries. If there are any 
/// timed blasts currently active, it will either decrement the count, or set off the blast
function check_timed_blasts() {
	
}

///@desc This function is called before damage is calculated in the processor. It simply adjusts
/// 
function spar_check_astral_caster(_atkr) {
	var atkr = _atkr;
	
	if (atkr.currentAlign == ALIGNMENTS.ASTRAL)	{
		global.damageMultiplierIndex += 1;	
		spar_effect_push_alert(SPAR_EFFECTS.INCREASE_DAMAGE_ASTRAL, atkr);
	}
}

///@desc This function is called before damage is calculated in the processor. It simply adjusts
/// the damageMultiplierIndex to reflect the defensive boost granted to mechanical sprites during physical
/// damage calculation
function spar_check_mechanical_target(_targ) {
	var targ = _targ;
	
	if (targ.currentAlign == ALIGNMENTS.MECHANICAL) {
		global.damageMultiplierIndex -= 1;	
		spar_effect_push_alert(SPAR_EFFECTS.DECREASE_DAMAGE_MECHANICAL, targ);
	}
}

function spar_check_natural_arena_boost() {
	
}

///@desc This function should be called by the actionProcessor whenever a sprite is being targeted
/// by a basic attack or physical spell. It performs a check to see if the target sprite is parrying.
/// If so, it posts the attacker, target, and damage to a sparEffectAlert and returns TRUE, else returns FALSE
function spar_check_parrying() {
	// if this is an elemental or trick spell, just return false
	if (spellType != SPELL_TYPES.PHYSICAL)		return false;
	
	// check if targetSprite is parrying
	if (targetSprite.parrying) {
		if (activeSprite.invulnerable) {
			spar_effect_push_alert(SPAR_EFFECTS.IGNORE_PARRY, activeSprite, targetSprite, damage);	
		}
		else {
			// post the sparEffectAlert
			spar_effect_push_alert(SPAR_EFFECTS.APPLY_PARRY, activeSprite, targetSprite, damage);
		}
	}
	
	// return parrying
	return targetSprite.parrying;
}

function spar_check_arena_effects() {
	
}

function spar_check_rust() {
	
}

function spar_check_hum() {
	
}

function spar_check_hexed() {
	
}

///@desc This function should be called whenever a SWAP is about to occur (forced or not). It
/// performs a check to see if a given sprite is currently bound, and returns a boolean indicating
/// whether it is or not (true if so, false if not)
function spar_check_bound(_inst) {
	// store args in locals
	var inst = _inst;
	
	// if bound, push apply bound effect alert
	if (inst.bound)	spar_effect_push_alert(SPAR_EFFECTS.APPLY_BOUND, inst);

	// return bound
	return inst.bound;
}

///@desc This function should be called whenever a sprite is about to be targeted individually by 
/// an effect or status. It performs a check to see if the given sprite is currently invulnerable,
/// and returns a boolean indicating whether it is or not (true if so, false if not)
function spar_check_invulnerable(_inst) {
	// store args in locals
	var inst = _inst;
	
	// if invulnerable, push apply invulnerable effect alert
	if (inst.invulnerable) spar_effect_push_alert(SPAR_EFFECTS.APPLY_INVULNERABLE, inst);
	
	// return invulnerable
	return inst.invulnerable;
}

///@desc This function should be called whenever a sprite is about to be target individually by 
/// an effect or status, or a player is trying to command a sprite to perform anything aside from
/// a basic attack or a rest
function spar_check_berserk(_inst) {
	// store args in locals
	var inst = _inst;
	
	// if berserk, push apply berserk effect alert
	if (inst.berserk) spar_effect_push_alert(SPAR_EFFECTS.APPLY_BERSERK, inst);
	
	// return berserk
	return inst.berserk;
}

function spar_check_mindset() {
	
}

function spar_check_multiply() {
	
}

function spar_check_divide() {
	
}

function spar_check_skydiving_deal_damage() {
	// check for skydives on the grid
	
	// if the skydiver is still flying, deal damage
	
	// else, push skydive failure effect alert
}

function spar_check_sneaking_deal_damage() {
	// check for sneak attacks on the grid
	
	// if the sneak attacker is still sneaking, deal damage
	
	// else, push sneak attack failure effect alert
}

///@desc This function is called by the actionProcessor whenever spell damage is about
/// to be applied. It instead queues up the deflection alert and returns true if deflective
function spar_check_deflective(_atkr, _targ, _powr) {
	// store args in locals
	var atkr = _atkr;
	var targ = _targ;
	var powr = _powr;
	
	// if the target is deflective:
	if (targ.deflective) {
		// push an effect alert for the deflection
		spar_effect_push_alert(SPAR_EFFECTS.DEFLECT_SPELL, atkr, targ, powr);
		
		// reset deflective for target
		targ.deflective = false;
		
		// return true
		return true;
	}
	// else, return false
	else	return false;
}

function spar_check_ball_lightning_absorb_spell() {
	
}

function spar_check_ball_lightning_deal_damage() {
	
}

function spar_check_black_hole_absorb_spell() {
	
}

function spar_check_black_hole_deal_damage() {
	
}

function spar_check_hail_mary() {
	
}