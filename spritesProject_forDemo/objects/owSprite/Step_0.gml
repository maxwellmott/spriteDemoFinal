
if !(loaded) {
	if (ID != -1) {
		overworld_character_load_parameters();
	}
}

if (loaded) {
	if !(instance_exists(menu)) {
		behaviorFunction();
		overworld_character_state_machine();
		overworld_sprite_manage_moving();
		overworld_sprite_animate();
		overworld_character_get_draw_position();
		overworld_character_set_depthY();
		overworld_character_set_depth();
	}
}