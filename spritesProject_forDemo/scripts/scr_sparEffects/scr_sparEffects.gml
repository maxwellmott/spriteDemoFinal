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

function arena_change_volcano() {
	spar.currentArena = arenas.volcano;
}

function arena_change_ocean() {
	spar.currentArena = arenas.ocean;
}

function arena_change_stratos() {
	spar.currentArena = arenas.stratosphere;
}

function arena_change_forest() {
	spar.currentArena = arenas.forest;
}

function arena_change_normal() {
	spar.currentArena = -1;
}

function set_miasma(_targetPlayer) {	
	var t = _targetPlayer;
	
	t.miasma = true;
}

function set_hum(_targetPlayer) {
	var t = _targetPlayer;
	
	t.hum = true;
}

function set_rust(_targetPlayer) {
	var t = _targetPlayer;
	
	t.rust = true;
}

function energy_blast(_targetPlayer, _damage) {
	var t = _targetPlayer;
	var d = _damage;
	
	t.currentHP -= d;
}

function bestow_mindset(_target, _mindset) {
	var t = _target;
	var m = _mindset;
	
	t.mindset = m;
}

function shift_mindset(_target) {
	var t = _target;

	if (t.mindset > 0) {
		t.mindset = 0 - t.mindset;
		// return -1 for switching to curse
		return -1;
	}
	if (t.mindset < 0) {
		t.mindset = 0 - t.mindset;
		// return 1 for switching to blessing
		return 1;
	}
}

function copy_mindset(_caster, _target) {
	var c = _caster;
	var t = _target;
	
	c.mindset = t.mindset;
}

function restore_mp(_targetPlayer, _amount) {
	var t = _targetPlayer;
	var a = round(_amount);
	
	var mpNeeded = MAX_MP - t.currentMP;
	
	if (a >= mpNeeded)	t.currentMP = MAX_MP;
	else				t.currentMP += a;
}

function restore_hp(_targetPlayer, _amount) {
	var t = _targetPlayer;
	var a = round(_amount);
	
	var hpNeeded = MAX_HP - t.currentHP;
	
	if (a >= hpNeeded)	t.currentHP = MAX_HP;
	else				t.currentHP += a;
}

function deplete_hp(_targetPlayer, _amount) {
	var t = _targetPlayer;
	var a = round(_amount);
	
	var hpLeft = t.currentHP;
	
	if (a >= hpLeft)	t.currentHP = 0;
	else				t.currentHP -= a;
}

function deplete_mp(_targetPlayer, _amount) {
	var t = _targetPlayer;
	var a = round(_amount);
	
	var mpLeft = t.currentMP;
	
	if (a >= mpLeft)	return -1;
	else				t.currentMP -= a;
}

function deplete_hp_nonlethal(_targetPlayer, _amount) {
	var t = _targetPlayer;
	var a = round(_amount);
	
	var hpLeft = t.currentHP;
	
	if (a >= hpLeft)	t.currentHP = 1;
	else				t.currentHP -= a;
}

function set_bound(_target) {
	var t = _target;
	
	t.bound = true;
}

function set_hexed(_target) {
	var t = _target;
	
	t.hexed = true;
}

function remove_bound(_target) {
	var t = _target;
	
	t.bound = false;
}

function remove_hexed(_target) {
	var t = _target;
	
	t.hexed  = false;
}

function clear_miasma(_targetPlayer) {
	var t = _targetPlayer;
	
	t.miasma = false;
}

function clear_hum(_targetPlayer) {
	var t = _targetPlayer;
	
	t.hum = false;
}

function clear_rust(_targetPlayer) {
	var t = _targetPlayer;
	
	t.rust = false;
}

function clear_mindset(_target) {
	var t = _target;
	
	t.mindset = 0;
}
	
function fully_restore_hp(_targetPlayer) {
	var t = _targetPlayer;
	
	t.currentHP = MAX_HP;
}

function fully_restore_mp(_targetPlayer) {
	var t = _targetPlayer;
	
	t.currentMP = MAX_MP;
}
	
function grid_add_skydive(_caster, _target) {
	var c = _caster;
	var t = _target;
	
	// resize grid
	ds_grid_resize(spar.skydiveGrid, 2, spar.skydiveCount + 1);
	
	// add values
	spar.skydiveGrid[# 0, spar.skydiveCount]	= c;
	spar.skydiveGrid[# 1, spar.skydiveCount]	= t;
	
	// increment skydive count
	spar.skydiveCount++;
}
	
function grid_add_sneak_attack(_caster, _target) {
	var c = _caster;
	var t = _target;
	
	// resize grid
	ds_grid_resize(spar.sneakAttackGrid, 2, spar.sneakAttackCount + 1);
	
	// add values
	spar.sneakAttackGrid[# 0, spar.sneakAttackCount]	= c;
	spar.sneakAttackGrid[# 0, spar.sneakAttackCount]	= t;
	
	// increment sneak attack count
	spar.sneakAttackCount++;
}
	
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

function clear_team_hindrances(_team) {
	
}

function clear_all_hindrances() {
	
}

function blast_timer_go_off(_blastNum) {
	
}

function blast_timers_decrement_count() {
	
}

function apply_miasma(_effectedTeam) {
	
}

function apply_hum(_activeSprite) {
	
}

function apply_rust(_targetSprite) {
	
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