enum SPAR_EFFECTS {
	ARENA_CHANGE_VOLCANO,
	ARENA_CHANGE_OCEAN,
	ARENA_CHANGE_STRATOS,
	ARENA_CHANGE_FOREST,
	ARENA_CHANGE_NORMAL,
	SET_MIASMA_ENEMY,
	SET_MIASMA_SELF,
	SET_MIASMA_GLOBAL,
	SET_HUM_ENEMY,
	SET_HUM_SELF,
	SET_HUM_GLOBAL,
	SET_RUST_ENEMY,
	SET_RUST_SELF,
	SET_RUST_GLOBAL,
	ENERGY_BLAST_ENEMY,
	ENERGY_BLAST_SELF,
	ENERGY_BLAST_GLOBAL,
	TIMED_BLAST_ENEMY,
	TIMED_BLAST_SELF,
	TIMED_BLAST_GLOBAL,
	BESTOW_MINDSET,
	SHIFT_MINDSET,
	COPY_MINDSET,
	STEAL_MP,
	STEAL_HP,
	DRAIN_MP,
	DRAIN_HP,
	RESTORE_MP,
	RESTORE_HP,
	SET_BOUND,
	SET_BOUND_NEARBY_ALLIES,
	SET_BOUND_NEARBY_ENEMIES,
	SET_BOUND_ALL_NEARBY,
	SET_BOUND_ENEMY,
	SET_BOUND_SELF,
	SET_BOUND_GLOBAL,
	SET_HEXED,
	SET_HEXED_NEARBY_ALLIES,
	SET_HEXED_NEARBY_ENEMIES,
	SET_HEXED_ALL_NEARBY,
	SET_HEXED_ENEMY,
	SET_HEXED_SELF,
	SET_HEXED_GLOBAL,
	REMOVE_BOUND,
	REMOVE_BOUND_NEARBY_ALLIES,
	REMOVE_BOUND_ALL_NEARBY,
	REMOVE_BOUND_SELF,
	REMOVE_BOUND_GLOBAL,
	REMOVE_HEXED,
	REMOVE_HEXED_NEARBY_ALLIES,
	REMOVE_HEXED_ALL_NEARBY,
	REMOVE_HEXED_SELF,
	REMOVE_HEXED_GLOBAL,
	CLEAR_MIASMA_SELF,
	CLEAR_MIASMA_GLOBAL,
	CLEAR_HUM_SELF,
	CLEAR_HUM_GLOBAL,
	CLEAR_RUST_SELF,
	CLEAR_RUST_GLOBAL,
	CLEAR_HINDRANCES_SELF,
	CLEAR_HINDRANCES_GLOBAL,
	CLEAR_MINDSETS_NEARBY_ALLIES,
	CLEAR_MINDSETS_ALL_NEARBY,
	CLEAR_MINDSETS_SELF,
	CLEAR_MINDSETS_GLOBAL,
	SHIFT_CURSES_NEARBY_ALLIES,
	SHIFT_CURSES_ALL_NEARBY,
	SHIFT_CURSES_SELF,
	SHIFT_CURSES_GLOBAL,
	HEIGHT
}

global.argumentList = ds_list_create();

///@desc This function says it only takes one argument (the ID of a function to call),
/// but it is actually intended to be overloaded. The excess arguments will be placed
/// on a list called global.argumentList. They will then be gotten from that list by
/// the function given as the first argument.
function execute_arguments(_function) {
	// get the number of arguments
	var c = argument_count;
	
	// clear argumentList just in case
	ds_list_clear(global.argumentList);
	
	// starting at 1 (argument 0 is the function to call)
	var i = 1;	repeat (c - 1) {
		// add the next argumetn to the argumentList
		global.argumentList[| i - 1] = argument[i];
		
		// increment i
		i++;
	}
	
	// call the given function
	_function();
	
	// clear argumentList
	ds_list_clear(global.argumentList);
}

function arena_change_volcano() {
	spar.currentArena = arenas.volcano;
	
	spar.sparMsg = "THE ARENA BECAME SCORCHING HOT LIKE A VOLCANO";
}

function arena_change_ocean() {
	spar.currentArena = arenas.ocean;
	
	spar.sparMsg = "THE ARENA BECAME VAST AND WATER LIKE THE OCEAN";
}

function arena_change_stratos() {
	spar.currentArena = arenas.stratosphere;
	
	spar.sparMsg = "THE ARENA BECAME CLOUDY AND LIGHT LIKE THE STRATOSPHERE";
}

function arena_change_forest() {
	spar.currentArena = arenas.forest;
	
	spar.sparMsg = "THE ARENA BECAME DENSE AND EARTHY LIKE THE FOREST";
}

function arena_change_normal() {
	spar.currentArena = -1;
	
	spar.sparMsg = "THE ARENA RETURNED TO ITS NORMAL STATE";
}

/// argument[0] = sprite using the effect
function set_miasma_enemy() {
	var user = global.argumentList[| 0];
	
	user.enemy.miasma = true;
	
	spar.sparMsg = string(spar.selfTwo.name) + "'S SIDE OF THE ARENA BECAME COVERED WITH A TOXIC MIASMA";
}

function set_miasma_self() {

}

function set_miasma_global() {
	
}

function set_hum_enemy() {
	
}

function set_hum_self() {
	
}

function set_hum_global() {
	
}

function set_rust_enemy() {
	
}

function set_rust_self() {
	
}

function set_rust_global() {
	
}

function energy_blast_enemy() {
	
}

function energy_blast_self() {
	
}

function energy_blast_global() {
	
}

function timed_blast_enemy() {
	
}

function timed_blast_self() {
	
}

function timed_blast_global() {
	
}

function bestow_mindset() {
	
}

function shift_mindset() {
	
}

function copy_mindset() {
	
}

function steal_mp() {
	
}

function steal_hp() {
	
}

function drain_mp() {
	
}

function drain_hp() {
	
}

function restore_mp() {
	
}

function restore_hp() {
	
}

function set_bound() {
	
}

function set_bound_nearby_allies() {
	
}

function set_bound_nearby_enemies() {
	
}

function set_bound_all_nearby() {
	
}

function set_bound_enemy() {
	
}

function set_bound_self() {
	
}

function set_bound_global() {
	
}

function set_hexed() {
	
}

function set_hexed_nearby_allies() {
	
}

function set_hexed_nearby_enemies() {
	
}

function set_hexed_all_nearby() {
	
}

function set_hexed_enemy() {
	
}

function set_hexed_self() {
	
}

function set_hexed_global() {
	
}

function remove_bound() {
	
}

function remove_bound_nearby_allies() {
	
}

function remove_bound_all_nearby() {
	
}

function remove_bound_self() {
	
}

function remove_bound_global() {
	
}

function remove_hexed() {
	
}

function remove_hexed_nearby_allies() {
	
}

function remove_hexed_all_nearby() {
	
}

function remove_hexed_self() {
	
}

function remove_hexed_global() {
	
}

function clear_miasma_self() {
	
}

function clear_miasma_global() {
	
}

function clear_hum_self() {
	
}

function clear_hum_global() {
	
}

function clear_rust_self() {
	
}

function clear_rust_global() {
	
}

function clear_hindrances_self() {
	
}

function clear_hindrances_global() {
	
}

function clear_mindsets_nearby_allies() {
	
}

function clear_mindsets_all_nearby() {
	
}

function clear_mindsets_self() {
	
}

function clear_mindsets_global() {
	
}

function shift_curses_nearby_allies() {
	
}

function shift_curses_all_nearby() {
	
}

function shift_curses_self() {
	
}

function shift_curses_global() {
	
}