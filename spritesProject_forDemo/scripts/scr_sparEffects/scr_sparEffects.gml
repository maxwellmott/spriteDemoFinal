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
	BESTOW_MINDSET_SELF,
	BESTOW_MINDSET_TARGET,
	BESTOW_MINDSET_NEARBY_ALLIES,
	BESTOW_MINDSET_NEARBY_ENEMIES,
	BESTOW_MINDSET_ALL_NEARBY,
	BESTOW_MINDSET_ALL_ALLIES,
	BESTOW_MINDSET_ALL_ENEMIES,
	BESTOW_MINDSET_GLOBAL,
	SHIFT_MINDSET_SELF,
	SHIFT_MINDSET_TARGET,
	SHIFT_MINDSET_NEARBY_ALLIES,
	SHIFT_MINDSET_NEARBY_ENEMIES,
	SHIFT_MINDSET_ALL_NEARBY,
	SHIFT_MINDSET_ALL_ALLIES,
	SHIFT_MINDSET_ALL_ENEMIES,
	SHIFT_MINDSET_GLOBAL,
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
	BLESS_TO_CURSE_SELF,
	BLESS_TO_CURSE_TARGET,
	BLESS_TO_CURSE_NEARBY_ALLIES,
	BLESS_TO_CURSE_NEARBY_ENEMIES,
	BLESS_TO_CURSE_ALL_NEARBY,
	BLESS_TO_CURSE_ALL_ALLIES,
	BLESS_TO_CURSE_ALL_ENEMIES,
	BLESS_TO_CURSE_GLOBAL,
	CURSE_TO_BLESS_SELF,
	CURSE_TO_BLESS_TARGET,
	CURSE_TO_BLESS_NEARBY_ALLIES,
	CURSE_TO_BLESS_NEARBY_ENEMIES,
	CURSE_TO_BLESS_ALL_NEARBY,
	CURSE_TO_BLESS_ALL_ALLIES,
	CURSE_TO_BLESS_ALL_ENEMIES,
	CURSE_TO_BLESS_GLOBAL,
	WARRIOR_BLESS_SELF,
	WARRIOR_BLESS_TARGET,
	WARRIOR_BLESS_NEARBY_ALLIES,
	WARRIOR_BLESS_NEARBY_ENEMIES,
	WARRIOR_BLESS_ALL_NEARBY,
	WARRIOR_BLESS_ALL_ALLIES,
	WARRIOR_BLESS_ALL_ENEMIES,
	WARRIOR_BLESS_GLOBAL,
	WARRIOR_CURSE_SELF,
	WARRIOR_CURSE_TARGET,
	WARRIOR_CURSE_NEARBY_ALLIES,
	WARRIOR_CURSE_NEARBY_ENEMIES,
	WARRIOR_CURSE_ALL_NEARBY,
	WARRIOR_CURSE_ALL_ALLIES,
	WARRIOR_CURSE_ALL_ENEMIES,
	WARRIOR_CURSE_GLOBAL,
	MOTHER_BLESS_SELF,
	MOTHER_BLESS_TARGET,
	MOTHER_BLESS_NEARBY_ALLIES,
	MOTHER_BLESS_NEARBY_ENEMIES,
	MOTHER_BLESS_ALL_NEARBY,
	MOTHER_BLESS_ALL_ALLIES,
	MOTHER_BLESS_ALL_ENEMIES,
	MOTHER_BLESS_GLOBAL,
	MOTHER_CURSE_SELF,
	MOTHER_CURSE_TARGET,
	MOTHER_CURSE_NEARBY_ALLIES,
	MOTHER_CURSE_NEARBY_ENEMIES,
	MOTHER_CURSE_ALL_NEARBY,
	MOTHER_CURSE_ALL_ALLIES,
	MOTHER_CURSE_ALL_ENEMIES,
	MOTHER_CURSE_GLOBAL,
	TREE_BLESS_SELF,
	TREE_BLESS_TARGET,
	TREE_BLESS_NEARBY_ALLIES,
	TREE_BLESS_NEARBY_ENEMIES,
	TREE_BLESS_ALL_NEARBY,
	TREE_BLESS_ALL_ALLIES,
	TREE_BLESS_ALL_ENEMIES,
	TREE_BLESS_GLOBAL,
	TREE_CURSE_SELF,
	TREE_CURSE_TARGET,
	TREE_CURSE_NEARBY_ALLIES,
	TREE_CURSE_NEARBY_ENEMIES,
	TREE_CURSE_ALL_NEARBY,
	TREE_CURSE_ALL_ALLIES,
	TREE_CURSE_ALL_ENEMIES,
	TREE_CURSE_GLOBAL,
	IMP_BLESS_SELF,
	IMP_BLESS_TARGET,
	IMP_BLESS_NEARBY_ALLIES,
	IMP_BLESS_NEARBY_ENEMIES,
	IMP_BLESS_ALL_NEARBY,
	IMP_BLESS_ALL_ALLIES,
	IMP_BLESS_ALL_ENEMIES,
	IMP_BLESS_GLOBAL,
	IMP_CURSE_SELF,
	IMP_CURSE_TARGET,
	IMP_CURSE_NEARBY_ALLIES,
	IMP_CURSE_NEARBY_ENEMIES,
	IMP_CURSE_ALL_NEARBY,
	IMP_CURSE_ALL_ALLIES,
	IMP_CURSE_ALL_ENEMIES,
	IMP_CURSE_GLOBAL,
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

/// argument[0] = sprite using the effect
function set_miasma_enemy() {
	var user = global.argumentList[| 0];
	
	user.enemy.miasma = true;
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

function bestow_mindset_self() {
	
}

function bestow_mindset_target() {
	
}

function bestow_mindset_nearby_allies() {
	
}

function bestow_mindset_nearby_enemies() {
	
}

function bestow_mindset_all_nearby() {
	
}

function bestow_mindset_all_allies() {
	
}

function bestow_mindset_all_enemies() {
	
}

function bestow_mindset_global() {
	
}

function shift_mindset_self() {
	
}

function shift_mindset_target() {
	
}

function shift_mindset_nearby_allies() {
	
}

function shift_mindset_nearby_enemies() {
	
}

function shift_mindset_all_nearby() {
	
}

function shift_mindset_all_allies() {
	
}

function shift_mindset_all_enemies() {
	
}

function shift_mindset_global() {
	
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

function bless_to_curse_self() {
	
}

function bless_to_curse_target() {
	
}

function bless_to_curse_nearby_allies() {
	
}

function bless_to_curse_nearby_enemies() {
	
}

function bless_to_curse_all_nearby() {
	
}

function bless_to_curse_all_allies() {
	
}

function bless_to_curse_all_enemies() {
	
}

function bless_to_curse_global() {
	
}

function curse_to_bless_self() {
	
}

function curse_to_bless_target() {
	
}

function curse_to_bless_nearby_allies() {
	
}

function curse_to_bless_nearby_enemies() {
	
}

function curse_to_bless_all_nearby() {
	
}

function curse_to_bless_all_allies() {
	
}

function curse_to_bless_all_enemies() {
	
}

function curse_to_bless_global() {
	
}