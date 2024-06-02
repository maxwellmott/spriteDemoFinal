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
	RUST_INCREASE_PHYSICAL_DAMAGE,
	HUM_DECREASE_ELEMENTAL_DAMAGE,
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

	if (t.mindset > 0) {
		t.mindset = 0 - t.mindset;
		// return -1 for switching to curse
		// this is simply to close the function
		return -1;
	}
	if (t.mindset < 0) {
		t.mindset = 0 - t.mindset;
		// return 1 for switching to blessing
		// this is simply to close the function
		return 1;
	}
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
		t.bound = true;
	}	else	instance_destroy(id);
}

///@desc SPAR EFFECT: sets HEXED to true for the target sprite
function set_hexed(_target) {
	var t = _target;
	
	if !(t.hexed) {
		t.hexed = true;
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

function force_swap_team(_targetPlayer) {
	randomize();
	
	if !(dodgeSuccess) {		
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
		
		var temp	= psid;
		psid		= tsid;
		tsid		= temp;
		
		// delete lists
		ds_list_destroy(l);
		ds_list_destroy(il);
	}	
}

function force_swap_global() {
}

function set_miasma_global() {
}

function set_hum_global() {
}

function set_rust_global() {
}

function clear_miasma_global() {
}

function clear_hum_global() {
}

function clear_rust_global() {
}

function clear_mindset_nearby_allies(_target) {
	
}

function clear_mindset_nearby_enemies(_target) {
	
}

function clear_mindset_nearby_sprites(_target) {
	
}

function clear_mindset_team(_targetPlayer) {
	
}

function clear_mindset_global() {
	
}

function bestow_mindset_nearby_allies(_target, _mindset) {
}

function bestow_mindset_nearby_enemies(_target, _mindset) {
}

function bestow_mindset_nearby_sprites(_target, _mindset) {
}

function bestow_mindset_team(_targetPlayer, _mindset) {	
	// store arguments in local variables
	var t = _targetPlayer;
	var m = _mindset;
	
	// initialize dummy list
	var list = ds_list_create();
	
	// get player's allyList
	if (t == spar.playerOne) {
		ds_list_copy(list, spar.allyList);
	}
	
	if (t == spar.playerTwo) {
		ds_list_copy(list, spar.enemyList);
	}
	
	// use a repeat loop to grant curse of the warrior to
	// all sprites on the list
	var i = 0;	repeat (ds_list_size(list)) {
		list[| i].mindset = m;
		spar_effect_push_alert(SPAR_EFFECTS.BESTOW_MINDSET, list[| i], -1 * (MINDSETS.WARRIOR));
		
		i++;
	}
	
	// delete the list
	ds_list_destroy(list);	
}

function bestow_mindset_global() {
}

function shift_mindset_nearby_allies(_target) {
}

function shift_mindset_nearby_enemies(_target) {
}

function shift_mindset_nearby_sprites(_target) {
}

function shift_mindset_team(_targetPlayer) {
}

function shift_mindset_global() {	
}

function shift_curse_nearby_allies(_target) {
}

function shift_curse_nearby_enemies(_target) {
}

function shift_curse_nearby_sprites(_target) {
}

function shift_curse_team(_targetPlayer) {
	
}

function shift_curse_global() {
	
}

function shift_blessing_nearby_allies(_target) {
	
}

function shift_blessing_nearby_enemies(_target) {
	
}

function shift_blessing_nearby_sprites(_target) {
	
}

function shift_blessing_team(_targetPlayer) {
	
}

function shift_blessing_global() {
	
}

function set_hexed_nearby_allies(_target) {
	
}

function set_hexed_nearby_enemies(_target) {
	
}

function set_hexed_nearby_sprites(_target) {
	
}

function set_hexed_team(_targetPlayer) {
	// initialize dummy list
	var list = ds_list_create();
	
	// get enemy allyList
	if (t == spar.playerOne) {
		ds_list_copy(list, spar.allyList);
	}
	
	if (t == spar.playerTwo) {
		ds_list_copy(list, spar.enemyList);
	}
	
	// use a repeat loop to hex all enemies
	var i = 0;	repeat (ds_list_size(list)) {
		spar_effect_push_alert(SPAR_EFFECTS.SET_HEXED, list[| i]);
		
		i++;
	}
	
	// delete the dummy list
	ds_list_destroy(list);	
}

function set_hexed_global() {
	
}

function set_bound_nearby_allies(_target) {
	
}

function set_bound_nearby_enemies(_target) {
	
}

function set_bound_nearby_sprites(_target) {
	
}

function set_bound_team(_targetPlayer) {
	
}

function set_bound_global(_targetPlayer) {
	
}

function apply_hexed() {
	
}

function apply_bound() {
	
}

function energy_blast_global() {
	
}

function rust_increase_physical_damage() {
	
}

function hum_decrease_elemental_damage() {
	
}

function increase_damage_natural(_multiplier) {
	
}

function decrease_damage_natural(_multiplier) {
	
}

function increase_damage_mechanical(_multiplier) {
	
}

function decrease_damage_mechanical(_multiplier) {
	
}

function increase_damage_astral(_multiplier) {
	
}

function decrease_damage_astral(_multiplier) {
	
}

function volcano_water_decrease_damage() {
	
}

function volcano_fire_increase_damage() {
	
}

function ocean_storm_increase_damage() {
	
}

function ocean_water_increase_damage() {
	
}

function stratos_earth_decrease_damage() {
	
}

function stratos_storm_increase_damage() {
	
}

function forest_fire_increase_damage() {
	
}

function forest_earth_increase_damage() {
	
}

function destroy_arena() {
	
}

function drain_health(_receivingTeam, _amount) {
	
}

function drain_magic(_receivingTeam, _amount) {
	
}

function replace_target(_caster, _target) {
		
}

function ball_lightning_set_active(_caster) {
	
}

function ball_lightning_absorb_spell(_blSprite) {
	
}

function ball_lightning_apply_damage(_blSprite, _count) {
	
}

function black_hole_set_active(_caster) {
	
}

function black_hole_absorb_spell(_bhSprite) {
	
}

function black_hole_apply_damage(_bhSprite, _count) {
	
}

function apply_self_damage(_targetPlayer, _amount) {
	
}

function set_berserk(_target) {
	
}

function set_berserk_nearby_allies(_target) {
	
}

function set_berserk_nearby_enemies(_target) {
	
}

function set_berserk_nearby_sprites(_target) {
	
}
	
function set_berserk_team(_targetPlayer) {
	
}

function set_berserk_global() {
	
}

function set_invulnerable(_target) {
	
}

function set_invulnerable_nearby_allies(_target) {
	
}

function set_invulnerable_nearby_enemies(_target) {
	
}

function set_invulnerable_nearby_sprites(_target) {
	
}

function set_invulnerable_team(_targetPlayer) {
	
}

function set_invulnerable_global() {
	
}

function skydive_avoid_damage() {
	
}

function invulnerable_avoid_damage() {
	
}

function set_parrying(_caster) {
	
}

function apply_parry(_attackingSprite) {
	
}

function set_dividing(_targetSprite, _coefficient) {
	
}

function set_multiplying(_targetSprite, _coefficient) {
	
}

function multiply_healing(_targetSprite, _coefficient) {
	
}

function multiply_damage(_targetsprite, _coefficient) {
	
}

function divide_healing(_targetSprite, _coefficient) {
	
}

function divide_damage(_targetSprite, _coefficient) {
	
}

function set_deflective(_caster) {
	
}

function deflect_spell(_caster) {
	
}

function force_turn_end() {
	
}

function repeat_last_turn(_targetTeam) {
	
}

function psychic_attack(_caster, _target, _power) {
	
}

function change_alignment(_target, _newAlignment) {
	
}

function change_size(_target, _newSize) {
	
}

function energy_blast_self(_targetPlayer, _damage) {
	
}

function set_hail_mary(_targetPlayer) {
	
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
master_grid_add_spar_effect(SPAR_EFFECTS.ARENA_CHANGE_VOLCANO,				textGrid[# 1, SPAR_EFFECTS.ARENA_CHANGE_VOLCANO],				arena_change_volcano,				noone);
master_grid_add_spar_effect(SPAR_EFFECTS.ARENA_CHANGE_OCEAN,				textGrid[# 1, SPAR_EFFECTS.ARENA_CHANGE_OCEAN],					arena_change_ocean,					noone);
master_grid_add_spar_effect(SPAR_EFFECTS.ARENA_CHANGE_STRATOS,				textGrid[# 1, SPAR_EFFECTS.ARENA_CHANGE_STRATOS],				arena_change_stratos,				noone);
master_grid_add_spar_effect(SPAR_EFFECTS.ARENA_CHANGE_FOREST,				textGrid[# 1, SPAR_EFFECTS.ARENA_CHANGE_FOREST],				arena_change_forest,				noone);
master_grid_add_spar_effect(SPAR_EFFECTS.ARENA_CHANGE_NORMAL,				textGrid[# 1, SPAR_EFFECTS.ARENA_CHANGE_NORMAL],				arena_change_normal,				noone);
master_grid_add_spar_effect(SPAR_EFFECTS.SET_MIASMA,						textGrid[# 1, SPAR_EFFECTS.SET_MIASMA],							set_miasma,							noone);
master_grid_add_spar_effect(SPAR_EFFECTS.SET_HUM,							textGrid[# 1, SPAR_EFFECTS.SET_HUM],							set_hum,							noone);
master_grid_add_spar_effect(SPAR_EFFECTS.SET_RUST,							textGrid[# 1, SPAR_EFFECTS.SET_RUST],							set_rust,							noone);
master_grid_add_spar_effect(SPAR_EFFECTS.ENERGY_BLAST,						textGrid[# 1, SPAR_EFFECTS.ENERGY_BLAST],						energy_blast,						noone);
master_grid_add_spar_effect(SPAR_EFFECTS.BESTOW_MINDSET,					textGrid[# 1, SPAR_EFFECTS.BESTOW_MINDSET],						bestow_mindset,						noone);
master_grid_add_spar_effect(SPAR_EFFECTS.SHIFT_MINDSET,						textGrid[# 1, SPAR_EFFECTS.SHIFT_MINDSET],						shift_mindset,						noone);
master_grid_add_spar_effect(SPAR_EFFECTS.COPY_MINDSET,						textGrid[# 1, SPAR_EFFECTS.COPY_MINDSET],						copy_mindset,						noone);
master_grid_add_spar_effect(SPAR_EFFECTS.RESTORE_MP,						textGrid[# 1, SPAR_EFFECTS.RESTORE_MP],							restore_mp,							noone);
master_grid_add_spar_effect(SPAR_EFFECTS.RESTORE_HP,						textGrid[# 1, SPAR_EFFECTS.RESTORE_HP],							restore_hp,							noone);
master_grid_add_spar_effect(SPAR_EFFECTS.DEPLETE_MP,						textGrid[# 1, SPAR_EFFECTS.DEPLETE_MP],							deplete_mp,							noone);
master_grid_add_spar_effect(SPAR_EFFECTS.DEPLETE_HP,						textGrid[# 1, SPAR_EFFECTS.DEPLETE_HP],							deplete_hp,							noone);
master_grid_add_spar_effect(SPAR_EFFECTS.DEPLETE_HP_NONLETHAL,				textGrid[# 1, SPAR_EFFECTS.DEPLETE_HP_NONLETHAL],				deplete_hp_nonlethal,				noone);
master_grid_add_spar_effect(SPAR_EFFECTS.SET_BOUND,							textGrid[# 1, SPAR_EFFECTS.SET_BOUND],							set_bound,							noone);
master_grid_add_spar_effect(SPAR_EFFECTS.SET_HEXED,							textGrid[# 1, SPAR_EFFECTS.SET_HEXED],							set_hexed,							noone);
master_grid_add_spar_effect(SPAR_EFFECTS.REMOVE_BOUND,						textGrid[# 1, SPAR_EFFECTS.REMOVE_BOUND],						remove_bound,						noone);
master_grid_add_spar_effect(SPAR_EFFECTS.REMOVE_HEXED,						textGrid[# 1, SPAR_EFFECTS.REMOVE_HEXED],						remove_hexed,						noone);
master_grid_add_spar_effect(SPAR_EFFECTS.CLEAR_MIASMA,						textGrid[# 1, SPAR_EFFECTS.CLEAR_MIASMA],						clear_miasma,						noone);
master_grid_add_spar_effect(SPAR_EFFECTS.CLEAR_HUM,							textGrid[# 1, SPAR_EFFECTS.CLEAR_HUM],							clear_hum,							noone);
master_grid_add_spar_effect(SPAR_EFFECTS.CLEAR_RUST,						textGrid[# 1, SPAR_EFFECTS.CLEAR_RUST],							clear_rust,							noone);
master_grid_add_spar_effect(SPAR_EFFECTS.CLEAR_MINDSET,						textGrid[# 1, SPAR_EFFECTS.CLEAR_MINDSET],						clear_mindset,						noone);
master_grid_add_spar_effect(SPAR_EFFECTS.FULLY_RESTORE_HP,					textGrid[# 1, SPAR_EFFECTS.FULLY_RESTORE_HP],					fully_restore_hp,					noone);
master_grid_add_spar_effect(SPAR_EFFECTS.FULLY_RESTORE_MP,					textGrid[# 1, SPAR_EFFECTS.FULLY_RESTORE_MP],					fully_restore_mp,					noone);
master_grid_add_spar_effect(SPAR_EFFECTS.GRID_ADD_SKYDIVE,					textGrid[# 1, SPAR_EFFECTS.GRID_ADD_SKYDIVE],					grid_add_skydive,					noone);
master_grid_add_spar_effect(SPAR_EFFECTS.GRID_ADD_SNEAK_ATTACK,				textGrid[# 1, SPAR_EFFECTS.GRID_ADD_SNEAK_ATTACK],				grid_add_sneak_attack,				noone);
master_grid_add_spar_effect(SPAR_EFFECTS.GRID_ADD_TIMED_BLAST,				textGrid[# 1, SPAR_EFFECTS.GRID_ADD_TIMED_BLAST],				grid_add_timed_blast,				noone);
master_grid_add_spar_effect(SPAR_EFFECTS.CLEAR_TEAM_HINDRANCES,				textGrid[# 1, SPAR_EFFECTS.CLEAR_TEAM_HINDRANCES],				clear_team_hindrances,				noone);
master_grid_add_spar_effect(SPAR_EFFECTS.CLEAR_ALL_HINDRANCES,				textGrid[# 1, SPAR_EFFECTS.CLEAR_ALL_HINDRANCES],				clear_all_hindrances,				noone);
master_grid_add_spar_effect(SPAR_EFFECTS.BLAST_TIMER_GO_OFF,				textGrid[# 1, SPAR_EFFECTS.BLAST_TIMER_GO_OFF],					blast_timer_go_off,					noone);
master_grid_add_spar_effect(SPAR_EFFECTS.BLAST_TIMERS_DECREMENT_COUNT,		textGrid[# 1, SPAR_EFFECTS.BLAST_TIMERS_DECREMENT_COUNT],		blast_timers_decrement_count,		noone);
master_grid_add_spar_effect(SPAR_EFFECTS.APPLY_MIASMA,						textGrid[# 1, SPAR_EFFECTS.APPLY_MIASMA],						apply_miasma,						noone);
master_grid_add_spar_effect(SPAR_EFFECTS.APPLY_HUM,							textGrid[# 1, SPAR_EFFECTS.APPLY_HUM],							apply_hum,							noone);
master_grid_add_spar_effect(SPAR_EFFECTS.APPLY_RUST,						textGrid[# 1, SPAR_EFFECTS.APPLY_RUST],							apply_rust,							noone);
master_grid_add_spar_effect(SPAR_EFFECTS.FORCE_SWAP,						textGrid[# 1, SPAR_EFFECTS.FORCE_SWAP],							force_swap,							noone);
master_grid_add_spar_effect(SPAR_EFFECTS.FORCE_SWAP_TEAM,					textGrid[# 1, SPAR_EFFECTS.FORCE_SWAP_TEAM],					force_swap_team,					noone);
master_grid_add_spar_effect(SPAR_EFFECTS.FORCE_SWAP_GLOBAL,					textGrid[# 1, SPAR_EFFECTS.FORCE_SWAP_GLOBAL],					force_swap_global,					noone);
master_grid_add_spar_effect(SPAR_EFFECTS.SET_MIASMA_GLOBAL,					textGrid[# 1, SPAR_EFFECTS.SET_MIASMA_GLOBAL],					set_miasma_global,					noone);
master_grid_add_spar_effect(SPAR_EFFECTS.SET_HUM_GLOBAL,					textGrid[# 1, SPAR_EFFECTS.SET_HUM_GLOBAL],						set_hum_global,						noone);
master_grid_add_spar_effect(SPAR_EFFECTS.SET_RUST_GLOBAL,					textGrid[# 1, SPAR_EFFECTS.SET_RUST_GLOBAL],					set_rust_global,					noone);
master_grid_add_spar_effect(SPAR_EFFECTS.CLEAR_MIASMA_GLOBAL,				textGrid[# 1, SPAR_EFFECTS.CLEAR_MIASMA_GLOBAL],				clear_miasma_global,				noone);
master_grid_add_spar_effect(SPAR_EFFECTS.CLEAR_HUM_GLOBAL,					textGrid[# 1, SPAR_EFFECTS.CLEAR_HUM_GLOBAL],					clear_hum_global,					noone);
master_grid_add_spar_effect(SPAR_EFFECTS.CLEAR_RUST_GLOBAL,					textGrid[# 1, SPAR_EFFECTS.CLEAR_RUST_GLOBAL],					clear_rust_global,					noone);
master_grid_add_spar_effect(SPAR_EFFECTS.CLEAR_MINDSET_NEARBY_ALLIES,		textGrid[# 1, SPAR_EFFECTS.CLEAR_MINDSET_NEARBY_ALLIES],		clear_mindset_nearby_allies,		noone);
master_grid_add_spar_effect(SPAR_EFFECTS.CLEAR_MINDSET_NEARBY_ENEMIES,		textGrid[# 1, SPAR_EFFECTS.CLEAR_MINDSET_NEARBY_ENEMIES],		clear_mindset_nearby_enemies,		noone);
master_grid_add_spar_effect(SPAR_EFFECTS.CLEAR_MINDSET_TEAM,				textGrid[# 1, SPAR_EFFECTS.CLEAR_MINDSET_TEAM],					clear_mindset_team,					noone);
master_grid_add_spar_effect(SPAR_EFFECTS.CLEAR_MINDSET_GLOBAL,				textGrid[# 1, SPAR_EFFECTS.CLEAR_MINDSET_GLOBAL],				clear_mindset_global,				noone);
master_grid_add_spar_effect(SPAR_EFFECTS.BESTOW_MINDSET_NEARBY_ALLIES,		textGrid[# 1, SPAR_EFFECTS.BESTOW_MINDSET_NEARBY_ALLIES],		bestow_mindset_nearby_allies,		noone);
master_grid_add_spar_effect(SPAR_EFFECTS.BESTOW_MINDSET_NEARBY_ENEMIES,		textGrid[# 1, SPAR_EFFECTS.BESTOW_MINDSET_NEARBY_ENEMIES],		bestow_mindset_nearby_enemies,		noone);
master_grid_add_spar_effect(SPAR_EFFECTS.BESTOW_MINDSET_NEARBY_SPRITES,		textGrid[# 1, SPAR_EFFECTS.BESTOW_MINDSET_NEARBY_SPRITES],		bestow_mindset_nearby_sprites,		noone);
master_grid_add_spar_effect(SPAR_EFFECTS.BESTOW_MINDSET_TEAM,				textGrid[# 1, SPAR_EFFECTS.BESTOW_MINDSET_TEAM],				bestow_mindset_team,				noone);
master_grid_add_spar_effect(SPAR_EFFECTS.BESTOW_MINDSET_GLOBAL,				textGrid[# 1, SPAR_EFFECTS.BESTOW_MINDSET_GLOBAL],				bestow_mindset_global,				noone);
master_grid_add_spar_effect(SPAR_EFFECTS.SHIFT_MINDSET_NEARBY_ALLIES,		textGrid[# 1, SPAR_EFFECTS.SHIFT_MINDSET_NEARBY_ALLIES],		shift_mindset_nearby_allies,		noone);
master_grid_add_spar_effect(SPAR_EFFECTS.SHIFT_MINDSET_NEARBY_ENEMIES,		textGrid[# 1, SPAR_EFFECTS.SHIFT_MINDSET_NEARBY_ENEMIES],		shift_mindset_nearby_enemies,		noone);
master_grid_add_spar_effect(SPAR_EFFECTS.SHIFT_MINDSET_NEARBY_SPRITES,		textGrid[# 1, SPAR_EFFECTS.SHIFT_MINDSET_NEARBY_SPRITES],		shift_mindset_nearby_sprites,		noone);
master_grid_add_spar_effect(SPAR_EFFECTS.SHIFT_MINDSET_TEAM,				textGrid[# 1, SPAR_EFFECTS.SHIFT_MINDSET_TEAM],					shift_mindset_team,					noone);
master_grid_add_spar_effect(SPAR_EFFECTS.SHIFT_MINDSET_GLOBAL,				textGrid[# 1, SPAR_EFFECTS.SHIFT_MINDSET_GLOBAL],				shift_mindset_global,				noone);
master_grid_add_spar_effect(SPAR_EFFECTS.SHIFT_CURSE_NEARBY_ALLIES,			textGrid[# 1, SPAR_EFFECTS.SHIFT_CURSE_NEARBY_ALLIES],			shift_curse_nearby_allies,			noone);
master_grid_add_spar_effect(SPAR_EFFECTS.SHIFT_CURSE_NEARBY_ENEMIES,		textGrid[# 1, SPAR_EFFECTS.SHIFT_CURSE_NEARBY_ENEMIES],			shift_curse_nearby_enemies,			noone);
master_grid_add_spar_effect(SPAR_EFFECTS.SHIFT_CURSE_NEARBY_SPRITES,		textGrid[# 1, SPAR_EFFECTS.SHIFT_CURSE_NEARBY_SPRITES],			shift_curse_nearby_sprites,			noone);
master_grid_add_spar_effect(SPAR_EFFECTS.SHIFT_CURSE_TEAM,					textGrid[# 1, SPAR_EFFECTS.SHIFT_CURSE_TEAM],					shift_curse_team,					noone);
master_grid_add_spar_effect(SPAR_EFFECTS.SHIFT_CURSE_GLOBAL,				textGrid[# 1, SPAR_EFFECTS.SHIFT_CURSE_GLOBAL],					shift_curse_global,					noone);
master_grid_add_spar_effect(SPAR_EFFECTS.SHIFT_BLESSING_NEARBY_ALLIES,		textGrid[# 1, SPAR_EFFECTS.SHIFT_BLESSING_NEARBY_ALLIES],		shift_blessing_nearby_allies,		noone);
master_grid_add_spar_effect(SPAR_EFFECTS.SHIFT_BLESSING_NEARBY_ENEMIES,		textGrid[# 1, SPAR_EFFECTS.SHIFT_BLESSING_NEARBY_ENEMIES],		shift_blessing_nearby_enemies,		noone);
master_grid_add_spar_effect(SPAR_EFFECTS.SHIFT_BLESSING_NEARBY_SPRITES,		textGrid[# 1, SPAR_EFFECTS.SHIFT_BLESSING_NEARBY_SPRITES],		shift_blessing_nearby_sprites,		noone);
master_grid_add_spar_effect(SPAR_EFFECTS.SHIFT_BLESSING_TEAM,				textGrid[# 1, SPAR_EFFECTS.SHIFT_BLESSING_TEAM],				shift_blessing_team,				noone);
master_grid_add_spar_effect(SPAR_EFFECTS.SHIFT_BLESSING_GLOBAL,				textGrid[# 1, SPAR_EFFECTS.SHIFT_BLESSING_GLOBAL],				shift_blessing_global,				noone);
master_grid_add_spar_effect(SPAR_EFFECTS.SET_HEXED_NEARBY_ALLIES,			textGrid[# 1, SPAR_EFFECTS.SET_HEXED_NEARBY_ALLIES],			set_hexed_nearby_allies,			noone);
master_grid_add_spar_effect(SPAR_EFFECTS.SET_HEXED_NEARBY_ENEMIES,			textGrid[# 1, SPAR_EFFECTS.SET_HEXED_NEARBY_ENEMIES],			set_hexed_nearby_enemies,			noone);
master_grid_add_spar_effect(SPAR_EFFECTS.SET_HEXED_NEARBY_SPRITES,			textGrid[# 1, SPAR_EFFECTS.SET_HEXED_NEARBY_SPRITES],			set_hexed_nearby_sprites,			noone);
master_grid_add_spar_effect(SPAR_EFFECTS.SET_HEXED_TEAM,					textGrid[# 1, SPAR_EFFECTS.SET_HEXED_TEAM],						set_hexed_team,						noone);
master_grid_add_spar_effect(SPAR_EFFECTS.SET_HEXED_GLOBAL,					textGrid[# 1, SPAR_EFFECTS.SET_HEXED_GLOBAL],					set_hexed_global,					noone);
master_grid_add_spar_effect(SPAR_EFFECTS.SET_BOUND_NEARBY_ALLIES,			textGrid[# 1, SPAR_EFFECTS.SET_BOUND_NEARBY_ALLIES],			set_bound_nearby_allies,			noone);
master_grid_add_spar_effect(SPAR_EFFECTS.SET_BOUND_NEARBY_ENEMIES,			textGrid[# 1, SPAR_EFFECTS.SET_BOUND_NEARBY_ENEMIES],			set_bound_nearby_enemies,			noone);
master_grid_add_spar_effect(SPAR_EFFECTS.SET_BOUND_NEARBY_SPRITES,			textGrid[# 1, SPAR_EFFECTS.SET_BOUND_NEARBY_SPRITES],			set_bound_nearby_sprites,			noone);
master_grid_add_spar_effect(SPAR_EFFECTS.SET_BOUND_TEAM,					textGrid[# 1, SPAR_EFFECTS.SET_BOUND_TEAM],						set_bound_team,						noone);
master_grid_add_spar_effect(SPAR_EFFECTS.SET_BOUND_GLOBAL,					textGrid[# 1, SPAR_EFFECTS.SET_BOUND_GLOBAL],					set_bound_global,					noone);
master_grid_add_spar_effect(SPAR_EFFECTS.APPLY_HEXED,						textGrid[# 1, SPAR_EFFECTS.APPLY_HEXED],						apply_hexed,						noone);
master_grid_add_spar_effect(SPAR_EFFECTS.APPLY_BOUND,						textGrid[# 1, SPAR_EFFECTS.APPLY_BOUND],						apply_bound,						noone);
master_grid_add_spar_effect(SPAR_EFFECTS.ENERGY_BLAST_GLOBAL,				textGrid[# 1, SPAR_EFFECTS.ENERGY_BLAST_GLOBAL],				energy_blast_global,				noone);
master_grid_add_spar_effect(SPAR_EFFECTS.RUST_INCREASE_PHYSICAL_DAMAGE,		textGrid[# 1, SPAR_EFFECTS.RUST_INCREASE_PHYSICAL_DAMAGE],		rust_increase_physical_damage,		noone);
master_grid_add_spar_effect(SPAR_EFFECTS.HUM_DECREASE_ELEMENTAL_DAMAGE,		textGrid[# 1, SPAR_EFFECTS.HUM_DECREASE_ELEMENTAL_DAMAGE],		hum_decrease_elemental_damage,		noone);
master_grid_add_spar_effect(SPAR_EFFECTS.INCREASE_DAMAGE_NATURAL,			textGrid[# 1, SPAR_EFFECTS.INCREASE_DAMAGE_NATURAL],			increase_damage_natural,			noone);
master_grid_add_spar_effect(SPAR_EFFECTS.DECREASE_DAMAGE_NATURAL,			textGrid[# 1, SPAR_EFFECTS.DECREASE_DAMAGE_NATURAL],			decrease_damage_natural,			noone);
master_grid_add_spar_effect(SPAR_EFFECTS.INCREASE_DAMAGE_MECHANICAL,		textGrid[# 1, SPAR_EFFECTS.INCREASE_DAMAGE_MECHANICAL],			increase_damage_mechanical,			noone);
master_grid_add_spar_effect(SPAR_EFFECTS.DECREASE_DAMAGE_MECHANICAL,		textGrid[# 1, SPAR_EFFECTS.DECREASE_DAMAGE_MECHANICAL],			decrease_damage_mechanical,			noone);
master_grid_add_spar_effect(SPAR_EFFECTS.INCREASE_DAMAGE_ASTRAL,			textGrid[# 1, SPAR_EFFECTS.INCREASE_DAMAGE_ASTRAL],				increase_damage_astral,				noone);
master_grid_add_spar_effect(SPAR_EFFECTS.DECREASE_DAMAGE_ASTRAL,			textGrid[# 1, SPAR_EFFECTS.DECREASE_DAMAGE_ASTRAL],				decrease_damage_astral,				noone);
master_grid_add_spar_effect(SPAR_EFFECTS.VOLCANO_WATER_DECREASE_DAMAGE,		textGrid[# 1, SPAR_EFFECTS.VOLCANO_WATER_DECREASE_DAMAGE],		volcano_water_decrease_damage,		noone);
master_grid_add_spar_effect(SPAR_EFFECTS.VOLCANO_FIRE_INCREASE_DAMAGE,		textGrid[# 1, SPAR_EFFECTS.VOLCANO_FIRE_INCREASE_DAMAGE],		volcano_fire_increase_damage,		noone);
master_grid_add_spar_effect(SPAR_EFFECTS.OCEAN_STORM_INCREASE_DAMAGE,		textGrid[# 1, SPAR_EFFECTS.OCEAN_STORM_INCREASE_DAMAGE],		ocean_storm_increase_damage,		noone);
master_grid_add_spar_effect(SPAR_EFFECTS.OCEAN_WATER_INCREASE_DAMAGE,		textGrid[# 1, SPAR_EFFECTS.OCEAN_WATER_INCREASE_DAMAGE],		ocean_water_increase_damage,		noone);
master_grid_add_spar_effect(SPAR_EFFECTS.STRATOS_EARTH_DECREASE_DAMAGE,		textGrid[# 1, SPAR_EFFECTS.STRATOS_EARTH_DECREASE_DAMAGE],		stratos_earth_decrease_damage,		noone);
master_grid_add_spar_effect(SPAR_EFFECTS.STRATOS_STORM_INCREASE_DAMAGE,		textGrid[# 1, SPAR_EFFECTS.STRATOS_STORM_INCREASE_DAMAGE],		stratos_storm_increase_damage,		noone);
master_grid_add_spar_effect(SPAR_EFFECTS.FOREST_FIRE_INCREASE_DAMAGE,		textGrid[# 1, SPAR_EFFECTS.FOREST_FIRE_INCREASE_DAMAGE],		forest_fire_increase_damage,		noone);
master_grid_add_spar_effect(SPAR_EFFECTS.FOREST_EARTH_INCREASE_DAMAGE,		textGrid[# 1, SPAR_EFFECTS.FOREST_EARTH_INCREASE_DAMAGE],		forest_earth_increase_damage,		noone);
master_grid_add_spar_effect(SPAR_EFFECTS.DESTROY_ARENA,						textGrid[# 1, SPAR_EFFECTS.DESTROY_ARENA],						destroy_arena,						noone);
master_grid_add_spar_effect(SPAR_EFFECTS.DRAIN_HEALTH,						textGrid[# 1, SPAR_EFFECTS.DRAIN_HEALTH],						drain_health,						noone);
master_grid_add_spar_effect(SPAR_EFFECTS.DRAIN_MAGIC,						textGrid[# 1, SPAR_EFFECTS.DRAIN_MAGIC],						drain_magic,						noone);
master_grid_add_spar_effect(SPAR_EFFECTS.REPLACE_TARGET,					textGrid[# 1, SPAR_EFFECTS.REPLACE_TARGET],						replace_target,						noone);
master_grid_add_spar_effect(SPAR_EFFECTS.BALL_LIGHTNING_SET_ACTIVE,			textGrid[# 1, SPAR_EFFECTS.BALL_LIGHTNING_SET_ACTIVE],			ball_lightning_set_active,			noone);
master_grid_add_spar_effect(SPAR_EFFECTS.BALL_LIGHTNING_ABSORB_SPELL,		textGrid[# 1, SPAR_EFFECTS.BALL_LIGHTNING_ABSORB_SPELL],		ball_lightning_absorb_spell,		noone);
master_grid_add_spar_effect(SPAR_EFFECTS.BALL_LIGHTNING_APPLY_DAMAGE,		textGrid[# 1, SPAR_EFFECTS.BALL_LIGHTNING_APPLY_DAMAGE],		ball_lightning_apply_damage,		noone);
master_grid_add_spar_effect(SPAR_EFFECTS.BLACK_HOLE_SET_ACTIVE,				textGrid[# 1, SPAR_EFFECTS.BLACK_HOLE_SET_ACTIVE],				black_hole_set_active,				noone);
master_grid_add_spar_effect(SPAR_EFFECTS.BLACK_HOLE_ABSORB_SPELL,			textGrid[# 1, SPAR_EFFECTS.BLACK_HOLE_ABSORB_SPELL],			black_hole_absorb_spell,			noone);
master_grid_add_spar_effect(SPAR_EFFECTS.BLACK_HOLE_APPLY_DAMAGE,			textGrid[# 1, SPAR_EFFECTS.BLACK_HOLE_APPLY_DAMAGE],			black_hole_apply_damage,			noone);
master_grid_add_spar_effect(SPAR_EFFECTS.APPLY_SELF_DAMAGE,					textGrid[# 1, SPAR_EFFECTS.APPLY_SELF_DAMAGE],					apply_self_damage,					noone);
master_grid_add_spar_effect(SPAR_EFFECTS.SET_BERSERK,						textGrid[# 1, SPAR_EFFECTS.SET_BERSERK],						set_berserk,						noone);
master_grid_add_spar_effect(SPAR_EFFECTS.SET_BERSERK_NEARBY_ALLIES,			textGrid[# 1, SPAR_EFFECTS.SET_BERSERK_NEARBY_ALLIES],			set_berserk_nearby_allies,			noone);
master_grid_add_spar_effect(SPAR_EFFECTS.SET_BERSERK_NEARBY_ENEMIES,		textGrid[# 1, SPAR_EFFECTS.SET_BERSERK_NEARBY_ENEMIES],			set_berserk_nearby_enemies,			noone);
master_grid_add_spar_effect(SPAR_EFFECTS.SET_BERSERK_NEARBY_SPRITES,		textGrid[# 1, SPAR_EFFECTS.SET_BERSERK_NEARBY_SPRITES],			set_berserk_nearby_sprites,			noone);
master_grid_add_spar_effect(SPAR_EFFECTS.SET_BERSERK_TEAM,					textGrid[# 1, SPAR_EFFECTS.SET_BERSERK_TEAM],					set_berserk_team,					noone);
master_grid_add_spar_effect(SPAR_EFFECTS.SET_BERSERK_GLOBAL,				textGrid[# 1, SPAR_EFFECTS.SET_BERSERK_GLOBAL],					set_berserk_global,					noone);
master_grid_add_spar_effect(SPAR_EFFECTS.SET_INVULNERABLE,					textGrid[# 1, SPAR_EFFECTS.SET_INVULNERABLE],					set_invulnerable,					noone);
master_grid_add_spar_effect(SPAR_EFFECTS.SET_INVULNERABLE_NEARBY_ALLIES,	textGrid[# 1, SPAR_EFFECTS.SET_INVULNERABLE_NEARBY_ALLIES],		set_invulnerable_nearby_allies,		noone);
master_grid_add_spar_effect(SPAR_EFFECTS.SET_INVULNERABLE_NEARBY_ENEMIES,	textGrid[# 1, SPAR_EFFECTS.SET_INVULNERABLE_NEARBY_ENEMIES],	set_invulnerable_nearby_enemies,	noone);
master_grid_add_spar_effect(SPAR_EFFECTS.SET_INVULNERABLE_NEARBY_SPRITES,	textGrid[# 1, SPAR_EFFECTS.SET_INVULNERABLE_NEARBY_SPRITES],	set_invulnerable_nearby_sprites,	noone);
master_grid_add_spar_effect(SPAR_EFFECTS.SET_INVULNERABLE_TEAM,				textGrid[# 1, SPAR_EFFECTS.SET_INVULNERABLE_TEAM],				set_invulnerable_team,				noone);
master_grid_add_spar_effect(SPAR_EFFECTS.SET_INVULNERABLE_GLOBAL,			textGrid[# 1, SPAR_EFFECTS.SET_INVULNERABLE_GLOBAL],			set_invulnerable_global,			noone);
master_grid_add_spar_effect(SPAR_EFFECTS.SKYDIVE_AVOID_DAMAGE,				textGrid[# 1, SPAR_EFFECTS.SKYDIVE_AVOID_DAMAGE],				skydive_avoid_damage,				noone);
master_grid_add_spar_effect(SPAR_EFFECTS.INVULNERABLE_AVOID_DAMAGE,			textGrid[# 1, SPAR_EFFECTS.INVULNERABLE_AVOID_DAMAGE],			invulnerable_avoid_damage,			noone);
master_grid_add_spar_effect(SPAR_EFFECTS.SET_PARRYING,						textGrid[# 1, SPAR_EFFECTS.SET_PARRYING],						set_parrying,						noone);
master_grid_add_spar_effect(SPAR_EFFECTS.APPLY_PARRY,						textGrid[# 1, SPAR_EFFECTS.APPLY_PARRY],						apply_parry,						noone);
master_grid_add_spar_effect(SPAR_EFFECTS.SET_DIVIDING,						textGrid[# 1, SPAR_EFFECTS.SET_DIVIDING],						set_dividing,						noone);
master_grid_add_spar_effect(SPAR_EFFECTS.SET_MULTIPLYING,					textGrid[# 1, SPAR_EFFECTS.SET_MULTIPLYING],					set_multiplying,					noone);
master_grid_add_spar_effect(SPAR_EFFECTS.DIVIDE_HEALING,					textGrid[# 1, SPAR_EFFECTS.DIVIDE_HEALING],						divide_healing,						noone);
master_grid_add_spar_effect(SPAR_EFFECTS.DIVIDE_DAMAGE,						textGrid[# 1, SPAR_EFFECTS.DIVIDE_DAMAGE],						divide_damage,						noone);
master_grid_add_spar_effect(SPAR_EFFECTS.MULTIPLY_HEALING,					textGrid[# 1, SPAR_EFFECTS.MULTIPLY_HEALING],					multiply_healing,					noone);
master_grid_add_spar_effect(SPAR_EFFECTS.MULTIPLY_DAMAGE,					textGrid[# 1, SPAR_EFFECTS.MULTIPLY_DAMAGE],					multiply_damage,					noone);
master_grid_add_spar_effect(SPAR_EFFECTS.SET_DEFLECTIVE,					textGrid[# 1, SPAR_EFFECTS.SET_DEFLECTIVE],						set_deflective,						noone);
master_grid_add_spar_effect(SPAR_EFFECTS.DEFLECT_SPELL,						textGrid[# 1, SPAR_EFFECTS.DEFLECT_SPELL],						deflect_spell,						noone);

#endregion

// encode the spar effect grid
global.allSparEffects = encode_grid(global.sparEffectGrid);

// delete the spar effect grid and the text grid
ds_grid_destroy(global.sparEffectGrid);
ds_grid_destroy(textGrid);