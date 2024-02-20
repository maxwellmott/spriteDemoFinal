enum HINDRANCES {
	MIASMA,
	HUM,
	RUST,
	HEIGHT
}

enum MINDSETS {
	MOTHER,
	WARRIOR,
	IMP,
	TREE,
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