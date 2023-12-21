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
	target.team.miasma = true;
}

function set_miasma_self() {
	actor.team.miasma = true;
}

function set_miasma_global() {
	set_miasma_enemy();
	set_miasma_self();
}

function set_hum_enemy() {
	actor.team.enemy.hum = true;
}

function set_hum_self() {
	actor.team.hum = true;
}

function set_hum_global() {
	set_hum_enemy();
	set_hum_self();
}

function set_rust_enemy() {
	actor.enemy.rust = true;
}

function set_rust_self() {
	actor.team.rust = true;
}

function set_rust_global() {
	set_rust_enemy();
	set_rust_self();
}

function energy_blast() {
	
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