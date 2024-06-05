///@desc This function asks for one argument--the ID of an effect from the SPAR_EFFECTS
/// enum--but it is meant to be overloaded with any arguments that the given function
/// requires. This function is called by spells and abilities and different checks that 
/// would result in a spar effect needing to be somehow applied. The function takes
/// the ID of the given effect function, as well as any overloading args and stores
/// them on an encoded list which is then pushed to the spar effectAlertList.
function spar_effect_push_alert(_effectID) {
	// store effectFunction ID in local variable
	var eid = _effectID;
	
	// create a temporary list to store all arguments
	var list = ds_list_create();
	
	// add effectID to temporary list
	list[| 0] = eid;
	
	// get number of additional arguments
	var argCount = argument_count - 1;
	
	// check if there are any additional arguments
	if (argCount > 0) {
		// use a repeat loop to parse through additional args
		var i = 1;	repeat (argCount) {
			// add additional args to temporary list
			list[| i] = argument[i];
			
			// increment i
			i++;
		}
	}
	
	// encode temporary list
	var encList = encode_list(list);
	
	// push encoded list to alert list
	ds_list_push(spar.effectAlertList, encList);
}

///@desc This function is called in the create event of the sparEffectAlert object. The
/// function simply finds any arguments on the alertParams list and adds them to the global.argumentList
/// for the execute_arguments function being used to call the effect function attached to the alert
function effect_alert_get_args() {
	if (ds_list_size(alertParams) > 1) {
		var i = 1;	repeat (ds_list_size(alertParams) - 1) {
			global.argumentList[| i - 1] = alertParams[| i];
			
			i++;	
		}
	}
}

///@desc This function is called when the alertText is loaded. It replaces underscores
/// with any subject that may have been loaded by the effectFunction. It replaces
/// asterisks with any object that may have been loaded by the effectFunction.
function effect_alert_build_text() {
	
}

// enum that contains all spar hindrances
enum HINDRANCES {
	MIASMA,
	HUM,
	RUST,
	HEIGHT
}

// enum that contains all spar mindsets
enum MINDSETS {
	MOTHER,
	WARRIOR,
	IMP,
	TREE,
	HEIGHT
}

// enum that contains all spar effect IDs
enum SPAR_EFFECTS {
	ARENA_CHANGE_VOLCANO,
	ARENA_CHANGE_OCEAN,
	ARENA_CHANGE_STRATOS,
	ARENA_CHANGE_FOREST,
	ARENA_CHANGE_NORMAL,
	SET_MIASMA,
	SET_HUM,
	SET_RUST,
	ENERGY_BLAST,
	BESTOW_MINDSET,
	SHIFT_MINDSET,
	COPY_MINDSET,
	RESTORE_MP,
	RESTORE_HP,
	DEPLETE_MP,
	DEPLETE_HP,
	DEPLETE_HP_NONLETHAL,
	SET_BOUND,
	SET_HEXED,
	REMOVE_BOUND,
	REMOVE_HEXED,
	CLEAR_MIASMA,
	CLEAR_HUM,
	CLEAR_RUST,
	CLEAR_MINDSET,
	FULLY_RESTORE_HP,
	FULLY_RESTORE_MP,
	GRID_ADD_SKYDIVE,
	GRID_ADD_SNEAK_ATTACK,
	GRID_ADD_TIMED_BLAST,
	CLEAR_TEAM_HINDRANCES,
	CLEAR_ALL_HINDRANCES,
	BLAST_TIMER_GO_OFF,
	BLAST_TIMERS_DECREMENT_COUNT,
	APPLY_MIASMA,
	APPLY_HUM,
	APPLY_RUST,
	FORCE_SWAP,
	FORCE_SWAP_TEAM,
	FORCE_SWAP_GLOBAL,
	SET_MIASMA_GLOBAL,
	SET_HUM_GLOBAL,
	SET_RUST_GLOBAL,
	CLEAR_MIASMA_GLOBAL,
	CLEAR_HUM_GLOBAL,
	CLEAR_RUST_GLOBAL,
	CLEAR_MINDSET_NEARBY_ALLIES,
	CLEAR_MINDSET_NEARBY_ENEMIES,
	CLEAR_MINDSET_TEAM,
	CLEAR_MINDSET_GLOBAL,
	BESTOW_MINDSET_NEARBY_ALLIES,
	BESTOW_MINDSET_NEARBY_ENEMIES,
	BESTOW_MINDSET_NEARBY_SPRITES,
	BESTOW_MINDSET_TEAM,
	BESTOW_MINDSET_GLOBAL,
	SHIFT_MINDSET_NEARBY_ALLIES,
	SHIFT_MINDSET_NEARBY_ENEMIES,
	SHIFT_MINDSET_NEARBY_SPRITES,
	SHIFT_MINDSET_TEAM,
	SHIFT_MINDSET_GLOBAL,
	SHIFT_CURSE,
	SHIFT_BLESSING,
	SHIFT_CURSE_NEARBY_ALLIES,
	SHIFT_CURSE_NEARBY_ENEMIES,
	SHIFT_CURSE_NEARBY_SPRITES,
	SHIFT_CURSE_TEAM,
	SHIFT_CURSE_GLOBAL,
	SHIFT_BLESSING_NEARBY_ALLIES,
	SHIFT_BLESSING_NEARBY_ENEMIES,
	SHIFT_BLESSING_NEARBY_SPRITES,
	SHIFT_BLESSING_TEAM,
	SHIFT_BLESSING_GLOBAL,
	SET_HEXED_NEARBY_ALLIES,
	SET_HEXED_NEARBY_ENEMIES,
	SET_HEXED_NEARBY_SPRITES,
	SET_HEXED_TEAM,
	SET_HEXED_GLOBAL,
	SET_BOUND_NEARBY_ALLIES,
	SET_BOUND_NEARBY_ENEMIES,
	SET_BOUND_NEARBY_SPRITES,
	SET_BOUND_TEAM,
	SET_BOUND_GLOBAL,
	APPLY_HEXED,
	APPLY_BOUND,
	ENERGY_BLAST_GLOBAL,
	INCREASE_DAMAGE_NATURAL,
	DECREASE_DAMAGE_NATURAL,
	INCREASE_DAMAGE_MECHANICAL,
	DECREASE_DAMAGE_MECHANICAL,
	INCREASE_DAMAGE_ASTRAL,
	DECREASE_DAMAGE_ASTRAL,
	VOLCANO_WATER_DECREASE_DAMAGE,
	VOLCANO_FIRE_INCREASE_DAMAGE,
	OCEAN_STORM_INCREASE_DAMAGE,
	OCEAN_WATER_INCREASE_DAMAGE,
	STRATOS_EARTH_DECREASE_DAMAGE,
	STRATOS_STORM_INCREASE_DAMAGE,
	FOREST_FIRE_INCREASE_DAMAGE,
	FOREST_EARTH_INCREASE_DAMAGE,
	DESTROY_ARENA,
	DRAIN_HEALTH,
	DRAIN_MAGIC,
	REPLACE_TARGET,
	BALL_LIGHTNING_SET_ACTIVE,
	BALL_LIGHTNING_ABSORB_SPELL,
	BALL_LIGHTNING_APPLY_DAMAGE,
	BLACK_HOLE_SET_ACTIVE,
	BLACK_HOLE_ABSORB_SPELL,
	BLACK_HOLE_APPLY_DAMAGE,
	APPLY_SELF_DAMAGE,
	SET_BERSERK,
	SET_BERSERK_NEARBY_ALLIES,
	SET_BERSERK_NEARBY_ENEMIES,
	SET_BERSERK_NEARBY_SPRITES,
	SET_BERSERK_TEAM,
	SET_BERSERK_GLOBAL,
	SET_INVULNERABLE,
	SET_INVULNERABLE_NEARBY_ALLIES,
	SET_INVULNERABLE_NEARBY_ENEMIES,
	SET_INVULNERABLE_NEARBY_SPRITES,
	SET_INVULNERABLE_TEAM,
	SET_INVULNERABLE_GLOBAL,
	SKYDIVE_AVOID_DAMAGE,
	INVULNERABLE_AVOID_DAMAGE,
	SET_PARRYING,
	APPLY_PARRY,
	SET_DIVIDING,
	SET_MULTIPLYING,
	DIVIDE_HEALING,
	DIVIDE_DAMAGE,
	MULTIPLY_HEALING,
	MULTIPLY_DAMAGE,
	SET_DEFLECTIVE,
	DEFLECT_SPELL,
	FORCE_TURN_END,
	REPEAT_LAST_TURN,
	PSYCHIC_ATTACK,
	CHANGE_ALIGNMENT,
	CHANGE_SIZE,
	ENERGY_BLAST_SELF,
	FORCE_BEST_LUCK,
	FORCE_WORST_LUCK,
	FORCE_BEST_LUCK_TEAM,
	FORCE_WORST_LUCK_TEAM,
	FORCE_BEST_LUCK_GLOBAL,
	FORCE_WORST_LUCK_GLOBAL,
	SET_HAIL_MARY,
	BERSERK_IGNORE_HEXED,
	BERSERK_IGNORE_BOUND,
	INVULNERABLE_IGNORE_STATUS,
	BERSERK_INCREASE_DAMAGE,
	END_BERSERK,
	END_BERSERK_NEARBY_ALLIES,
	END_BERSERK_NEARBY_ENEMIES,
	END_BERSERK_NEARBY_SPRITES,
	END_BERSERK_TEAM,
	END_BERSERK_GLOBAL,
	END_INVULNERABLE,
	END_INVULNERABLE_NEARBY_ALLIES,
	END_INVULNERABLE_NEARBY_ENEMIES,
	END_INVULNERABLE_NEARBY_SPRITES,
	END_INVULNERABLE_TEAM,
	END_INVULNERABLE_GLOBAL,
	HEIGHT
}

// enum that contains all spar effect params
enum SPAR_EFFECT_PARAMS {
	ID,
	ALERT_TEXT,
	EFFECT_FUNCTION,
	ANIMATION,
	HEIGHT
}

///@desc SPAR EFFECT: sets the current ARENA to VOLCANO
function arena_change_volcano() {
	if (spar.currentArena != arenas.volcano) {
		spar.currentArena = arenas.volcano;
	}	else	instance_destroy(id);
}

///@desc SPAR EFFECT: sets the current ARENA to OCEAN
function arena_change_ocean() {
	if (spar.currentArena != arenas.ocean) {
		spar.currentArena = arenas.ocean;
	}	else	instance_destroy(id);
}

///@desc SPAR EFFECT: sets the current ARENA to STRATOS
function arena_change_stratos() {
	if (spar.currentArena != arenas.stratosphere) {
		spar.currentArena = arenas.stratosphere;
	}	else	instance_destroy(id);
}

///@desc SPAR EFFECT: sets the current ARENA to FOREST
function arena_change_forest() {
	if (spar.currentArena != arenas.forest) {
		spar.currentArena = arenas.forest;
	}	else	instance_destroy(id);
}

///@desc SPAR EFFECT: sets the current ARENA to NORMAL
function arena_change_normal() {
	if (spar.currentArena != -1) {
		spar.currentArena = -1;
	}	else	instance_destroy(id);
}

///@desc SPAR EFFECT: sets MIASMA to true for targetPlayer
function set_miasma(_targetPlayer) {	
	var t = _targetPlayer;
	
	if !(t.miasma) {
		t.miasma = true;
	}	else	instance_destroy(id);
}

///@desc SPAR EFFECT: sets HUM to true for targetPlayer
function set_hum(_targetPlayer) {
	var t = _targetPlayer;
	
	if !(t.hum) {
		t.hum = true;
	}	else	instance_destroy(id);
}

///@desc SPAR EFFECT: sets RUST to true for targetPlayer
function set_rust(_targetPlayer) {
	var t = _targetPlayer;
	
	if !(t.rust) {
		t.rust = true;
	}	else	instance_destroy(id);
}

///@desc SPAR EFFECT: applies damage from an ENERGY BLAST to targetPlayer
function energy_blast(_targetPlayer, _damage) {
	var t = _targetPlayer;
	var d = _damage;
	
	t.currentHP -= d;
}

///@desc SPAR EFFECT: bestows the given MINDSET to the given target sprite
function bestow_mindset(_target, _mindset) {
	var t = _target;
	var m = _mindset;
	
	if (t.mindset != m) {
		t.mindset = m;
	}	else	instance_destroy(id);
}

///@desc SPAR EFFECT: shifts the target's MINDSET from BLESSING to CURSE or vice versa
function shift_mindset(_target) {
	var t = _target;

	if (t.mindset != 0) {
		t.mindset = t.mindset * -1;	
	}	else	instance_destroy(id);
}

///@desc SPAR EFFECT: the caster copies the target's MINDSET
function copy_mindset(_caster, _target) {
	var c = _caster;
	var t = _target;
	
	if (t.mindset != 0) {
		c.mindset = t.mindset;
	}	else	instance_destroy(id);
}

///@desc SPAR EFFECT: the targetPlayer restores the given amount of MP
function restore_mp(_targetPlayer, _amount) {
	var t = _targetPlayer;
	var a = round(_amount);
	
	var mpNeeded = MAX_MP - t.currentMP;
	
	if (a >= mpNeeded)	t.currentMP = MAX_MP;
	else				t.currentMP += a;
}

///@desc SPAR EFFECT: the targetPlayer restores the given amount of HP
function restore_hp(_targetPlayer, _amount) {
	var t = _targetPlayer;
	var a = round(_amount);
	
	var hpNeeded = MAX_HP - t.currentHP;
	
	if (a >= hpNeeded)	t.currentHP = MAX_HP;
	else				t.currentHP += a;
}

///@desc SPAR EFFECT: the targetPlayer loses the given amount of HP
function deplete_hp(_targetPlayer, _amount) {
	var t = _targetPlayer;
	var a = round(_amount);
	
	var hpLeft = t.currentHP;
	
	if (a >= hpLeft)	t.currentHP = 0;
	else				t.currentHP -= a;
}

///@desc SPAR EFFECT: the targetPlayer loses the given amount of MP
function deplete_mp(_targetPlayer, _amount) {
	var t = _targetPlayer;
	var a = round(_amount);
	
	var mpLeft = t.currentMP;
	
	if (a >= mpLeft)	return -1;
	else				t.currentMP -= a;
}

///@desc SPAR EFFECT: the targetPlayer loses the given amount of HP or
/// the most it can give while still having 1 HP left
function deplete_hp_nonlethal(_targetPlayer, _amount) {
	var t = _targetPlayer;
	var a = round(_amount);
	
	var hpLeft = t.currentHP;
	
	if (a >= hpLeft)	t.currentHP = 1;
	else				t.currentHP -= a;
}

///@desc SPAR EFFECT: sets BOUND to true for the target sprite
function set_bound(_target) {
	var t = _target;
	if !(t.bound) {
		if (t.invulnerable)		spar_effect_push_alert(SPAR_EFFECTS.INVULNERABLE_IGNORE_STATUS);
		else					t.bound = true;
		
	}	else	instance_destroy(id);
}

///@desc SPAR EFFECT: sets HEXED to true for the target sprite
function set_hexed(_target) {
	var t = _target;
	
	if !(t.hexed) {
		if (t.invulnerable)		spar_effect_push_alert(SPAR_EFFECTS.INVULNERABLE_IGNORE_STATUS);
		else					t.hexed = true;
		
	}	else	instance_destroy(id);
}

///@desc SPAR EFFECT: sets BOUND to false for the target sprite
function remove_bound(_target) {
	var t = _target;
	
	if (t.bound) {
		t.bound = false;
	}	else	instance_destroy(id);
}

///@desc SPAR EFFECT: sets HEXED to false for the target sprite
function remove_hexed(_target) {
	var t = _target;
	
	if (t.hexed) {
		t.hexed  = false;
	}	else	instance_destroy(id);
}

///@desc SPAR EFFECT: sets MIASMA to false for the targetPlayer
function clear_miasma(_targetPlayer) {
	var t = _targetPlayer;
	
	if (t.miasma) {
		t.miasma = false;
	}	else	instance_destroy(id);
}

///@desc SPAR EFFECT: sets HUM to false for the targetPlayer
function clear_hum(_targetPlayer) {
	var t = _targetPlayer;
	
	if (t.hum) {
		t.hum = false;
	}	else	instance_destroy(id);
}

///@desc SPAR EFFECT: sets RUST to false for the targetPlayer
function clear_rust(_targetPlayer) {
	var t = _targetPlayer;
	
	if (t.rust) {
		t.rust = false;
	}	else	instance_destroy(id);
}

///@desc SPAR EFFECT: removes the MINDSET of the target by setting it to 0
function clear_mindset(_target) {
	var t = _target;
	
	if (t.mindset != 0) {
		t.mindset = 0;
	}	else	instance_destroy(id);
}
	
///@desc SPAR EFFECT: fully restores targetPlayer's HP
function fully_restore_hp(_targetPlayer) {
	var t = _targetPlayer;
	
	if (t.currentHP != MAX_HP) {
		t.currentHP = MAX_HP;
	}	else	instance_destroy(id);
}

///@desc SPAR EFFECT: fully restores targetPlayer's MP
function fully_restore_mp(_targetPlayer) {
	var t = _targetPlayer;
	
	if (t.currentMP != MAX_MP) {
		t.currentMP = MAX_MP;
	}	else	instance_destroy(id);
}
	
///@desc SPAR EFFECT: adds a new SKYDIVE to the grid
function grid_add_skydive(_caster, _target) {
	var c = _caster;
	var t = _target;
	
	c.invulnerable = true;
	
	// resize grid
	ds_grid_resize(spar.skydiveGrid, 2, spar.skydiveCount + 1);
	
	// add values
	spar.skydiveGrid[# 0, spar.skydiveCount]	= c;
	spar.skydiveGrid[# 1, spar.skydiveCount]	= t;
	
	// increment skydive count
	spar.skydiveCount++;
}
	
///@desc SPAR EFFECT: adds a new SNEAK ATTACK to the grid
function grid_add_sneak_attack(_caster, _target) {
	var c = _caster;
	
	// set dodging to true
	c.dodging = true;
	
	// set sneaking to true
	c.sneaking = true;
	
	// get target
	var t = _target;
	
	// resize grid
	ds_grid_resize(spar.sneakAttackGrid, 2, spar.sneakAttackCount + 1);
	
	// add values
	spar.sneakAttackGrid[# 0, spar.sneakAttackCount]	= c;
	spar.sneakAttackGrid[# 0, spar.sneakAttackCount]	= t;
	
	// increment sneak attack count
	spar.sneakAttackCount++;
}
	
///@desc SPAR EFFECT: adds a new TIMED BLAST to the grid
function grid_add_timed_blast(_counter, _power, _targetPlayer) {
	// store all arguments in local variables
	var c = _counter;
	var p = _power;
	var t = _targetPlayer;
	
	// add the params of the blast to the blast grid
	var count = spar.blastCount;
	
	spar.timedBlasts[# 0, count] = c;
	spar.timedBlasts[# 1, count] = p;
	spar.timedBlasts[# 2, count] = t;
	
	// increment the blast count
	spar.blastCount++;	
}	

///@desc SPAR EFFECT: clears all hindrances on the given team's
/// side of the field
function clear_team_hindrances(_team) {
	var t = _team;
	
	if (t.miasma)
	|| (t.hum)
	|| (t.rust) {
		t.miasma = false;
		t.hum = false;
		t.rust = false;
	}	else	instance_destroy(id);
}

///@desc SPAR EFFECT: clears all hindrances on both sides of the field
function clear_all_hindrances() {
	var t1 = spar.playerOne;
	var t2 = spar.playerTwo;
	
	if ((t1.miasma + t1.hum + t1.rust + t2.miasma + t2.hum + t2.rust) > 0) {
		t1.miasma = false;
		t1.hum = false;
		t1.rust = false;
		
		t2.miasma = false;
		t2.hum = false;
		t2.rust = false;
	}	else	instance_destroy(id);
}

///@desc SPAR EFFECT: triggers a TIMED BLAST whose timer is up
function blast_timer_go_off(_blastNum) {
	var n = _blastNum;
	
	// get all blast params
	var c = spar.timedBlasts[# 0, n];
	var p = spar.timedBlasts[# 1, n];
	var t = spar.timedBlasts[# 2, n];
	
	// create the energy blast
	spar_effect_push_alert(SPAR_EFFECTS.ENERGY_BLAST, t, p);
	
	// decrement the blastCount
	spar.blastCount--;
	
	// check if this is the last entry
	if (n != ds_grid_height(spar.timedBlasts)) {
		var i = 1;	repeat (ds_grid_height(spar.timedBlasts) - n) {
			spar.timedBlasts[# 0, n] =	spar.timedBlasts[# 0, n + i];
			spar.timedBlasts[# 1, n] =	spar.timedBlasts[# 1, n + i];
			spar.timedBlasts[# 2, n] =	spar.timedBlasts[# 2, n + i];
			
			i++;
		}
	}
	
	// resize the timedBlast grid
	ds_grid_resize(spar.timedBlasts, 3, spar.blastCount);
}

///@desc SPAR EFFECT: drops the counter for each blast timer down one tick
function blast_timers_decrement_count() {
	var i = 0;	repeat (spar.blastCount) {
		spar.timedBlasts[# 0, i] -= 1;
		
		i++;
	}
}

///@desc SPAR EFFECT: applies the damage from MIASMA
function apply_miasma(_effectedTeam) {
	var t = _effectedTeam;
	var d = 0;
	
	// check for natural sprites to increase damage
	// and add to effectedSprites list
	var i = 0;	repeat (4) {
		if (t[| i].currentAlign == ALIGNMENTS.NATURAL) {
			effectedSprites += t[| i];
			
			d += 125;
		}
		
		i++;
	}
	
	// check that damage was increased at least once before applying
	if (d > 0) {
		spar_effect_push_alert(SPAR_EFFECTS.DEPLETE_HP, t, d);
	}	else	instance_destroy(id);
}

///@desc SPAR EFFECT: applies negation of ELEMENTAL damage from HUM
function apply_hum(_activeSprite) {
	// damage cannot be edited by any of these functions. There will be a check
	// before damage is applied, and that check will call this function as a means
	// of notifying the player after the fact
}

///@desc SPAR EFFECT: applies increase of PHYSICAL damage from RUST
function apply_rust(_targetSprite) {
	// damage cannot be edited by any of these functions. There will be a check
	// before damage is applied, and that check will call this function as a means
	// of notifying the player after the fact
}
	
///@desc SPAR EFFECT: forces the target to swap with a randomly chosen ally
function force_swap(_targetSprite) {
	randomize();
	
	// get target's spot number
	var t = _targetSprite;
	var tsn = t.spotNum;
	
	// get target team
	var tt = t.team;
	
	// create temp list
	var l = ds_list_create();
	
	// build a list of numbers representing viable swap partners
	var i = 0;	repeat (4) {
		// if i doesn't equal target spot num, add it to the list
		if (i != tsn)	ds_list_add(l, i);
		
		i++;
	}
	
	// pick a random number off of that list and set it as the
	// partner's spot number
	var int = irandom_range(0, 3);
	var psn = l[| int];
	
	// create inst list
	var il = ds_list_create();
	
	// copy appropriate list
	if (tt == spar.playerOne)	ds_list_copy(il, spar.allyList);
	if (tt == spar.playerTwo)	ds_list_copy(il, spar.enemyList);
	
	// store swap partner's sprite ID
	var psid	= il[| psn].spriteID;
	
	// store target's sprite ID
	var tsid	= il[| tsn].spriteID;
	
	// swap sprite IDs
	
	var temp	= psid;
	psid		= tsid;
	tsid		= temp;
	
	// delete lists
	ds_list_destroy(l);
	ds_list_destroy(il);
}

///@desc SPAR EFFECT: forces the target team to split into two groups randomly
/// and perform swaps
function force_swap_team(_targetPlayer) {
	randomize();
		
	// get target's spot number
	var ct = _targetPlayer;
	
	// create a dummy list
	var iil = ds_list_create();
	
	// find out which list to copy
	if (ct == spar.playerOne)	ds_list_copy(iil, spar.enemyList);
	if (ct == spar.playerTwo)	ds_list_copy(iil, spar.allyList);
	
	// get a random integer
	var int = irandom_range(0, 3);
	
	// set target as the list token at the index of the random integer
	var t	= iil[| int];
	var tsn = t.spotNum;
	
	// get target team
	var tt = t.team;
	
	// create temp list
	var l = ds_list_create();
	
	// build a list of numbers representing viable swap partners
	var i = 0;	repeat (4) {
		// if i doesn't equal target spot num, add it to the list
		if (i != tsn)	ds_list_add(l, i);
		
		i++;
	}
	
	// pick a random number off of that list and set it as the
	// partner's spot number
	var int = irandom_range(0, 3);
	var psn = l[| int];
	
	// create inst list
	var il = ds_list_create();
	
	// copy appropriate list
	if (tt == spar.playerOne)	ds_list_copy(il, spar.allyList);
	if (tt == spar.playerTwo)	ds_list_copy(il, spar.enemyList);
	
	// store swap partner's sprite ID
	var psid	= il[| psn].spriteID;
	
	// store target's sprite ID
	var tsid	= il[| tsn].spriteID;
	
	// swap sprite IDs
	il[| psn].spriteID = tsid;
	il[| tsn].spriteID = psid;
	
	// delete lists
	ds_list_destroy(l);
	ds_list_destroy(il);

}

///@desc SPAR EFFECT: forces both teams to perform swaps with all their sprites
function force_swap_global() {
	var ct = -1;
	
	var i = 0;	repeat (2) {
		// reset random seed
		randomize();
		
		if (i)	ct = spar.playerOne;
		if !(i)	ct = spar.playerTwo;
		
		// create a dummy list
		var iil = ds_list_create();
		
		// find out which list to copy
		if (ct == spar.playerOne)	ds_list_copy(iil, spar.enemyList);
		if (ct == spar.playerTwo)	ds_list_copy(iil, spar.allyList);
		
		// get a random integer
		var int = irandom_range(0, 3);
		
		// set target as the list token at the index of the random integer
		var t	= iil[| int];
		var tsn = t.spotNum;
		
		// get target team
		var tt = t.team;
		
		// create temp list
		var l = ds_list_create();
		
		// build a list of numbers representing viable swap partners
		var j = 0;	repeat (4) {
			// if i doesn't equal target spot num, add it to the list
			if (j != tsn)	ds_list_add(l, j);
			
			j++;
		}
		
		// pick a random number off of that list and set it as the
		// partner's spot number
		var int = irandom_range(0, 3);
		var psn = l[| int];
		
		// create inst list
		var il = ds_list_create();
		
		// copy appropriate list
		if (tt == spar.playerOne)	ds_list_copy(il, spar.allyList);
		if (tt == spar.playerTwo)	ds_list_copy(il, spar.enemyList);
		
		// store swap partner's sprite ID
		var psid	= il[| psn].spriteID;
		
		// store target's sprite ID
		var tsid	= il[| tsn].spriteID;
		
		// swap sprite IDs
		il[| psn].spriteID = tsid;
		il[| tsn].spriteID = psid;
		
		// delete lists
		ds_list_destroy(l);
		ds_list_destroy(il);
		
		// increment i
		i++;
	}
}

///@desc SPAR EFFECT: sets MIASMA on both sides of the field
function set_miasma_global() {
	if !(spar.playerOne.miasma)
	|| !(spar.playerTwo.miasma) {
		spar.playerOne.miasma = true;
		spar.playerTwo.miasma = true;
	}	else	instance_destroy(id);
}

///@desc SPAR EFFECT: sets HUM on both sides of the field
function set_hum_global() {
	if !(spar.playerOne.hum)
	|| !(spar.playerTwo.hum) {
		spar.playerOne.hum = true;
		spar.playerTwo.hum = true;
	}	else	instance_destroy(id);
}

///@desc SPAR EFFECT: sets RUST on both sides of the field
function set_rust_global() {
	if !(spar.playerOne.rust)
	|| !(spar.playerTwo.rust) {
		spar.playerOne.rust = true;
		spar.playerTwo.rust = true;
	}	else	instance_destroy(id);
}

///@desc SPAR EFFECT: clears MIASMA from both sides of the field
function clear_miasma_global() {
	if (spar.playerOne.miasma) 
	|| (spar.playerTwo.miasma) {
		spar.playerOne.miasma = false;
		spar.playerTwo.miasma = false;
	}	else	instance_destroy(id);
}

///@desc SPAR EFFECT: clears HUM from both sides of the field
function clear_hum_global() {
	if (spar.playerOne.hum) 
	|| (spar.playerTwo.hum) {
		spar.playerOne.hum = false;
		spar.playerTwo.hum = false;
	}
}

///@desc SPAR EFFECT: clears rust from both sides of the field
function clear_rust_global() {
	if (spar.playerOne.rust) 
	|| (spar.playerTwo.rust) {
		spar.playerOne.rust = false;
		spar.playerTwo.rust = false;
	}	else	instance_destroy(id);
}

///@desc SPAR EFFECT: clears the MINDSET of any nearby allies
function clear_mindset_nearby_allies(_target) {
	// store args in locals
	var t = _target;
	
	// use a repeat loop to check if any nearbySprites need to have
	// their mindset cleared
	var i = 0;	repeat (ds_list_size(t.nearbyAllies)) {
		var inst = t.nearbyAllies[| i];
		
		if (inst.mindset != 0) {
			ds_list_add(effectedSprites, inst);
			inst.mindset = 0;
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: clears the MINDSET of any nearby enemies
function clear_mindset_nearby_enemies(_target) {
	// store args in locals
	var t = _target;
	
	// use a repeat loop to check if any nearbySprites need to have
	// their mindset cleared
	var i = 0;	repeat (ds_list_size(t.nearbyEnemies)) {
		var inst = t.nearbyEnemies[| i];
		
		if (inst.mindset != 0) {
			ds_list_add(effectedSprites, inst);
			inst.mindset = 0;
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: clears the MINDSET of any nearby sprites
function clear_mindset_nearby_sprites(_target) {
	// store args in locals
	var t = _target;
	
	// use a repeat loop to check if any nearbySprites need to have
	// their mindset cleared
	var i = 0;	repeat (ds_list_size(t.nearbySprites)) {
		var inst = t.nearbySprites[| i];
		
		if (inst.mindset != 0) {
			ds_list_add(effectedSprites, inst);
			inst.mindset = 0;
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: clears the MINDSET of all sprites on the target team
function clear_mindset_team(_targetPlayer) {
	// store args in locals
	var t = _targetPlayer;
	
	// get the correct list based on the target player
	if (t == spar.playerOne)	var list = spar.allyList;
	if (t == spar.playerTwo)	var list = spar.enemyList;
	
	// use a repeat loop to check if any nearbySprites need to have
	// their mindset cleared
	var i = 0;	repeat (ds_list_size(list)) {
		var inst = list[| i];
		
		if (inst.mindset != 0) {
			ds_list_add(effectedSprites, inst);
			inst.mindset = 0;
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: clears the MINDSET of all sprites on the field
function clear_mindset_global() {
	var i = 0;	repeat (2) {
		
		// get the correct list based on the target player
		if (i)	var list = spar.allyList;
		if !(i)	var list = spar.enemyList;
		
		// use a repeat loop to check if any nearbySprites need to have
		// their mindset cleared
		var j = 0;	repeat (ds_list_size(list)) {
			var inst = list[| j];
			
			if (inst.mindset != 0) {
				ds_list_add(effectedSprites, inst);
				inst.mindset = 0;
			}
			
			j++;
		}	
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: grants a MINDSET to all allies near the target
function bestow_mindset_nearby_allies(_target, _mindset) {
	// store args in locals
	var t = _target;
	var m = _mindset;
	
	// use a repeat loop to check if any nearbySprites need to have
	// their mindset cleared
	var i = 0;	repeat (ds_list_size(t.nearbyAllies)) {
		var inst = t.nearbyAllies[| i];
		
		if (inst.mindset != m) {
			ds_list_add(effectedSprites, inst);
			inst.mindset = m;
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: grants a MINDSET to all enemies near the target
function bestow_mindset_nearby_enemies(_target, _mindset) {
	// store args in locals
	var t = _target;
	var m = _mindset;
	
	// use a repeat loop to check if any nearbySprites need to have
	// their mindset cleared
	var i = 0;	repeat (ds_list_size(t.nearbyEnemies)) {
		var inst = t.nearbyEnemies[| i];
		
		if (inst.mindset != m) {
			ds_list_add(effectedSprites, inst);
			inst.mindset = m;
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: grants a MINDSET to all sprites near the target
function bestow_mindset_nearby_sprites(_target, _mindset) {
	// store args in locals
	var t = _target;
	var m = _mindset;
	
	// use a repeat loop to check if any nearbySprites need to have
	// their mindset cleared
	var i = 0;	repeat (ds_list_size(t.nearbySprites)) {
		var inst = t.nearbySprites[| i];
		
		if (inst.mindset != m) {
			ds_list_add(effectedSprites, inst);
			inst.mindset = m;
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: grants a MINDSET to all members of the given team
function bestow_mindset_team(_targetPlayer, _mindset) {	
	// store arguments in local variables
	var t = _targetPlayer;
	var m = _mindset;
	
	// get the correct list based on the target player
	if (t == spar.playerOne)	var list = spar.allyList;
	if (t == spar.playerTwo)	var list = spar.enemyList;	
	
	// use a repeat loop to grant curse of the warrior to
	// all sprites on the list
	var i = 0;	repeat (ds_list_size(list)) {
		var inst = list[| i];
		
		if (inst.mindset != m) {
			ds_list_add(effectedSprites, inst);
			inst.mindset = m;
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: grants a MINDSET to all sprites on the field
function bestow_mindset_global(_mindset) {
	var m = _mindset;
	
	var i = 0;	repeat (2) {
	
		// get the correct list based on i
		if (i)	var list = spar.allyList;
		if !(i)	var list = spar.enemyList;
		
		// use a repeat loop to grant curse of the warrior to
		// all sprites on the list
		var j = 0;	repeat (ds_list_size(list)) {
			var inst = list[| j];
			
			if (inst.mindset != m) {
				ds_list_add(effectedSprites, inst);
				inst.mindset = m;
			}
			
			j++;
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: shifts the MINDSET of all target's nearby allies
function shift_mindset_nearby_allies(_target) {
	// store args in locals
	var t = _target;
	
	// use a repeat loop to check if any nearbySprites need to have
	// their mindset cleared
	var i = 0;	repeat (ds_list_size(t.nearbyAllies)) {
		var inst = t.nearbyAllies[| i];
		
		if (inst.mindset != 0) {
			ds_list_add(effectedSprites, inst);
			inst.mindset = inst.mindset * -1;
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: shifts the MINDSET of all target's nearby enemies
function shift_mindset_nearby_enemies(_target) {
	// store args in locals
	var t = _target;
	
	// use a repeat loop to check if any nearbySprites need to have
	// their mindset cleared
	var i = 0;	repeat (ds_list_size(t.nearbyEnemies)) {
		var inst = t.nearbyEnemies[| i];
		
		if (inst.mindset != 0) {
			ds_list_add(effectedSprites, inst);
			inst.mindset = inst.mindset * -1;
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: shifts the MINDSET of all target's nearby sprites
function shift_mindset_nearby_sprites(_target) {
	// store args in locals
	var t = _target;
	
	// use a repeat loop to check if any nearbySprites need to have
	// their mindset cleared
	var i = 0;	repeat (ds_list_size(t.nearbySprites)) {
		var inst = t.nearbySprites[| i];
		
		if (inst.mindset != 0) {
			ds_list_add(effectedSprites, inst);
			inst.mindset = inst.mindset * -1;
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: shifts the MINDSET of all sprites on the target team
function shift_mindset_team(_targetPlayer) {
	// store arguments in local variables
	var t = _targetPlayer;
	
	// get the correct list based on the target player
	if (t == spar.playerOne)	var list = spar.allyList;
	if (t == spar.playerTwo)	var list = spar.enemyList;	
	
	// use a repeat loop to grant curse of the warrior to
	// all sprites on the list
	var i = 0;	repeat (ds_list_size(list)) {
		var inst = list[| i];
		
		if (inst.mindset != 0) {
			ds_list_add(effectedSprites, inst);
			inst.mindset = inst.mindset * -1;
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: shifts the MINDSET of all sprites on the field
function shift_mindset_global() {	
	var i = 0;	repeat (2) {
		
		// get the correct list based on the target player
		if (i)	var list = spar.allyList;
		if !(i)	var list = spar.enemyList;
		
		// use a repeat loop to check if any nearbySprites need to have
		// their mindset cleared
		var j = 0;	repeat (ds_list_size(list)) {
			var inst = list[| j];
			
			if (inst.mindset != 0) {
				ds_list_add(effectedSprites, inst);
				inst.mindset = inst.mindset * -1;
			}
			
			j++;
		}	
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: shifts CURSE to BLESSING for target
function shift_curse(_target) {
	var t = _target;
	
	if (t.mindset < 0) {
		t.mindset = t.mindset * -1;
	}	else	instance_destroy(id);
}

///@desc SPAR EFFECT: shifts BLESSING to CURSE for target
function shift_blessing(_target) {
	var t = _target;
	
	if (t.mindset > 0) {
		t.mindset = t.mindset * -1;	
	}	else	instance_destroy(id);
}

///@desc SPAR EFFECT: shifts CURSE to BLESSING for target's nearby allies
function shift_curse_nearby_allies(_target) {
	// store args in locals
	var t = _target;
	
	// use a repeat loop to check if any nearbySprites need to have
	// their mindset cleared
	var i = 0;	repeat (ds_list_size(t.nearbyAllies)) {
		var inst = t.nearbyAllies[| i];
		
		if (inst.mindset < 0) {
			ds_list_add(effectedSprites, inst);
			inst.mindset = inst.mindset * -1;
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: shifts CURSE to BLESSING for target's nearby enemies
function shift_curse_nearby_enemies(_target) {
	// store args in locals
	var t = _target;
	
	// use a repeat loop to check if any nearbySprites need to have
	// their mindset cleared
	var i = 0;	repeat (ds_list_size(t.nearbyEnemies)) {
		var inst = t.nearbyEnemies[| i];
		
		if (inst.mindset < 0) {
			ds_list_add(effectedSprites, inst);
			inst.mindset = inst.mindset * -1;
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: shifts CURSE to BLESSING for target's nearby sprites
function shift_curse_nearby_sprites(_target) {
	// store args in locals
	var t = _target;
	
	// use a repeat loop to check if any nearbySprites need to have
	// their mindset cleared
	var i = 0;	repeat (ds_list_size(t.nearbySprites)) {
		var inst = t.nearbySprites[| i];
		
		if (inst.mindset < 0) {
			ds_list_add(effectedSprites, inst);
			inst.mindset = inst.mindset * -1;
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: shifts CURSE to BLESSING for all sprites on target team
function shift_curse_team(_targetPlayer) {
	// store arguments in local variables
	var t = _targetPlayer;
	
	// get the correct list based on the target player
	if (t == spar.playerOne)	var list = spar.allyList;
	if (t == spar.playerTwo)	var list = spar.enemyList;	
	
	// use a repeat loop to grant curse of the warrior to
	// all sprites on the list
	var i = 0;	repeat (ds_list_size(list)) {
		var inst = list[| i];
		
		if (inst.mindset < 0) {
			ds_list_add(effectedSprites, inst);
			inst.mindset = inst.mindset * -1;
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: shifts CURSE to BLESSING for all sprites on the field
function shift_curse_global() {
	var i = 0;	repeat (2) {
		
		// get the correct list based on the target player
		if (i)	var list = spar.allyList;
		if !(i)	var list = spar.enemyList;
		
		// use a repeat loop to check if any nearbySprites need to have
		// their mindset cleared
		var j = 0;	repeat (ds_list_size(list)) {
			var inst = list[| j];
			
			if (inst.mindset < 0) {
				ds_list_add(effectedSprites, inst);
				inst.mindset = inst.mindset * -1;
			}
			
			j++;
		}	
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}	
}

///@desc SPAR EFFECT: shifts BLESSING to CURSE for target's nearby allies
function shift_blessing_nearby_allies(_target) {
	// store args in locals
	var t = _target;
	
	// use a repeat loop to check if any nearbySprites need to have
	// their mindset cleared
	var i = 0;	repeat (ds_list_size(t.nearbyAllies)) {
		var inst = t.nearbyAllies[| i];
		
		if (inst.mindset > 0) {
			ds_list_add(effectedSprites, inst);
			inst.mindset = inst.mindset * -1;
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: shifts BLESSING to CURSE for target's nearby enemies
function shift_blessing_nearby_enemies(_target) {
	// store args in locals
	var t = _target;
	
	// use a repeat loop to check if any nearbySprites need to have
	// their mindset cleared
	var i = 0;	repeat (ds_list_size(t.nearbyEnemies)) {
		var inst = t.nearbyEnemies[| i];
		
		if (inst.mindset > 0) {
			ds_list_add(effectedSprites, inst);
			inst.mindset = inst.mindset * -1;
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: shifts BLESSING to CURSE for target's nearby sprites
function shift_blessing_nearby_sprites(_target) {
	// store args in locals
	var t = _target;
	
	// use a repeat loop to check if any nearbySprites need to have
	// their mindset cleared
	var i = 0;	repeat (ds_list_size(t.nearbySprites)) {
		var inst = t.nearbySprites[| i];
		
		if (inst.mindset > 0) {
			ds_list_add(effectedSprites, inst);
			inst.mindset = inst.mindset * -1;
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: shifts BLESSING to CURSE for all sprites on target team
function shift_blessing_team(_targetPlayer) {
	// store arguments in local variables
	var t = _targetPlayer;
	
	// get the correct list based on the target player
	if (t == spar.playerOne)	var list = spar.allyList;
	if (t == spar.playerTwo)	var list = spar.enemyList;	
	
	// use a repeat loop to grant curse of the warrior to
	// all sprites on the list
	var i = 0;	repeat (ds_list_size(list)) {
		var inst = list[| i];
		
		if (inst.mindset > 0) {
			ds_list_add(effectedSprites, inst);
			inst.mindset = inst.mindset * -1;
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: shifts BLESSING to CURSE for all sprites on the field
function shift_blessing_global() {
	var i = 0;	repeat (2) {
		
		// get the correct list based on the target player
		if (i)	var list = spar.allyList;
		if !(i)	var list = spar.enemyList;
		
		// use a repeat loop to check if any nearbySprites need to have
		// their mindset cleared
		var j = 0;	repeat (ds_list_size(list)) {
			var inst = list[| j];
			
			if (inst.mindset > 0) {
				ds_list_add(effectedSprites, inst);
				inst.mindset = inst.mindset * -1;
			}
			
			j++;
		}	
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}	
}

///@desc SPAR EFFECT: set HEXED to true for all target's nearby allies
function set_hexed_nearby_allies(_target) {
	// store args in locals
	var t = _target;
	
	// use a repeat loop to check if any nearbySprites need to have
	// their mindset cleared
	var i = 0;	repeat (ds_list_size(t.nearbyAllies)) {
		var inst = t.nearbyAllies[| i];
		
		if !(inst.hexed) {
			if (inst.invulnerable) {
				spar_effect_push_alert(SPAR_EFFECTS.INVULNERABLE_IGNORE_STATUS);
			}	else if (inst.berserk) {
				spar_effect_push_alert(SPAR_EFFECTS.BERSERK_IGNORE_HEXED);
			}	else {
				ds_list_add(effectedSprites, inst);
				inst.hexed = true;
			}
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: set HEXED to true for all target's nearby enemies
function set_hexed_nearby_enemies(_target) {
	// store args in locals
	var t = _target;
	
	// use a repeat loop to check if any nearbySprites need to have
	// their mindset cleared
	var i = 0;	repeat (ds_list_size(t.nearbyEnemies)) {
		var inst = t.nearbyEnemies[| i];
		
		if !(inst.hexed) {
			if (inst.invulnerable) {
				spar_effect_push_alert(SPAR_EFFECTS.INVULNERABLE_IGNORE_STATUS);
			}	else if (inst.berserk) {
				spar_effect_push_alert(SPAR_EFFECTS.BERSERK_IGNORE_HEXED);
			}	else {
				ds_list_add(effectedSprites, inst);
				inst.hexed = true;
			}
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: set HEXED to true for all target's nearby sprites
function set_hexed_nearby_sprites(_target) {
	// store args in locals
	var t = _target;
	
	// use a repeat loop to check if any nearbySprites need to have
	// their mindset cleared
	var i = 0;	repeat (ds_list_size(t.nearbySprites)) {
		var inst = t.nearbySprites[| i];
		
		if !(inst.hexed) {
			if (inst.invulnerable) {
				spar_effect_push_alert(SPAR_EFFECTS.INVULNERABLE_IGNORE_STATUS);
			}	else if (inst.berserk) {
				spar_effect_push_alert(SPAR_EFFECTS.BERSERK_IGNORE_HEXED);
			}	else {
				ds_list_add(effectedSprites, inst);
				inst.hexed = true;
			}
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: set HEXED to true for all sprites on target team
function set_hexed_team(_targetPlayer) {
	// store arguments in local variables
	var t = _targetPlayer;
	
	// get the correct list based on the target player
	if (t == spar.playerOne)	var list = spar.allyList;
	if (t == spar.playerTwo)	var list = spar.enemyList;	
	
	// use a repeat loop to check if any nearbySprites need to have
	// their mindset cleared
	var i = 0;	repeat (ds_list_size(list)) {
		var inst = list[| i];
		
		if !(inst.hexed) {
			if (inst.invulnerable) {
				spar_effect_push_alert(SPAR_EFFECTS.INVULNERABLE_IGNORE_STATUS);
			}	else if (inst.berserk) {
				spar_effect_push_alert(SPAR_EFFECTS.BERSERK_IGNORE_HEXED);
			}	else {
				ds_list_add(effectedSprites, inst);
				inst.hexed = true;
			}
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: set HEXED to true for all sprites on the field
function set_hexed_global() {
	var i = 0;	repeat (2) {
		
		// get the correct list based on the target player
		if (i)	var list = spar.allyList;
		if !(i)	var list = spar.enemyList;
		
		// use a repeat loop to check if any nearbySprites need to have
		// their mindset cleared
		var j = 0;	repeat (ds_list_size(list)) {
			var inst = list[| j];
			
			if !(inst.hexed) {
				if (inst.invulnerable) {
					spar_effect_push_alert(SPAR_EFFECTS.INVULNERABLE_IGNORE_STATUS);
				}	else if (inst.berserk) {
					spar_effect_push_alert(SPAR_EFFECTS.BERSERK_IGNORE_HEXED);
				}	else {
					ds_list_add(effectedSprites, inst);
					inst.hexed = true;
				}
			}
			j++;
		}
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}	
}

///@desc SPAR EFFECT: set BOUND to true for all target's nearby allies
function set_bound_nearby_allies(_target) {
	// store args in locals
	var t = _target;
	
	// use a repeat loop to check if any nearbySprites need to have
	// their mindset cleared
	var i = 0;	repeat (ds_list_size(t.nearbyAllies[|i])) {
		var inst = t.nearbyAllies[| i];
		
		if !(inst.bound) {
			if (inst.invulnerable) {
				spar_effect_push_alert(SPAR_EFFECTS.INVULNERABLE_IGNORE_STATUS);
			}	else if (inst.berserk) {
				spar_effect_push_alert(SPAR_EFFECTS.BERSERK_IGNORE_BOUND);
			}	else {
				ds_list_add(effectedSprites, inst);
				inst.bound = true;
			}
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: set BOUND to true for all target's nearby enemies
function set_bound_nearby_enemies(_target) {
	// store args in locals
	var t = _target;
	
	// use a repeat loop to check if any nearbySprites need to have
	// their mindset cleared
	var i = 0;	repeat (ds_list_size(t.nearbyEnemies[|i])) {
		var inst = t.nearbyEnemies[| i];
		
		if !(inst.bound) {
			if (inst.invulnerable) {
				spar_effect_push_alert(SPAR_EFFECTS.INVULNERABLE_IGNORE_STATUS);
			}	else if (inst.berserk) {
				spar_effect_push_alert(SPAR_EFFECTS.BERSERK_IGNORE_BOUND);
			}	else {
				ds_list_add(effectedSprites, inst);
				inst.bound = true;
			}
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: set BOUND to true for all target's nearby sprites
function set_bound_nearby_sprites(_target) {
	// store args in locals
	var t = _target;
	
	// use a repeat loop to check if any nearbySprites need to have
	// their mindset cleared
	var i = 0;	repeat (ds_list_size(t.nearbySprites[|i])) {
		var inst = t.nearbySprites[| i];
		
		if !(inst.bound) {
			if (inst.invulnerable) {
				spar_effect_push_alert(SPAR_EFFECTS.INVULNERABLE_IGNORE_STATUS);
			}	else if (inst.berserk) {
				spar_effect_push_alert(SPAR_EFFECTS.BERSERK_IGNORE_BOUND);
			}	else {
				ds_list_add(effectedSprites, inst);
				inst.bound = true;
			}
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: set BOUND to true for all sprites on target team
function set_bound_team(_targetPlayer) {
	// store arguments in local variables
	var t = _targetPlayer;
	
	// get the correct list based on the target player
	if (t == spar.playerOne)	var list = spar.allyList;
	if (t == spar.playerTwo)	var list = spar.enemyList;	
	
	// use a repeat loop to check if any nearbySprites need to have
	// their mindset cleared
	var i = 0;	repeat (ds_list_size(list[|i])) {
		var inst = list[| i];
		
		if !(inst.bound) {
			if (inst.invulnerable) {
				spar_effect_push_alert(SPAR_EFFECTS.INVULNERABLE_IGNORE_STATUS);
			}	else if (inst.berserk) {
				spar_effect_push_alert(SPAR_EFFECTS.BERSERK_IGNORE_BOUND);
			}	else {
				ds_list_add(effectedSprites, inst);
				inst.bound = true;
			}
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: set BOUND to true for all sprites on the field
function set_bound_global() {
	var i = 0;	repeat (2) {
		
		// get the correct list based on the target player
		if (i)	var list = spar.allyList;
		if !(i)	var list = spar.enemyList;
		
		// use a repeat loop to check if any nearbySprites need to have
		// their mindset cleared
		var j = 0;	repeat (ds_list_size(list[|j])) {
			var inst = list[| j];
			
			if !(inst.bound) {
				if (inst.invulnerable) {
					spar_effect_push_alert(SPAR_EFFECTS.INVULNERABLE_IGNORE_STATUS);
				}	else if (inst.berserk) {
					spar_effect_push_alert(SPAR_EFFECTS.BERSERK_IGNORE_BOUND);
				}	else {
					ds_list_add(effectedSprites, inst);
					inst.bound = true;
				}
			}
			
			j++;
		}	
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}	
}

///@desc SPAR EFFECT: this effect is simply here as a way of notifying the player
/// that they are HEXED and cannot cast spells
function apply_hexed() {
	
}

///@desc SPAR EFFECT: this effect is simply here as a way of notifying the player
/// that they are BOUND and cannot swap
function apply_bound() {
	
}

///@desc SPAR EFFECT: apply damage from an ENERGY BLAST to both players
function energy_blast_global(_damage) {
	var d = _damage;
	
	spar.playerOne.currentHP -= d;
	spar.playerTwo.currentHP -= d;
}

///@desc SPAR EFFECT: this effect is simply here as a way of notifying the player
/// that the damage was altered after the fact
function increase_damage_natural() {
	
}

///@desc SPAR EFFECT: this effect is simply here as a way of notifying the player
/// that the damage was altered after the fact
function decrease_damage_natural() {
	
}

///@desc SPAR EFFECT: this effect is simply here as a way of notifying the player
/// that the damage was altered after the fact
function increase_damage_mechanical() {
	
}

///@desc SPAR EFFECT: this effect is simply here as a way of notifying the player
/// that the damage was altered after the fact
function decrease_damage_mechanical() {
	
}

///@desc SPAR EFFECT: this effect is simply here as a way of notifying the player
/// that the damage was altered after the fact
function increase_damage_astral() {
	
}

///@desc SPAR EFFECT: this effect is simply here as a way of notifying the player
/// that the damage was altered after the fact
function decrease_damage_astral() {
	
}

///@desc SPAR EFFECT: this effect is simply here as a way of notifying the player
/// that the damage was altered after the fact
function volcano_water_decrease_damage() {
	
}

///@desc SPAR EFFECT: this effect is simply here as a way of notifying the player
/// that the damage was altered after the fact
function volcano_fire_increase_damage() {
	
}

///@desc SPAR EFFECT: this effect is simply here as a way of notifying the player
/// that the damage was altered after the fact
function ocean_storm_increase_damage() {
	
}

///@desc SPAR EFFECT: this effect is simply here as a way of notifying the player
/// that the damage was altered after the fact
function ocean_water_increase_damage() {
	
}

///@desc SPAR EFFECT: this effect is simply here as a way of notifying the player
/// that the damage was altered after the fact
function stratos_earth_decrease_damage() {
	
}

///@desc SPAR EFFECT: this effect is simply here as a way of notifying the player
/// that the damage was altered after the fact
function stratos_storm_increase_damage() {
	
}

///@desc SPAR EFFECT: this effect is simply here as a way of notifying the player
/// that the damage was altered after the fact
function forest_fire_increase_damage() {
	
}

///@desc SPAR EFFECT: this effect is simply here as a way of notifying the player
/// that the damage was altered after the fact
function forest_earth_increase_damage() {
	
}

///@desc SPAR EFFECT: change the arena back to normal. This has to exist along with
/// the arena_change_normal effect, because they trigger different effects/abilities
function destroy_arena() {
	if (spar.currentArena != -1) {
		spar.currentArena = -1;	
	}	else	instance_destroy(id);
}

///@desc SPAR EFFECT: this is simply a "restore health" function but the verbiage is
/// different and it triggers different effects/abilities
function drain_health(_receivingTeam, _amount) {
	var t = _receivingTeam;
	var a = _amount;
	
	t.currentHP += a;
}

///@desc SPAR EFFECT: this is simply a "restore magic" function but the verbiage is
/// different and it triggers different effects/abilities
function drain_magic(_receivingTeam, _amount) {
	var t = _receivingTeam;
	var a = _amount;
	
	t.currentMP += a;
}

///@desc SPAR EFFECT: search the target column of the turn grid for the target of this
/// spell. When found, replace the target's ID with the caster's
function replace_target(_caster, _target) {
	var c = _caster;
	var t = _target;
	
	var i = 0;	repeat (ds_grid_height(spar.turnGrid)) {
		var _ID = spar.turnGrid[# selectionPhases.target, i];
		
		if (_ID == t.spotNum) {
			spar.turnGrid[# selectionPhases.target, i] = c.spotNum;	
		}
		
		i++;
	}
}

///@desc SPAR EFFECT: set ballLightningActive to true for the casting sprite
function ball_lightning_set_active(_caster) {
	var c = _caster;
	
	c.ballLightningActive = true;
	c.ballLightningCount = 1;
}

///@desc SPAR EFFECT: increase ballLightningCount for the ball lightning sprite
function ball_lightning_absorb_spell(_blSprite) {
	var c = _blSprite;
	
	c.ballLightningCount += 1;
}

///@desc SPAR EFFECT: apply the damage from the ball lightning
function ball_lightning_apply_damage(_blSprite, _count) {
	var t = _blSprite.enemy;
	var c = _count;
	
	var p = c * 150;
	
	t.currentHP -= p;
}

///@desc SPAR EFFECT: set blackHoleActive to true for the casting sprite
function black_hole_set_active(_caster) {
	var c = _caster;
	
	c.blackHoleActive = true;
	c.blackHoleCount = 1;
}

///@desc SPAR EFFECT: increase blackHoleCount for the black hole sprite
function black_hole_absorb_spell(_bhSprite) {
	var c = _bhSprite;
	
	c.blackHoleCount += 1;
}

///@desc SPAR EFFECT: apply the damage from the black hole
function black_hole_apply_damage(_bhSprite, _count) {
	var t = _bhSprite.enemy;
	var c = _count;
	
	var p = c * 85;
	
	t.currentHP -= p;
}

///@desc SPAR EFFECT: apply recoil damage to the player
function apply_self_damage(_targetPlayer, _amount) {
	var t = _targetPlayer;
	var a = _amount;
	
	t.currentHP -= a;
}

///@desc SPAR EFFECT: set BERSERK to true for the target
function set_berserk(_target) {
	var t = _target;
	
	if !(t.berserk) {
		t.berserk = true;
	}	else	t.berserkCounter = 0;
}

///@desc SPAR EFFECT: set BERSERK to true for all the target's nearby allies
function set_berserk_nearby_allies(_target) {
	// store args in locals
	var t = _target;
	
	// use a repeat loop to check if any nearbySprites need to have
	// their mindset cleared
	var i = 0;	repeat (ds_list_size(t.nearbyAllies)) {
		var inst = t.nearbyAllies[| i];
		
		// check if sprite is invulnerable
		if (inst.invulnerable) {
			// if so, ignore berserk
			spar_effect_push_alert(SPAR_EFFECTS.INVULNERABLE_IGNORE_STATUS);
		}	else	{
			// check that sprite is not berserk already
			if !(inst.berserk) {
				// if it is not, clear hexed and bound if necessary
				if (inst.bound)		inst.bound = false;
				if (inst.hexed)		inst.hexed = false;
				
				// set berserk to true
				inst.berserk = true;
				
			// if already berserk
			}	else {
				// reset berserk counter
				inst.berserkCounter = 0;
			}
		
			ds_list_add(effectedSprites, inst);
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: set BERSERK to true for all the target's nearby enemies
function set_berserk_nearby_enemies(_target) {
	// store args in locals
	var t = _target;
	
	// use a repeat loop to check if any nearbySprites need to have
	// their mindset cleared
	var i = 0;	repeat (ds_list_size(t.nearbyEnemies)) {
		var inst = t.nearbyEnemies[| i];
		
		// check if sprite is invulnerable
		if (inst.invulnerable) {
			// if so, ignore berserk
			spar_effect_push_alert(SPAR_EFFECTS.INVULNERABLE_IGNORE_STATUS);
		}	else	{
			// check that sprite is not berserk already
			if !(inst.berserk) {
				// if it is not, clear hexed and bound if necessary
				if (inst.bound)		inst.bound = false;
				if (inst.hexed)		inst.hexed = false;
				
				// set berserk to true
				inst.berserk = true;
				
			// if already berserk
			}	else {
				// reset berserk counter
				inst.berserkCounter = 0;
			}
		
			ds_list_add(effectedSprites, inst);
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: set BERSERK to true for all the target's nearby sprites
function set_berserk_nearby_sprites(_target) {
	// store args in locals
	var t = _target;
	
	// use a repeat loop to check if any nearbySprites need to have
	// their mindset cleared
	var i = 0;	repeat (ds_list_size(t.nearbySprites)) {
		var inst = t.nearbySprites[| i];
		
		// check if sprite is invulnerable
		if (inst.invulnerable) {
			// if so, ignore berserk
			spar_effect_push_alert(SPAR_EFFECTS.INVULNERABLE_IGNORE_STATUS);
		}	else	{
			// check that sprite is not berserk already
			if !(inst.berserk) {
				// if it is not, clear hexed and bound if necessary
				if (inst.bound)		inst.bound = false;
				if (inst.hexed)		inst.hexed = false;
				
				// set berserk to true
				inst.berserk = true;
				
			// if already berserk
			}	else {
				// reset berserk counter
				inst.berserkCounter = 0;
			}
		
			ds_list_add(effectedSprites, inst);
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}
	
///@desc SPAR EFFECT: set BERSERK to true for all sprites on the target team
function set_berserk_team(_targetPlayer) {
	// store arguments in local variables
	var t = _targetPlayer;
	
	// get the correct list based on the target player
	if (t == spar.playerOne)	var list = spar.allyList;
	if (t == spar.playerTwo)	var list = spar.enemyList;	
	
	// use a repeat loop to check if any nearbySprites need to have
	// their mindset cleared
	var i = 0;	repeat (ds_list_size(list)) {
		var inst = list[| i];
		
		// check if sprite is invulnerable
		if (inst.invulnerable) {
			// if so, ignore berserk
			spar_effect_push_alert(SPAR_EFFECTS.INVULNERABLE_IGNORE_STATUS);
		}	else	{
			// check that sprite is not berserk already
			if !(inst.berserk) {
				// if it is not, clear hexed and bound if necessary
				if (inst.bound)		inst.bound = false;
				if (inst.hexed)		inst.hexed = false;
				
				// set berserk to true
				inst.berserk = true;
				
			// if already berserk
			}	else {
				// reset berserk counter
				inst.berserkCounter = 0;
			}
		
			ds_list_add(effectedSprites, inst);
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: set BERSERK to true for all sprites on the field
function set_berserk_global() {
	var i = 0;	repeat (2) {
		
		// get the correct list based on the target player
		if (i)	var list = spar.allyList;
		if !(i)	var list = spar.enemyList;
		
			// use a repeat loop to check if any nearbySprites need to have
			// their mindset cleared
			var j = 0;	repeat (ds_list_size(list)) {
				var inst = list[| j];
				
				// check if sprite is invulnerable
				if (inst.invulnerable) {
					// if so, ignore berserk
					spar_effect_push_alert(SPAR_EFFECTS.INVULNERABLE_IGNORE_STATUS);
				}	else	{
					// check that sprite is not berserk already
					if !(inst.berserk) {
						// if it is not, clear hexed and bound if necessary
						if (inst.bound)		inst.bound = false;
						if (inst.hexed)		inst.hexed = false;
						
						// set berserk to true
						inst.berserk = true;
						
					// if already berserk
					}	else {
						// reset berserk counter
						inst.berserkCounter = 0;
					}
				
					ds_list_add(effectedSprites, inst);
				}
				
				j++;
			}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: set INVULNERABLE to true for the target
function set_invulnerable(_target) {
	var t = _target;
	
	if !(t.invulnerable) {
		if (t.bound)	t.bound = false;
		if (t.hexed)	t.hexed = false;
		
		t.invulnerable = true;
	}	else	instance_destroy(id);
}

///@desc SPAR EFFECT: set INVULNERABLE to true for all the target's nearby allies
function set_invulnerable_nearby_allies(_target) {
	// store args in locals
	var t = _target;
	
	// use a repeat loop to check if any nearbySprites need to have
	// their mindset cleared
	var i = 0;	repeat (ds_list_size(t.nearbyAllies)) {
		var inst = t.nearbyAllies[| i];
		
		if !(inst.invulnerable) {
			ds_list_add(effectedSprites, inst);
			
			if (t.bound)	t.bound = false;
			if (t.hexed)	t.hexed = false;
			
			inst.invulnerable = true;
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: set INVULNERABLE to true for all the target's nearby enemies
function set_invulnerable_nearby_enemies(_target) {
	// store args in locals
	var t = _target;
	
	// use a repeat loop to check if any nearbySprites need to have
	// their mindset cleared
	var i = 0;	repeat (ds_list_size(t.nearbyEnemies)) {
		var inst = t.nearbyEnemies[| i];
		
		if !(inst.invulnerable) {
			ds_list_add(effectedSprites, inst);
			inst.invulnerable = true;
		
			if (t.bound)	t.bound = false;
			if (t.hexed)	t.hexed = false;
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: set INVULNERABLE to true for all the target's nearby sprites
function set_invulnerable_nearby_sprites(_target) {
	// store args in locals
	var t = _target;
	
	// use a repeat loop to check if any nearbySprites need to have
	// their mindset cleared
	var i = 0;	repeat (ds_list_size(t.nearbySprites)) {
		var inst = t.nearbySprites[| i];
		
		if !(inst.invulnerable) {
			ds_list_add(effectedSprites, inst);
			inst.invulnerable = true;
			
			if (t.bound)	t.bound = false;
			if (t.hexed)	t.hexed = false;
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}
	
///@desc SPAR EFFECT: set INVULNERABLE to true for all sprites on the target team
function set_invulnerable_team(_targetPlayer) {
	// store arguments in local variables
	var t = _targetPlayer;
	
	// get the correct list based on the target player
	if (t == spar.playerOne)	var list = spar.allyList;
	if (t == spar.playerTwo)	var list = spar.enemyList;	
	
	// use a repeat loop to grant curse of the warrior to
	// all sprites on the list
	var i = 0;	repeat (ds_list_size(list)) {
		var inst = list[| i];
		
		if !(inst.invulnerable) {
			ds_list_add(effectedSprites, inst);
			inst.invulnerable = true;
			
			if (t.bound)	t.bound = false;
			if (t.hexed)	t.hexed = false;
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: set INVULNERABLE to true for all sprites on the field
function set_invulnerable_global() {
	var i = 0;	repeat (2) {
		
		// get the correct list based on the target player
		if (i)	var list = spar.allyList;
		if !(i)	var list = spar.enemyList;
		
		// use a repeat loop to check if any nearbySprites need to have
		// their mindset cleared
		var j = 0;	repeat (ds_list_size(list)) {
			var inst = list[| j];
			
			if !(inst.invulnerable) {
				ds_list_add(effectedSprites, inst);
				inst.invulnerable = true;
				
				if (t.bound)	t.bound = false;
				if (t.hexed)	t.hexed = false;
			}
			
			j++;
		}	
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: this effect is simply here as a way of notifying the player
/// that the damage was altered after the fact
function skydive_avoid_damage() {
	
}

///@desc SPAR EFFECT: this effect is simply here as a way of notifying the player
/// that the damage was altered after the fact
function invulnerable_avoid_damage() {
	
}

///@desc SPAR EFFECT: set PARRYING to true for casting sprite
function set_parrying(_caster) {
	var c = _caster;
	
	c.parrying = true;
}

///@desc SPAR EFFECT: determines what the damage would have been
/// if the sprite were not parrying, then depletes that amount of damage from
/// the attacking sprite's team after multiplying it by 1.5*
function apply_parry(_attackingSprite, _parryingSprite) {
	var t = _attackingSprite;
	var c = _parryingSprite;
	
	var d = get_physical_damage(t, c, BASIC_ATTACK_POWER);
	
	t.team.currentHPl -= (d * 1.5);
}

///@desc SPAR EFFECT: sets DIVIDING to true for the target sprite
/// and sets the given coefficient
function set_dividing(_targetSprite, _coefficient) {
	var t = _targetSprite;
	var a = _coefficient;
	
	if !(t.dividing) 
	&& !(t.multiplying) {
		t.dividing = true;
		t.coefficient = a;
	}	else	instance_destroy(id);
}

///@desc SPAR EFFECT: sets MULTIPLYING to true for the target sprite
/// and sets the given coefficient
function set_multiplying(_targetSprite, _coefficient) {
	var t = _targetSprite;
	var a = _coefficient;
	
	if !(t.dividing)
	&& !(t.multiplying) {
		t.multiplying = true;
		t.coefficient = a;
	}	else	instance_destroy(id);
}

///@desc SPAR EFFECT: this effect is simply a means of notifying the player
/// that the healing was altered after the fact
function multiply_healing() {
	
}

///@desc SPAR EFFECT: this effect is simply a means of notifying the player
/// that the damage was altered after the fact
function multiply_damage() {
	
}

///@desc SPAR EFFECT: this effect is simply a means of notifying the player
/// that the healing was altered after the fact
function divide_healing() {
	
}

///@desc SPAR EFFECT: this effect is simply a means of notifying the player
/// that the damage was altered after the fact
function divide_damage(_targetSprite, _coefficient) {
	
}

///@desc SPAR EFFECT: sets deflective to true for casting sprite
function set_deflective(_caster) {
	var c = _caster;
	
	if !(c.deflective) {
		c.deflective = true;	
	}	else	instance_destroy(id);
}

///@desc SPAR EFFECT: this effect is simply a means of notifying the player
/// that the spell was altered after the fact
function deflect_spell(_caster) {
	
}

///@desc SPAR EFFECT: forces the turn to end immediately
function force_turn_end() {
	ds_grid_clear(spar.turnGrid, -1);
	spar.sparPhase = sparPhases.turnEnd;
}

///@desc SPAR EFFECT: forces the targetTeam to store these turn selections
/// and repeat them the following turn
function repeat_last_turn(_targetTeam) {
	
}

///@desc SPAR EFFECT: applies damage calculated using the caster's best stat
/// and the target's worst stat
function psychic_attack(_caster, _target, _power) {
	var c = _caster;
	var t = _target;
	var p = _power;
	
	var s1 = get_current_stat_elemental(get_best_elemental_stat(c));
	
	if (c.currentPower		> s1)	s1 = c.currentPower;
	if (c.currentAgility	> s1)	s1 = c.currentAgility;
	
	var s2 = get_current_stat_elemental(get_worst_elemental_stat(c));
	
	if (t.currentResist		< s2)	s2 = t.currentResist;
	if (t.currentAgility	< s2)	s2 = t.currentAgility;
	
	var d = get_psychic_damage(s1, s2, p);
	
	t.team.currentHP -= d;
}

///@desc SPAR EFFECT: changes the target's alignment to the given alignment
function change_alignment(_target, _newAlignment) {
	var t = _target;
	var a = _newAlignment;

	if (t.currentAlign != a) {
		t.currentAlign = a;
	}	else	instance_destroy(id);
}

///@desc SPAR EFFECT: changes the target's size to the given size
function change_size(_target, _newSize) {
	var t = _target;
	var s = _newSize;
	
	if (t.currentSize != s) {
		t.currentSize = s;	
	}	else	instance_destroy(id);
}

///@desc SPAR EFFECT: this is just the energy blast function that is cast
/// specifically on the self
function energy_blast_self(_targetPlayer, _damage) {
	var t = _targetPlayer;
	var d = _damage;
	
	t.currentHP -= d;
}

///@desc SPAR EFFECT: sets hail mary as true for the target player
function set_hail_mary(_targetPlayer) {
	var t = _targetPlayer;
	
	t.hailMary = true;
}

///@desc SPAR EFFECT: this effect is simply a means of notifying the player
/// that the damage was altered aftert the fact
function berserk_increase_damage() {
	
}

///@desc SPAR EFFECT: sets BERSERK to false for target sprite
function end_berserk(_target) {
	var t = _target;
	
	if (t.berserk) {
		t.berserk = false;
	}	else	instance_destroy(id);
}

///@desc SPAR EFFECT: sets BERSERK to false for all target sprite's nearby allies
function end_berserk_nearby_allies(_target) {
	// store args in locals
	var t = _target;
	
	// use a repeat loop to check if any nearbySprites need to have
	// their mindset cleared
	var i = 0;	repeat (ds_list_size(t.nearbyAllies)) {
		var inst = t.nearbyAllies[| i];
		
		if (inst.berserk) {
			ds_list_add(effectedSprites, inst);
			inst.berserk = false;
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: sets BERSERK to false for all target sprite's nearby enemies
function end_berserk_nearby_enemies(_target) {
	// store args in locals
	var t = _target;
	
	// use a repeat loop to check if any nearbySprites need to have
	// their mindset cleared
	var i = 0;	repeat (ds_list_size(t.nearbyEnemies)) {
		var inst = t.nearbyEnemies[| i];
		
		if (inst.berserk) {
			ds_list_add(effectedSprites, inst);
			inst.berserk = false;
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: sets BERSERK to false for all target sprite's nearby sprites
function end_berserk_nearby_sprites(_target) {
	// store args in locals
	var t = _target;
	
	// use a repeat loop to check if any nearbySprites need to have
	// their mindset cleared
	var i = 0;	repeat (ds_list_size(t.nearbySprites)) {
		var inst = t.nearbySprites[| i];
		
		if (inst.berserk) {
			ds_list_add(effectedSprites, inst);
			inst.berserk = false;
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}	
}

///@desc SPAR EFFECT: sets BERSERK to false for all sprites on target team
function end_berserk_team(_targetPlayer) {
	// store arguments in local variables
	var t = _targetPlayer;
	
	// get the correct list based on the target player
	if (t == spar.playerOne)	var list = spar.allyList;
	if (t == spar.playerTwo)	var list = spar.enemyList;	
	
	// use a repeat loop to check if any nearbySprites need to have
	// their mindset cleared
	var i = 0;	repeat (ds_list_size(list)) {
		var inst = list[| i];
		
		if (inst.berserk) {
			ds_list_add(effectedSprites, inst);
			inst.berserk = false;
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}	
}

///@desc SPAR EFFECT: sets BERSERK to false for all sprites on the field
function end_berserk_global() {
	var i = 0;	repeat (2) {
		
		// get the correct list based on the target player
		if (i)	var list = spar.allyList;
		if !(i)	var list = spar.enemyList;
		
		// use a repeat loop to check if any nearbySprites need to have
		// their mindset cleared
		var j = 0;	repeat (ds_list_size(list)) {
			var inst = list[| j];
			
			if (inst.berserk) {
				ds_list_add(effectedSprites, inst);
				inst.berserk = false;
			}
			j++;
		}
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}		
}

///@desc SPAR EFFECT: sets INVULNERABLE to false for target sprite
function end_invulnerable(_target) {
	var t = _target;
	
	if (t.invulnerable) {
		t.invulnerable = false;	
	}	else	instance_destroy(id);
}

///@desc SPAR EFFECT: sets INVULNERABLE to false for all target's nearby allies
function end_invulnerable_nearby_allies(_target) {
	// store args in locals
	var t = _target;
	
	// use a repeat loop to check if any nearbySprites need to have
	// their mindset cleared
	var i = 0;	repeat (ds_list_size(t.nearbyAllies)) {
		var inst = t.nearbyAllies[| i];
		
		if (inst.invulnerable) {
			ds_list_add(effectedSprites, inst);
			inst.invulnerable = false;
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}
}

///@desc SPAR EFFECT: sets INVULNERABLE to false for all target's nearby enemies
function end_invulnerable_nearby_enemies(_target) {
	// store args in locals
	var t = _target;
	
	// use a repeat loop to check if any nearbySprites need to have
	// their mindset cleared
	var i = 0;	repeat (ds_list_size(t.nearbyEnemies)) {
		var inst = t.nearbyEnemies[| i];
		
		if (inst.invulnerable) {
			ds_list_add(effectedSprites, inst);
			inst.invulnerable = false;
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}	
}

///@desc SPAR EFFECT: sets INVULNERABLE to false for all target's nearby sprites
function end_invulnerable_nearby_sprites(_target) {
	// store args in locals
	var t = _target;
	
	// use a repeat loop to check if any nearbySprites need to have
	// their mindset cleared
	var i = 0;	repeat (ds_list_size(t.nearbySprites)) {
		var inst = t.nearbySprites[| i];
		
		if (inst.invulnerable) {
			ds_list_add(effectedSprites, inst);
			inst.invulnerable = false;
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}	
}

///@desc SPAR EFFECT: sets INVULNERABLE to false for all sprites on target team
function end_invulnerable_team(_target) {
	// store arguments in local variables
	var t = _targetPlayer;
	
	// get the correct list based on the target player
	if (t == spar.playerOne)	var list = spar.allyList;
	if (t == spar.playerTwo)	var list = spar.enemyList;	
	
	// use a repeat loop to check if any nearbySprites need to have
	// their mindset cleared
	var i = 0;	repeat (ds_list_size(list)) {
		var inst = list[| i];
		
		if (inst.invulnerable) {
			ds_list_add(effectedSprites, inst);
			inst.invulnerable = false;
		}
		
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}	
}

///@desc SPAR EFFECT: sets INVULNERABLE to false for all sprites on the field
function end_invulnerable_global() {
	var i = 0;	repeat (2) {
		
		// get the correct list based on the target player
		if (i)	var list = spar.allyList;
		if !(i)	var list = spar.enemyList;
		
		// use a repeat loop to check if any nearbySprites need to have
		// their mindset cleared
		var j = 0;	repeat (ds_list_size(list)) {
			var inst = list[| j];
			
			if (inst.invulnerable) {
				ds_list_add(effectedSprites, inst);
				inst.invulnerable = false;
			}
			j++;
		}
		i++;
	}
	
	// if no sprites were effected, destroy spar effect alert
	if (ds_list_size(effectedSprites <= 0)) {
		instance_destroy(id);
	}		
}

// get text from csv file
var textGrid = load_csv("SPAR_EFFECTS_ENGLISH.csv");

// create the sparEffectGrid
global.sparEffectGrid = ds_grid_create(SPAR_EFFECT_PARAMS.HEIGHT, SPAR_EFFECTS.HEIGHT);

// create the master grid add function 
function master_grid_add_spar_effect(_ID) {
	var ID = _ID;
	
	var i = 0;	repeat (SPAR_EFFECT_PARAMS.HEIGHT) {
		global.sparEffectGrid[# i, ID] = argument[i];
	
		i++;
	}
}

#region BUILD THE SPAR EFFECT GRID
//							ID												ALERT TEXT														EFFECT FUNCTION						ANIMATION
master_grid_add_spar_effect(SPAR_EFFECTS.ARENA_CHANGE_VOLCANO,				textGrid[# 1, SPAR_EFFECTS.ARENA_CHANGE_VOLCANO],				arena_change_volcano,				sparFX_arenaChange);
master_grid_add_spar_effect(SPAR_EFFECTS.ARENA_CHANGE_OCEAN,				textGrid[# 1, SPAR_EFFECTS.ARENA_CHANGE_OCEAN],					arena_change_ocean,					sparFX_arenaChange);
master_grid_add_spar_effect(SPAR_EFFECTS.ARENA_CHANGE_STRATOS,				textGrid[# 1, SPAR_EFFECTS.ARENA_CHANGE_STRATOS],				arena_change_stratos,				sparFX_arenaChange);
master_grid_add_spar_effect(SPAR_EFFECTS.ARENA_CHANGE_FOREST,				textGrid[# 1, SPAR_EFFECTS.ARENA_CHANGE_FOREST],				arena_change_forest,				sparFX_arenaChange);
master_grid_add_spar_effect(SPAR_EFFECTS.ARENA_CHANGE_NORMAL,				textGrid[# 1, SPAR_EFFECTS.ARENA_CHANGE_NORMAL],				arena_change_normal,				sparFX_arenaChange);
master_grid_add_spar_effect(SPAR_EFFECTS.SET_MIASMA,						textGrid[# 1, SPAR_EFFECTS.SET_MIASMA],							set_miasma,							sparFX_miasma);
master_grid_add_spar_effect(SPAR_EFFECTS.SET_HUM,							textGrid[# 1, SPAR_EFFECTS.SET_HUM],							set_hum,							sparFX_hum);
master_grid_add_spar_effect(SPAR_EFFECTS.SET_RUST,							textGrid[# 1, SPAR_EFFECTS.SET_RUST],							set_rust,							sparFX_rust);
master_grid_add_spar_effect(SPAR_EFFECTS.ENERGY_BLAST,						textGrid[# 1, SPAR_EFFECTS.ENERGY_BLAST],						energy_blast,						sparFX_energyBlast);
master_grid_add_spar_effect(SPAR_EFFECTS.BESTOW_MINDSET,					textGrid[# 1, SPAR_EFFECTS.BESTOW_MINDSET],						bestow_mindset,						sparFX_bestowMindset);
master_grid_add_spar_effect(SPAR_EFFECTS.SHIFT_MINDSET,						textGrid[# 1, SPAR_EFFECTS.SHIFT_MINDSET],						shift_mindset,						sparFX_shiftMindset);
master_grid_add_spar_effect(SPAR_EFFECTS.COPY_MINDSET,						textGrid[# 1, SPAR_EFFECTS.COPY_MINDSET],						copy_mindset,						sparFX_copyMindset);
master_grid_add_spar_effect(SPAR_EFFECTS.RESTORE_MP,						textGrid[# 1, SPAR_EFFECTS.RESTORE_MP],							restore_mp,							sparFX_restore);
master_grid_add_spar_effect(SPAR_EFFECTS.RESTORE_HP,						textGrid[# 1, SPAR_EFFECTS.RESTORE_HP],							restore_hp,							sparFX_restore);
master_grid_add_spar_effect(SPAR_EFFECTS.DEPLETE_MP,						textGrid[# 1, SPAR_EFFECTS.DEPLETE_MP],							deplete_mp,							noone);
master_grid_add_spar_effect(SPAR_EFFECTS.DEPLETE_HP,						textGrid[# 1, SPAR_EFFECTS.DEPLETE_HP],							deplete_hp,							noone);
master_grid_add_spar_effect(SPAR_EFFECTS.DEPLETE_HP_NONLETHAL,				textGrid[# 1, SPAR_EFFECTS.DEPLETE_HP_NONLETHAL],				deplete_hp_nonlethal,				noone);
master_grid_add_spar_effect(SPAR_EFFECTS.SET_BOUND,							textGrid[# 1, SPAR_EFFECTS.SET_BOUND],							set_bound,							sparFX_bound);
master_grid_add_spar_effect(SPAR_EFFECTS.SET_HEXED,							textGrid[# 1, SPAR_EFFECTS.SET_HEXED],							set_hexed,							sparFX_hexed);
master_grid_add_spar_effect(SPAR_EFFECTS.REMOVE_BOUND,						textGrid[# 1, SPAR_EFFECTS.REMOVE_BOUND],						remove_bound,						sparFX_clearStatus);
master_grid_add_spar_effect(SPAR_EFFECTS.REMOVE_HEXED,						textGrid[# 1, SPAR_EFFECTS.REMOVE_HEXED],						remove_hexed,						sparFX_clearStatus);
master_grid_add_spar_effect(SPAR_EFFECTS.CLEAR_MIASMA,						textGrid[# 1, SPAR_EFFECTS.CLEAR_MIASMA],						clear_miasma,						sparFX_clearHindrance);
master_grid_add_spar_effect(SPAR_EFFECTS.CLEAR_HUM,							textGrid[# 1, SPAR_EFFECTS.CLEAR_HUM],							clear_hum,							sparFX_clearHindrance);
master_grid_add_spar_effect(SPAR_EFFECTS.CLEAR_RUST,						textGrid[# 1, SPAR_EFFECTS.CLEAR_RUST],							clear_rust,							sparFX_clearHindrance);
master_grid_add_spar_effect(SPAR_EFFECTS.CLEAR_MINDSET,						textGrid[# 1, SPAR_EFFECTS.CLEAR_MINDSET],						clear_mindset,						sparFX_clearStatus);
master_grid_add_spar_effect(SPAR_EFFECTS.FULLY_RESTORE_HP,					textGrid[# 1, SPAR_EFFECTS.FULLY_RESTORE_HP],					fully_restore_hp,					sparFX_restore);
master_grid_add_spar_effect(SPAR_EFFECTS.FULLY_RESTORE_MP,					textGrid[# 1, SPAR_EFFECTS.FULLY_RESTORE_MP],					fully_restore_mp,					sparFX_restore);
master_grid_add_spar_effect(SPAR_EFFECTS.GRID_ADD_SKYDIVE,					textGrid[# 1, SPAR_EFFECTS.GRID_ADD_SKYDIVE],					grid_add_skydive,					sparFX_skydive);
master_grid_add_spar_effect(SPAR_EFFECTS.GRID_ADD_SNEAK_ATTACK,				textGrid[# 1, SPAR_EFFECTS.GRID_ADD_SNEAK_ATTACK],				grid_add_sneak_attack,				sparFX_sneakAttack);
master_grid_add_spar_effect(SPAR_EFFECTS.GRID_ADD_TIMED_BLAST,				textGrid[# 1, SPAR_EFFECTS.GRID_ADD_TIMED_BLAST],				grid_add_timed_blast,				sparFX_timedBlast);
master_grid_add_spar_effect(SPAR_EFFECTS.CLEAR_TEAM_HINDRANCES,				textGrid[# 1, SPAR_EFFECTS.CLEAR_TEAM_HINDRANCES],				clear_team_hindrances,				sparFX_clearTeamHindrance);
master_grid_add_spar_effect(SPAR_EFFECTS.CLEAR_ALL_HINDRANCES,				textGrid[# 1, SPAR_EFFECTS.CLEAR_ALL_HINDRANCES],				clear_all_hindrances,				sparFX_clearTeamHindrance);
master_grid_add_spar_effect(SPAR_EFFECTS.BLAST_TIMER_GO_OFF,				textGrid[# 1, SPAR_EFFECTS.BLAST_TIMER_GO_OFF],					blast_timer_go_off,					sparFX_energyBlast);
master_grid_add_spar_effect(SPAR_EFFECTS.BLAST_TIMERS_DECREMENT_COUNT,		textGrid[# 1, SPAR_EFFECTS.BLAST_TIMERS_DECREMENT_COUNT],		blast_timers_decrement_count,		sparFX_timedBlast);
master_grid_add_spar_effect(SPAR_EFFECTS.APPLY_MIASMA,						textGrid[# 1, SPAR_EFFECTS.APPLY_MIASMA],						apply_miasma,						sparFX_miasma);
master_grid_add_spar_effect(SPAR_EFFECTS.APPLY_HUM,							textGrid[# 1, SPAR_EFFECTS.APPLY_HUM],							apply_hum,							sparFX_hum);
master_grid_add_spar_effect(SPAR_EFFECTS.APPLY_RUST,						textGrid[# 1, SPAR_EFFECTS.APPLY_RUST],							apply_rust,							sparFX_rust);
master_grid_add_spar_effect(SPAR_EFFECTS.FORCE_SWAP,						textGrid[# 1, SPAR_EFFECTS.FORCE_SWAP],							force_swap,							sparFX_forceSwap);
master_grid_add_spar_effect(SPAR_EFFECTS.FORCE_SWAP_TEAM,					textGrid[# 1, SPAR_EFFECTS.FORCE_SWAP_TEAM],					force_swap_team,					sparFX_forceSwap);
master_grid_add_spar_effect(SPAR_EFFECTS.FORCE_SWAP_GLOBAL,					textGrid[# 1, SPAR_EFFECTS.FORCE_SWAP_GLOBAL],					force_swap_global,					sparFX_forceSwap);
master_grid_add_spar_effect(SPAR_EFFECTS.SET_MIASMA_GLOBAL,					textGrid[# 1, SPAR_EFFECTS.SET_MIASMA_GLOBAL],					set_miasma_global,					sparFX_miasma);
master_grid_add_spar_effect(SPAR_EFFECTS.SET_HUM_GLOBAL,					textGrid[# 1, SPAR_EFFECTS.SET_HUM_GLOBAL],						set_hum_global,						sparFX_hum);
master_grid_add_spar_effect(SPAR_EFFECTS.SET_RUST_GLOBAL,					textGrid[# 1, SPAR_EFFECTS.SET_RUST_GLOBAL],					set_rust_global,					sparFX_rust);
master_grid_add_spar_effect(SPAR_EFFECTS.CLEAR_MIASMA_GLOBAL,				textGrid[# 1, SPAR_EFFECTS.CLEAR_MIASMA_GLOBAL],				clear_miasma_global,				sparFX_clearHindrance);
master_grid_add_spar_effect(SPAR_EFFECTS.CLEAR_HUM_GLOBAL,					textGrid[# 1, SPAR_EFFECTS.CLEAR_HUM_GLOBAL],					clear_hum_global,					sparFX_clearHindrance);
master_grid_add_spar_effect(SPAR_EFFECTS.CLEAR_RUST_GLOBAL,					textGrid[# 1, SPAR_EFFECTS.CLEAR_RUST_GLOBAL],					clear_rust_global,					sparFX_clearHindrance);
master_grid_add_spar_effect(SPAR_EFFECTS.CLEAR_MINDSET_NEARBY_ALLIES,		textGrid[# 1, SPAR_EFFECTS.CLEAR_MINDSET_NEARBY_ALLIES],		clear_mindset_nearby_allies,		sparFX_clearStatus);
master_grid_add_spar_effect(SPAR_EFFECTS.CLEAR_MINDSET_NEARBY_ENEMIES,		textGrid[# 1, SPAR_EFFECTS.CLEAR_MINDSET_NEARBY_ENEMIES],		clear_mindset_nearby_enemies,		sparFX_clearStatus);
master_grid_add_spar_effect(SPAR_EFFECTS.CLEAR_MINDSET_TEAM,				textGrid[# 1, SPAR_EFFECTS.CLEAR_MINDSET_TEAM],					clear_mindset_team,					sparFX_clearStatus);
master_grid_add_spar_effect(SPAR_EFFECTS.CLEAR_MINDSET_GLOBAL,				textGrid[# 1, SPAR_EFFECTS.CLEAR_MINDSET_GLOBAL],				clear_mindset_global,				sparFX_clearStatus);
master_grid_add_spar_effect(SPAR_EFFECTS.BESTOW_MINDSET_NEARBY_ALLIES,		textGrid[# 1, SPAR_EFFECTS.BESTOW_MINDSET_NEARBY_ALLIES],		bestow_mindset_nearby_allies,		sparFX_bestowMindset);
master_grid_add_spar_effect(SPAR_EFFECTS.BESTOW_MINDSET_NEARBY_ENEMIES,		textGrid[# 1, SPAR_EFFECTS.BESTOW_MINDSET_NEARBY_ENEMIES],		bestow_mindset_nearby_enemies,		sparFX_bestowMindset);
master_grid_add_spar_effect(SPAR_EFFECTS.BESTOW_MINDSET_NEARBY_SPRITES,		textGrid[# 1, SPAR_EFFECTS.BESTOW_MINDSET_NEARBY_SPRITES],		bestow_mindset_nearby_sprites,		sparFX_bestowMindset);
master_grid_add_spar_effect(SPAR_EFFECTS.BESTOW_MINDSET_TEAM,				textGrid[# 1, SPAR_EFFECTS.BESTOW_MINDSET_TEAM],				bestow_mindset_team,				sparFX_bestowMindset);
master_grid_add_spar_effect(SPAR_EFFECTS.BESTOW_MINDSET_GLOBAL,				textGrid[# 1, SPAR_EFFECTS.BESTOW_MINDSET_GLOBAL],				bestow_mindset_global,				sparFX_bestowMindset);
master_grid_add_spar_effect(SPAR_EFFECTS.SHIFT_MINDSET_NEARBY_ALLIES,		textGrid[# 1, SPAR_EFFECTS.SHIFT_MINDSET_NEARBY_ALLIES],		shift_mindset_nearby_allies,		sparFX_shiftMindset);
master_grid_add_spar_effect(SPAR_EFFECTS.SHIFT_MINDSET_NEARBY_ENEMIES,		textGrid[# 1, SPAR_EFFECTS.SHIFT_MINDSET_NEARBY_ENEMIES],		shift_mindset_nearby_enemies,		sparFX_shiftMindset);
master_grid_add_spar_effect(SPAR_EFFECTS.SHIFT_MINDSET_NEARBY_SPRITES,		textGrid[# 1, SPAR_EFFECTS.SHIFT_MINDSET_NEARBY_SPRITES],		shift_mindset_nearby_sprites,		sparFX_shiftMindset);
master_grid_add_spar_effect(SPAR_EFFECTS.SHIFT_MINDSET_TEAM,				textGrid[# 1, SPAR_EFFECTS.SHIFT_MINDSET_TEAM],					shift_mindset_team,					sparFX_shiftMindset);
master_grid_add_spar_effect(SPAR_EFFECTS.SHIFT_MINDSET_GLOBAL,				textGrid[# 1, SPAR_EFFECTS.SHIFT_MINDSET_GLOBAL],				shift_mindset_global,				sparFX_shiftMindset);
master_grid_add_spar_effect(SPAR_EFFECTS.SHIFT_CURSE,						textGrid[# 1, SPAR_EFFECTS.SHIFT_CURSE],						shift_curse,						sparFX_shiftMindset);
master_grid_add_spar_effect(SPAR_EFFECTS.SHIFT_BLESSING,					textGrid[# 1, SPAR_EFFECTS.SHIFT_BLESSING],						shift_blessing,						sparFX_shiftMindset);
master_grid_add_spar_effect(SPAR_EFFECTS.SHIFT_CURSE_NEARBY_ALLIES,			textGrid[# 1, SPAR_EFFECTS.SHIFT_CURSE_NEARBY_ALLIES],			shift_curse_nearby_allies,			sparFX_shiftMindset);
master_grid_add_spar_effect(SPAR_EFFECTS.SHIFT_CURSE_NEARBY_ENEMIES,		textGrid[# 1, SPAR_EFFECTS.SHIFT_CURSE_NEARBY_ENEMIES],			shift_curse_nearby_enemies,			sparFX_shiftMindset);
master_grid_add_spar_effect(SPAR_EFFECTS.SHIFT_CURSE_NEARBY_SPRITES,		textGrid[# 1, SPAR_EFFECTS.SHIFT_CURSE_NEARBY_SPRITES],			shift_curse_nearby_sprites,			sparFX_shiftMindset);
master_grid_add_spar_effect(SPAR_EFFECTS.SHIFT_CURSE_TEAM,					textGrid[# 1, SPAR_EFFECTS.SHIFT_CURSE_TEAM],					shift_curse_team,					sparFX_shiftMindset);
master_grid_add_spar_effect(SPAR_EFFECTS.SHIFT_CURSE_GLOBAL,				textGrid[# 1, SPAR_EFFECTS.SHIFT_CURSE_GLOBAL],					shift_curse_global,					sparFX_shiftMindset);
master_grid_add_spar_effect(SPAR_EFFECTS.SHIFT_BLESSING_NEARBY_ALLIES,		textGrid[# 1, SPAR_EFFECTS.SHIFT_BLESSING_NEARBY_ALLIES],		shift_blessing_nearby_allies,		sparFX_shiftMindset);
master_grid_add_spar_effect(SPAR_EFFECTS.SHIFT_BLESSING_NEARBY_ENEMIES,		textGrid[# 1, SPAR_EFFECTS.SHIFT_BLESSING_NEARBY_ENEMIES],		shift_blessing_nearby_enemies,		sparFX_shiftMindset);
master_grid_add_spar_effect(SPAR_EFFECTS.SHIFT_BLESSING_NEARBY_SPRITES,		textGrid[# 1, SPAR_EFFECTS.SHIFT_BLESSING_NEARBY_SPRITES],		shift_blessing_nearby_sprites,		sparFX_shiftMindset);
master_grid_add_spar_effect(SPAR_EFFECTS.SHIFT_BLESSING_TEAM,				textGrid[# 1, SPAR_EFFECTS.SHIFT_BLESSING_TEAM],				shift_blessing_team,				sparFX_shiftMindset);
master_grid_add_spar_effect(SPAR_EFFECTS.SHIFT_BLESSING_GLOBAL,				textGrid[# 1, SPAR_EFFECTS.SHIFT_BLESSING_GLOBAL],				shift_blessing_global,				sparFX_shiftMindset);
master_grid_add_spar_effect(SPAR_EFFECTS.SET_HEXED_NEARBY_ALLIES,			textGrid[# 1, SPAR_EFFECTS.SET_HEXED_NEARBY_ALLIES],			set_hexed_nearby_allies,			sparFX_hexed);
master_grid_add_spar_effect(SPAR_EFFECTS.SET_HEXED_NEARBY_ENEMIES,			textGrid[# 1, SPAR_EFFECTS.SET_HEXED_NEARBY_ENEMIES],			set_hexed_nearby_enemies,			sparFX_hexed);
master_grid_add_spar_effect(SPAR_EFFECTS.SET_HEXED_NEARBY_SPRITES,			textGrid[# 1, SPAR_EFFECTS.SET_HEXED_NEARBY_SPRITES],			set_hexed_nearby_sprites,			sparFX_hexed);
master_grid_add_spar_effect(SPAR_EFFECTS.SET_HEXED_TEAM,					textGrid[# 1, SPAR_EFFECTS.SET_HEXED_TEAM],						set_hexed_team,						sparFX_hexed);
master_grid_add_spar_effect(SPAR_EFFECTS.SET_HEXED_GLOBAL,					textGrid[# 1, SPAR_EFFECTS.SET_HEXED_GLOBAL],					set_hexed_global,					sparFX_hexed);
master_grid_add_spar_effect(SPAR_EFFECTS.SET_BOUND_NEARBY_ALLIES,			textGrid[# 1, SPAR_EFFECTS.SET_BOUND_NEARBY_ALLIES],			set_bound_nearby_allies,			sparFX_bound);
master_grid_add_spar_effect(SPAR_EFFECTS.SET_BOUND_NEARBY_ENEMIES,			textGrid[# 1, SPAR_EFFECTS.SET_BOUND_NEARBY_ENEMIES],			set_bound_nearby_enemies,			sparFX_bound);
master_grid_add_spar_effect(SPAR_EFFECTS.SET_BOUND_NEARBY_SPRITES,			textGrid[# 1, SPAR_EFFECTS.SET_BOUND_NEARBY_SPRITES],			set_bound_nearby_sprites,			sparFX_bound);
master_grid_add_spar_effect(SPAR_EFFECTS.SET_BOUND_TEAM,					textGrid[# 1, SPAR_EFFECTS.SET_BOUND_TEAM],						set_bound_team,						sparFX_bound);
master_grid_add_spar_effect(SPAR_EFFECTS.SET_BOUND_GLOBAL,					textGrid[# 1, SPAR_EFFECTS.SET_BOUND_GLOBAL],					set_bound_global,					sparFX_bound);
master_grid_add_spar_effect(SPAR_EFFECTS.APPLY_HEXED,						textGrid[# 1, SPAR_EFFECTS.APPLY_HEXED],						apply_hexed,						sparFX_hexed);
master_grid_add_spar_effect(SPAR_EFFECTS.APPLY_BOUND,						textGrid[# 1, SPAR_EFFECTS.APPLY_BOUND],						apply_bound,						sparFX_bound);
master_grid_add_spar_effect(SPAR_EFFECTS.ENERGY_BLAST_GLOBAL,				textGrid[# 1, SPAR_EFFECTS.ENERGY_BLAST_GLOBAL],				energy_blast_global,				sparFX_energyBlast);
master_grid_add_spar_effect(SPAR_EFFECTS.INCREASE_DAMAGE_NATURAL,			textGrid[# 1, SPAR_EFFECTS.INCREASE_DAMAGE_NATURAL],			increase_damage_natural,			sparFX_increaseDamage);
master_grid_add_spar_effect(SPAR_EFFECTS.DECREASE_DAMAGE_NATURAL,			textGrid[# 1, SPAR_EFFECTS.DECREASE_DAMAGE_NATURAL],			decrease_damage_natural,			sparFX_decreaseDamage);
master_grid_add_spar_effect(SPAR_EFFECTS.INCREASE_DAMAGE_MECHANICAL,		textGrid[# 1, SPAR_EFFECTS.INCREASE_DAMAGE_MECHANICAL],			increase_damage_mechanical,			sparFX_increaseDamage);
master_grid_add_spar_effect(SPAR_EFFECTS.DECREASE_DAMAGE_MECHANICAL,		textGrid[# 1, SPAR_EFFECTS.DECREASE_DAMAGE_MECHANICAL],			decrease_damage_mechanical,			sparFX_decreaseDamage);
master_grid_add_spar_effect(SPAR_EFFECTS.INCREASE_DAMAGE_ASTRAL,			textGrid[# 1, SPAR_EFFECTS.INCREASE_DAMAGE_ASTRAL],				increase_damage_astral,				sparFX_increaseDamage);
master_grid_add_spar_effect(SPAR_EFFECTS.DECREASE_DAMAGE_ASTRAL,			textGrid[# 1, SPAR_EFFECTS.DECREASE_DAMAGE_ASTRAL],				decrease_damage_astral,				sparFX_decreaseDamage);
master_grid_add_spar_effect(SPAR_EFFECTS.VOLCANO_WATER_DECREASE_DAMAGE,		textGrid[# 1, SPAR_EFFECTS.VOLCANO_WATER_DECREASE_DAMAGE],		volcano_water_decrease_damage,		sparFX_decreaseDamage);
master_grid_add_spar_effect(SPAR_EFFECTS.VOLCANO_FIRE_INCREASE_DAMAGE,		textGrid[# 1, SPAR_EFFECTS.VOLCANO_FIRE_INCREASE_DAMAGE],		volcano_fire_increase_damage,		sparFX_increaseDamage);
master_grid_add_spar_effect(SPAR_EFFECTS.OCEAN_STORM_INCREASE_DAMAGE,		textGrid[# 1, SPAR_EFFECTS.OCEAN_STORM_INCREASE_DAMAGE],		ocean_storm_increase_damage,		sparFX_increaseDamage);
master_grid_add_spar_effect(SPAR_EFFECTS.OCEAN_WATER_INCREASE_DAMAGE,		textGrid[# 1, SPAR_EFFECTS.OCEAN_WATER_INCREASE_DAMAGE],		ocean_water_increase_damage,		sparFX_increaseDamage);
master_grid_add_spar_effect(SPAR_EFFECTS.STRATOS_EARTH_DECREASE_DAMAGE,		textGrid[# 1, SPAR_EFFECTS.STRATOS_EARTH_DECREASE_DAMAGE],		stratos_earth_decrease_damage,		sparFX_decreaseDamage);
master_grid_add_spar_effect(SPAR_EFFECTS.STRATOS_STORM_INCREASE_DAMAGE,		textGrid[# 1, SPAR_EFFECTS.STRATOS_STORM_INCREASE_DAMAGE],		stratos_storm_increase_damage,		sparFX_increaseDamage);
master_grid_add_spar_effect(SPAR_EFFECTS.FOREST_FIRE_INCREASE_DAMAGE,		textGrid[# 1, SPAR_EFFECTS.FOREST_FIRE_INCREASE_DAMAGE],		forest_fire_increase_damage,		sparFX_increaseDamage);
master_grid_add_spar_effect(SPAR_EFFECTS.FOREST_EARTH_INCREASE_DAMAGE,		textGrid[# 1, SPAR_EFFECTS.FOREST_EARTH_INCREASE_DAMAGE],		forest_earth_increase_damage,		sparFX_increaseDamage);
master_grid_add_spar_effect(SPAR_EFFECTS.DESTROY_ARENA,						textGrid[# 1, SPAR_EFFECTS.DESTROY_ARENA],						destroy_arena,						sparFX_destroyArena);
master_grid_add_spar_effect(SPAR_EFFECTS.DRAIN_HEALTH,						textGrid[# 1, SPAR_EFFECTS.DRAIN_HEALTH],						drain_health,						sparFX_restore);
master_grid_add_spar_effect(SPAR_EFFECTS.DRAIN_MAGIC,						textGrid[# 1, SPAR_EFFECTS.DRAIN_MAGIC],						drain_magic,						sparFX_restore);
master_grid_add_spar_effect(SPAR_EFFECTS.REPLACE_TARGET,					textGrid[# 1, SPAR_EFFECTS.REPLACE_TARGET],						replace_target,						sparFX_replaceTarget);
master_grid_add_spar_effect(SPAR_EFFECTS.BALL_LIGHTNING_SET_ACTIVE,			textGrid[# 1, SPAR_EFFECTS.BALL_LIGHTNING_SET_ACTIVE],			ball_lightning_set_active,			sparFX_ballLightning);
master_grid_add_spar_effect(SPAR_EFFECTS.BALL_LIGHTNING_ABSORB_SPELL,		textGrid[# 1, SPAR_EFFECTS.BALL_LIGHTNING_ABSORB_SPELL],		ball_lightning_absorb_spell,		sparFX_ballLightning);
master_grid_add_spar_effect(SPAR_EFFECTS.BALL_LIGHTNING_APPLY_DAMAGE,		textGrid[# 1, SPAR_EFFECTS.BALL_LIGHTNING_APPLY_DAMAGE],		ball_lightning_apply_damage,		sparFX_energyBlast);
master_grid_add_spar_effect(SPAR_EFFECTS.BLACK_HOLE_SET_ACTIVE,				textGrid[# 1, SPAR_EFFECTS.BLACK_HOLE_SET_ACTIVE],				black_hole_set_active,				sparFX_blackHole);
master_grid_add_spar_effect(SPAR_EFFECTS.BLACK_HOLE_ABSORB_SPELL,			textGrid[# 1, SPAR_EFFECTS.BLACK_HOLE_ABSORB_SPELL],			black_hole_absorb_spell,			sparFX_blackHole);
master_grid_add_spar_effect(SPAR_EFFECTS.BLACK_HOLE_APPLY_DAMAGE,			textGrid[# 1, SPAR_EFFECTS.BLACK_HOLE_APPLY_DAMAGE],			black_hole_apply_damage,			sparFX_energyBlast);
master_grid_add_spar_effect(SPAR_EFFECTS.APPLY_SELF_DAMAGE,					textGrid[# 1, SPAR_EFFECTS.APPLY_SELF_DAMAGE],					apply_self_damage,					noone);
master_grid_add_spar_effect(SPAR_EFFECTS.SET_BERSERK,						textGrid[# 1, SPAR_EFFECTS.SET_BERSERK],						set_berserk,						sparFX_berserk);
master_grid_add_spar_effect(SPAR_EFFECTS.SET_BERSERK_NEARBY_ALLIES,			textGrid[# 1, SPAR_EFFECTS.SET_BERSERK_NEARBY_ALLIES],			set_berserk_nearby_allies,			sparFX_berserk);
master_grid_add_spar_effect(SPAR_EFFECTS.SET_BERSERK_NEARBY_ENEMIES,		textGrid[# 1, SPAR_EFFECTS.SET_BERSERK_NEARBY_ENEMIES],			set_berserk_nearby_enemies,			sparFX_berserk);
master_grid_add_spar_effect(SPAR_EFFECTS.SET_BERSERK_NEARBY_SPRITES,		textGrid[# 1, SPAR_EFFECTS.SET_BERSERK_NEARBY_SPRITES],			set_berserk_nearby_sprites,			sparFX_berserk);
master_grid_add_spar_effect(SPAR_EFFECTS.SET_BERSERK_TEAM,					textGrid[# 1, SPAR_EFFECTS.SET_BERSERK_TEAM],					set_berserk_team,					sparFX_berserk);
master_grid_add_spar_effect(SPAR_EFFECTS.SET_BERSERK_GLOBAL,				textGrid[# 1, SPAR_EFFECTS.SET_BERSERK_GLOBAL],					set_berserk_global,					sparFX_berserk);
master_grid_add_spar_effect(SPAR_EFFECTS.SET_INVULNERABLE,					textGrid[# 1, SPAR_EFFECTS.SET_INVULNERABLE],					set_invulnerable,					sparFX_invulnerable);
master_grid_add_spar_effect(SPAR_EFFECTS.SET_INVULNERABLE_NEARBY_ALLIES,	textGrid[# 1, SPAR_EFFECTS.SET_INVULNERABLE_NEARBY_ALLIES],		set_invulnerable_nearby_allies,		sparFX_invulnerable);
master_grid_add_spar_effect(SPAR_EFFECTS.SET_INVULNERABLE_NEARBY_ENEMIES,	textGrid[# 1, SPAR_EFFECTS.SET_INVULNERABLE_NEARBY_ENEMIES],	set_invulnerable_nearby_enemies,	sparFX_invulnerable);
master_grid_add_spar_effect(SPAR_EFFECTS.SET_INVULNERABLE_NEARBY_SPRITES,	textGrid[# 1, SPAR_EFFECTS.SET_INVULNERABLE_NEARBY_SPRITES],	set_invulnerable_nearby_sprites,	sparFX_invulnerable);
master_grid_add_spar_effect(SPAR_EFFECTS.SET_INVULNERABLE_TEAM,				textGrid[# 1, SPAR_EFFECTS.SET_INVULNERABLE_TEAM],				set_invulnerable_team,				sparFX_invulnerable);
master_grid_add_spar_effect(SPAR_EFFECTS.SET_INVULNERABLE_GLOBAL,			textGrid[# 1, SPAR_EFFECTS.SET_INVULNERABLE_GLOBAL],			set_invulnerable_global,			sparFX_invulnerable);
master_grid_add_spar_effect(SPAR_EFFECTS.SKYDIVE_AVOID_DAMAGE,				textGrid[# 1, SPAR_EFFECTS.SKYDIVE_AVOID_DAMAGE],				skydive_avoid_damage,				sparFX_skydive);
master_grid_add_spar_effect(SPAR_EFFECTS.INVULNERABLE_AVOID_DAMAGE,			textGrid[# 1, SPAR_EFFECTS.INVULNERABLE_AVOID_DAMAGE],			invulnerable_avoid_damage,			sparFX_invulnerable);
master_grid_add_spar_effect(SPAR_EFFECTS.SET_PARRYING,						textGrid[# 1, SPAR_EFFECTS.SET_PARRYING],						set_parrying,						sparFX_parry);
master_grid_add_spar_effect(SPAR_EFFECTS.APPLY_PARRY,						textGrid[# 1, SPAR_EFFECTS.APPLY_PARRY],						apply_parry,						sparFX_takeDamage);
master_grid_add_spar_effect(SPAR_EFFECTS.SET_DIVIDING,						textGrid[# 1, SPAR_EFFECTS.SET_DIVIDING],						set_dividing,						sparFX_divide);
master_grid_add_spar_effect(SPAR_EFFECTS.SET_MULTIPLYING,					textGrid[# 1, SPAR_EFFECTS.SET_MULTIPLYING],					set_multiplying,					sparFX_multiply);
master_grid_add_spar_effect(SPAR_EFFECTS.DIVIDE_HEALING,					textGrid[# 1, SPAR_EFFECTS.DIVIDE_HEALING],						divide_healing,						sparFX_divide);
master_grid_add_spar_effect(SPAR_EFFECTS.DIVIDE_DAMAGE,						textGrid[# 1, SPAR_EFFECTS.DIVIDE_DAMAGE],						divide_damage,						sparFX_divide);
master_grid_add_spar_effect(SPAR_EFFECTS.MULTIPLY_HEALING,					textGrid[# 1, SPAR_EFFECTS.MULTIPLY_HEALING],					multiply_healing,					sparFX_multiply);
master_grid_add_spar_effect(SPAR_EFFECTS.MULTIPLY_DAMAGE,					textGrid[# 1, SPAR_EFFECTS.MULTIPLY_DAMAGE],					multiply_damage,					sparFX_multiply);
master_grid_add_spar_effect(SPAR_EFFECTS.SET_DEFLECTIVE,					textGrid[# 1, SPAR_EFFECTS.SET_DEFLECTIVE],						set_deflective,						sparFX_deflect);
master_grid_add_spar_effect(SPAR_EFFECTS.DEFLECT_SPELL,						textGrid[# 1, SPAR_EFFECTS.DEFLECT_SPELL],						deflect_spell,						sparFX_deflect);
master_grid_add_spar_effect(SPAR_EFFECTS.BERSERK_INCREASE_DAMAGE,			textGrid[# 1, SPAR_EFFECTS.BERSERK_INCREASE_DAMAGE],			berserk_increase_damage,			sparFX_berserk);
master_grid_add_spar_effect(SPAR_EFFECTS.END_BERSERK,						textGrid[# 1, SPAR_EFFECTS.END_BERSERK],						end_berserk,						sparFX_clearStatus);
master_grid_add_spar_effect(SPAR_EFFECTS.END_BERSERK_NEARBY_ALLIES,			textGrid[# 1, SPAR_EFFECTS.END_BERSERK_NEARBY_ALLIES],			end_berserk_nearby_allies,			sparFX_clearStatus);
master_grid_add_spar_effect(SPAR_EFFECTS.END_BERSERK_NEARBY_ENEMIES,		textGrid[# 1, SPAR_EFFECTS.END_BERSERK_NEARBY_ENEMIES],			end_berserk_nearby_allies,			sparFX_clearStatus);
master_grid_add_spar_effect(SPAR_EFFECTS.END_BERSERK_NEARBY_SPRITES,		textGrid[# 1, SPAR_EFFECTS.END_BERSERK_NEARBY_SPRITES],			end_berserk_nearby_sprites,			sparFX_clearStatus);
master_grid_add_spar_effect(SPAR_EFFECTS.END_BERSERK_TEAM,					textGrid[# 1, SPAR_EFFECTS.END_BERSERK_TEAM],					end_berserk_team,					sparFX_clearStatus);
master_grid_add_spar_effect(SPAR_EFFECTS.END_BERSERK_GLOBAL,				textGrid[# 1, SPAR_EFFECTS.END_BERSERK_GLOBAL],					end_berserk_global,					sparFX_clearStatus);
master_grid_add_spar_effect(SPAR_EFFECTS.END_INVULNERABLE,					textGrid[# 1, SPAR_EFFECTS.END_INVULNERABLE],					end_invulnerable,					sparFX_clearStatus);
master_grid_add_spar_effect(SPAR_EFFECTS.END_INVULNERABLE_NEARBY_ALLIES,	textGrid[# 1, SPAR_EFFECTS.END_INVULNERABLE_NEARBY_ALLIES],		end_invulnerable_nearby_allies,		sparFX_clearStatus);
master_grid_add_spar_effect(SPAR_EFFECTS.END_INVULNERABLE_NEARBY_ENEMIES,	textGrid[# 1, SPAR_EFFECTS.END_INVULNERABLE_NEARBY_ENEMIES],	end_invulnerable_nearby_enemies,	sparFX_clearStatus);
master_grid_add_spar_effect(SPAR_EFFECTS.END_INVULNERABLE_NEARBY_SPRITES,	textGrid[# 1, SPAR_EFFECTS.END_INVULNERABLE_NEARBY_SPRITES],	end_invulnerable_nearby_sprites,	sparFX_clearStatus);
master_grid_add_spar_effect(SPAR_EFFECTS.END_INVULNERABLE_TEAM,				textGrid[# 1, SPAR_EFFECTS.END_INVULNERABLE_TEAM],				end_invulnerable_team,				sparFX_clearStatus);
master_grid_add_spar_effect(SPAR_EFFECTS.END_INVULNERABLE_GLOBAL,			textGrid[# 1, SPAR_EFFECTS.END_INVULNERABLE_GLOBAL],			end_invulnerable_global,			sparFX_clearStatus);
#endregion

// encode the spar effect grid
global.allSparEffects = encode_grid(global.sparEffectGrid);

// delete the spar effect grid and the text grid
ds_grid_destroy(global.sparEffectGrid);
ds_grid_destroy(textGrid);