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
function spar_check_timed_blasts() {
	// get the height of the blastGrid
	var h = blastCount;
	
	// check if blastCount is at least 1
	if (blastCount > 0) {
		// push an alert to decrement the count of all blasts
		spar_effect_push_alert(SPAR_EFFECTS.BLAST_TIMERS_DECREMENT_COUNT);	
	}
}

///@desc This function is called before damage is calculated in the processor. It simply adjusts
/// the damageMultiplierIndex and then pushes a corresponding notification
function spar_check_astral_caster(_atkr) {
	var atkr = _atkr;
	
	if (atkr.currentAlign == ALIGNMENTS.ASTRAL)	
	&& (atkr.team.hum) {
		global.damageMultiplierIndex += 1;	
		spar_effect_push_alert(SPAR_EFFECTS.INCREASE_DAMAGE_ASTRAL, atkr);
	}
}

///@desc This function is called before damage is calculated in the processor. It simply adjusts
/// the damageMultiplierIndex to reflect the defensive boost granted to mechanical sprites during physical
/// damage calculation
function spar_check_mechanical_target(_targ) {
	var targ = _targ;
	
	if (targ.currentAlign == ALIGNMENTS.MECHANICAL) 
	&& !(targ.team.rust) {
		global.damageMultiplierIndex -= 1;	
		spar_effect_push_alert(SPAR_EFFECTS.DECREASE_DAMAGE_MECHANICAL, targ);
	}
}

///@desc This function is called before damage is calculated in the processor. It simply adjusts
/// the damageMultiplierIndex and then pushes a corresponding notification
function spar_check_natural_arena_boost(_atkr) {
	if (global.arena != -1) {
		var atkr = _atkr;
	
		if (atkr.currentAlign == ALIGNMENTS.NATURAL) {
			global.damageMultiplierIndex += 1;
			spar_effect_push_alert(SPAR_EFFECTS.INCREASE_DAMAGE_NATURAL, atkr);
		}
	}
}

///@desc This function should be called by the actionProcessor whenever a sprite is being targeted
/// by a basic attack or physical spell. It performs a check to see if the target sprite is parrying.
/// If so, it posts the attacker, target, and damage to a sparEffectAlert and returns TRUE, else returns FALSE
function spar_check_parrying() {
	// if this is an elemental or trick spell, just return false
	if (spellType != SPELL_TYPES.PHYSICAL)
	&& (spellType >= 0) {
		return false;
	}
	
	// check if targetSprite is parrying
	if (targetSprite.parrying) {
		if (activeSprite.invulnerable) 
		|| (activeSprite.berserk) {
			spar_effect_push_alert(SPAR_EFFECTS.IGNORE_PARRY, activeSprite, targetSprite, round(damage));	
		}
		else {
			// post the sparEffectAlert
			spar_effect_push_alert(SPAR_EFFECTS.APPLY_PARRY, activeSprite, targetSprite, round(damage));
		}
	}
	
	// return parrying
	return targetSprite.parrying;
}

///@desc This function should be called before calculating elemental damage. It checks the given spellType
/// as well as the current arena and then alters the DMI accordingly.
function spar_check_arena_effects(_spellType) {
	var st = _spellType;
	
	// check if arena is not normal
	if (global.arena != -1) {
		// use a switch statement to check for each arena type
		switch (global.arena) {
			case ARENAS.VOLCANO:
				// check if currentSpell is a water spell
				if (st == SPELL_TYPES.WATER) {
					global.damageMultiplierIndex -= 2;
					spar_effect_push_alert(SPAR_EFFECTS.VOLCANO_WATER_DECREASE_DAMAGE);
				}
				
				// check if currentSpell is a fire spell
				if (st == SPELL_TYPES.FIRE) {
					global.damageMultiplierIndex += 2;
					spar_effect_push_alert(SPAR_EFFECTS.VOLCANO_FIRE_INCREASE_DAMAGE);
				}
			break;
			
			case ARENAS.OCEAN:
				// check if currentSpell is a fire spell
				if (st == SPELL_TYPES.FIRE) {
					global.damageMultiplierIndex -= 2;
					spar_effect_push_alert(SPAR_EFFECTS.OCEAN_FIRE_DECREASE_DAMAGE);
				}
				
				// check if currentSpell is a water spell
				if (st == SPELL_TYPES.WATER) {
					global.damageMultiplierIndex += 2;
					spar_effect_push_alert(SPAR_EFFECTS.OCEAN_WATER_INCREASE_DAMAGE);
				}
				
				// check if currentSpell is a storm spell
				if (st == SPELL_TYPES.STORM) {
					global.damageMultiplierIndex += 2;
					spar_effect_push_alert(SPAR_EFFECTS.OCEAN_STORM_INCREASE_DAMAGE);
				}
			break;
			
			case ARENAS.CLOUDS:
				// check if currentSpell is an earth spell
				if (st == SPELL_TYPES.EARTH) {
					global.damageMultiplierIndex -= 2;
					spar_effect_push_alert(SPAR_EFFECTS.STRATOS_EARTH_DECREASE_DAMAGE);
				}
				
				// check if currentSpell is a storm spell
				if (st == SPELL_TYPES.STORM) {
					global.damageMultiplierIndex += 2;
					spar_effect_push_alert(SPAR_EFFECTS.STRATOS_STORM_INCREASE_DAMAGE);
				}
			break;
			
			case ARENAS.FOREST:
				// check if currentSpell is an earth spell
				if (st == SPELL_TYPES.EARTH) {
					global.damageMultiplierIndex += 2;
					spar_effect_push_alert(SPAR_EFFECTS.FOREST_EARTH_INCREASE_DAMAGE);
				}
				
				// check if currentSpell is a fire spell
				if (st == SPELL_TYPES.FIRE) {
					global.damageMultiplierIndex += 2;
					spar_effect_push_alert(SPAR_EFFECTS.FOREST_FIRE_INCREASE_DAMAGE);
				}
			break;
		}
	}
}

///@desc This function should be called before calculating physical damage. It checks if there
/// is rust and if the given target is of the mechanical alignment and then alters the DMI if necessary.
function spar_check_rust(_targ) {
	var targ = _targ;
	
	if (targ.team.rust) {
		if (targ.currentAlign == ALIGNMENTS.MECHANICAL) {
			global.damageMultiplierIndex += 1;
			spar_effect_push_alert(SPAR_EFFECTS.APPLY_RUST, targ);
		}
	}
}

///@desc This function should be called before calculating elemental damage. It checks if there
/// is hum and if the given target is of the astral alignment and then alters the DMI if necessary.
function spar_check_hum(_atkr) {
	var atkr = _atkr;
	
	if (atkr.team.hum) {
		if (atkr.currentAlign == ALIGNMENTS.ASTRAL) {
			global.damageMultiplierIndex -= 1;	
			spar_effect_push_alert(SPAR_EFFECTS.APPLY_HUM, atkr);
		}
	}
}

///@desc This function should be called whenever a spell is being selected by the player or being cast
/// in the actionProcessor. It performs a check to see if the given sprite is hexed, if so, it will
/// notify the player that they are. (If the actionProcessor exists, it will destroy it)
function spar_check_hexed(_inst) {
	// store args in locals
	var inst = _inst;
	
	// check if inst is hexed
	if (inst.hexed) {
		spar_effect_push_alert(SPAR_EFFECTS.APPLY_HEXED, inst);
		
		destroy_if_possible(sparActionProcessor);
		
		// return true
		return true;
	}
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

///@desc This function checks if the sprite using a basic attack is berserk and if so increases
/// the DMI by 1
function spar_check_berserk_increase_damage(_inst) {
	// store args in locals
	var inst = _inst;
	
	
	if (inst.berserk) {
		// increase DMI
		global.damageMultiplierIndex++;	

		// post spar effect alert
		spar_effect_push_alert(SPAR_EFFECTS.BERSERK_INCREASE_DAMAGE, inst);
	}
}

///@desc This function should be called by the sparAlly and sparEnemy object's once per frame. If their
/// mindset isn't normal, it should adjust their stats relative to their base stats.
function sprite_check_mindset() {
	// check if this sprite has an abnormal mindset
	if (mindset != MINDSETS.NORMAL) {
		switch (mindset) {
			case MINDSETS.IMP_CURSE:
				reset_all_stats(id);
			
				currentResistance = round(baseResistance * 0.67);
			break;
			
			case MINDSETS.MOTHER_CURSE:
				reset_all_stats(id);
			
				currentPower = round(basePower * 0.67);
			break;
			
			case MINDSETS.TREE_CURSE:
				reset_all_stats(id);
				
				currentLuck = round(baseLuck * 0.33);
			break;
			
			case MINDSETS.WARRIOR_CURSE:
				reset_all_stats(id);
			
				currentAgility = round(baseAgility * 0.5);
			break;

			case MINDSETS.IMP_BLESS:
				reset_all_stats(id);
			
				currentAgility = round(baseAgility * 2);
			break;
			
			case MINDSETS.MOTHER_BLESS:
				reset_all_stats(id);
			
				currentLuck = round(baseLuck * 3);
			break;
			
			case MINDSETS.TREE_BLESS:
				reset_all_stats(id);
			
				currentResistance = round(baseResistance * 1.5);
			break;
			
			case MINDSETS.WARRIOR_BLESS:
				reset_all_stats(id);
			
				currentPower = round(basePower * 1.5);
			break;
		}
	}
	else {
		reset_all_stats(id);	
	}
}

function spar_check_multiply() {
	
}

function spar_check_divide() {
	
}

///@desc This function should be called by the spar object at the end
/// of each turn. It checks the skydiving grid for any skydivers. If
/// necessary, it will check to see if they are successful and then push
/// the appropriate alert. (It then clears and resizes the skydiveGrid)
function spar_check_skydiving_deal_damage() {
	// get the height of the grid
	var h = skydiveCount;
	
	// use a repeat loop to check each item on the grid
	var i = 0;	repeat (h) {
		// get the atkr and targ of the current skydive
		var atkr = skydiveGrid[# 0, i];
		var targ = skydiveGrid[# 1, i];
		
		// check if the skydiver is still flying
		if (atkr.flying) {
			// push skydive effect alert
			spar_effect_push_alert(SPAR_EFFECTS.SKYDIVE_APPLY_DAMAGE, atkr, targ);
		}
		// else push skydive fail alert
		else	spar_effect_push_alert(SPAR_EFFECTS.SKYDIVE_FAILURE, atkr);
		
		// increment i
		i++;
	}

	// clear the grid and resize it
	ds_grid_clear(skydiveGrid, -1);
	ds_grid_resize(skydiveGrid, 2, 0);
	
	// reset skydiveCount
	skydiveCount = 0;
}

///@desc This function should be called by the spar object at the end 
/// of each turn. It checks the sneakAttack grid for any sneak attacks. If
/// necessary, it will check to see if they are successful and then push 
/// the appropriate alert. (It then clears and resizes the SneakAttackGrid)
function spar_check_sneaking_deal_damage() {
	// get the height of the grid
	var h = sneakAttackCount;
	
	// use a repeat loop to check each item of the grid
	var i = 0;	repeat (h) {
		// get the atkr and targ of the current sneakAttack
		var atkr = sneakAttackGrid[# 0, i];
		var targ = sneakAttackGrid[# 1, i];
		
		// check if the sneakAttacker is still sneaking
		if (atkr.sneaking) {
			// push sneak attack effect alert
			spar_effect_push_alert(SPAR_EFFECTS.SNEAK_ATTACK_APPLY_DAMAGE, atkr, targ);
		}
		// else push sneak attack fail alert
		else	spar_effect_push_alert(SPAR_EFFECTS.SNEAK_ATTACK_FAILURE, atkr);
		
		// set sneaking to false for atkr
		atkr.sneaking = false;
		
		// increment i
		i++;
	}
	
	// clear the grid and resize it
	ds_grid_clear(sneakAttackGrid, -1);
	ds_grid_resize(sneakAttackGrid, 2, 0);
	
	// reset sneakAttackCount
	sneakAttackCount = 0;
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
		spar_effect_push_alert(SPAR_EFFECTS.DEFLECT_SPELL, atkr, targ, round(powr));
		
		// reset deflective for target
		targ.deflective = false;
		
		// return true
		return true;
	}
	// else, return false
	else	return false;
}

///@desc This function is called by the actionProcessor whenever a storm spell is being
/// used. It performs a check to see if there is ball lightning active. If so, it pushes
/// the appropriate alert and then destroys the actionProcessor.
function spar_check_ball_lightning_absorb_spell() {
	if (spellType == SPELL_TYPES.STORM) {
		var i = 0;	repeat (ds_grid_height(spar.turnGrid)) {
			var inst = spar.spriteList[| i];
			
			if (inst.ballLightningActive) {
				spar_effect_push_alert(SPAR_EFFECTS.BALL_LIGHTNING_ABSORB_SPELL, inst);
				
				// destroy the actionProcessor
				instance_destroy(id);
			}
			
			i++;
		}
	}
}

///@desc This function is called by the spar object at the end of the turn. It performs
/// a check to see if there are any sprites casting ball lightning. It then calculates and
/// applies the damage.
function spar_check_ball_lightning_deal_damage() {
	var i = 0;	repeat (ds_grid_height(turnGrid)) {
		// get current instance
		var inst = spriteList[| i];
	
		// check if inst has ballLightningActive
		if (inst.ballLightningActive) {
			// check if caster has become hexed
			if (spar_check_hexed(inst)) {
				inst.ballLightningCount = 0;
				inst.ballLightningActive = false;
				inst.ballLightningTarget = -1;
				
				return true;
			}
			
			// check if this is an astral sprite
			spar_check_astral_caster(inst);
			
			// check if hum is active
			spar_check_hum(inst);
			
			// check for arena effects
			spar_check_arena_effects(SPELL_TYPES.STORM);
			
			// check for natural arena boost
			spar_check_natural_arena_boost(inst);
			
			// store ballLightning's base spellPower in a local var
			var sp = 80;
			
			// 20 to spell power for every spell absorbed
			sp += 20 * inst.ballLightningCount;
			
			// post effect alert
			spar_effect_push_alert(SPAR_EFFECTS.BALL_LIGHTNING_APPLY_DAMAGE, inst, inst.ballLightningTarget, sp);
		}
	
		// increment i
		i++;
	}
}

///@desc This function is called by the actionProcessor whenever a spell is being used. It
/// performs a check to see if there is ball lightning active. If so, it pushes the appropriate
/// alert and then destroys the actionProcessor
function spar_check_black_hole_absorb_spell() {
	var i = 0;	repeat (ds_grid_height(spar.turnGrid)) {
		// get current inst
		var inst = spar.spriteList[| i];
		
		// check if inst has black hole active
		if (inst.blackHoleActive) {
			spar_effect_push_alert(SPAR_EFFECTS.BLACK_HOLE_ABSORB_SPELL, inst);
			
			// destroy the actionProcessor
			instance_destroy(id);
		}
	
		// increment i
		i++;
	}
}

///@desc This function is called by the spar object at the end of the turn. It performs
/// a check to see if there are any sprites castign black hole. It then calculates and applies
/// the damage.
function spar_check_black_hole_deal_damage() {
	var i = 0;	repeat (ds_grid_height(turnGrid)) {
		// get current instance
		var inst = spriteList[| i];
		
		// check if inst has black hole active
		if (inst.blackHoleActive) {
			// check if the caster has become hexed
			if (spar_check_hexed(inst)) {
				inst.blackHoleCount = 0;
				inst.blackHoleActive = false;
				inst.blackHoleTarget = -1;
				
				return true;
			}
		}
		// check for natural arena boost
		spar_check_natural_arena_boost(inst);
		
		// store blackHole's power in a local var
		var sp = 0;
		
		// add 40 to spell power for every spell absorbed
		sp += 40 * inst.blackHoleCount;
		
		if (sp > 0) {
			// calculate damage
			var d = get_physical_damage(inst, inst.blackHoleTarget, sp);
		
			// apply damage
			deplete_hp(inst.blackHoleTarget.team, d);
		}
	}
}

///@desc This function is called by the spar object at the beginning of the turn. It performs
/// a check to see if either player has hailSphera set to true. If so, it pushes an alert to
/// set all sprites to invulnerable for that player's team
function spar_check_hail_sphera() {
	// check if player one has hail mary active
	if (playerOne.hailSphera) {
		// if so, push hail mary effect for player one
		spar_effect_push_alert(SPAR_EFFECTS.HAIL_SPHERA_SET_INVULNERABLE, playerOne);
	}
	
	// check if player two has hail mary active
	if (playerTwo.hailSphera) {
		// if so, push hail mary effect for player two
		spar_effect_push_alert(SPAR_EFFECTS.HAIL_SPHERA_SET_INVULNERABLE, playerTwo);
	}
}