
if !(loaded) {
	if (ID != -1) {
		overworld_sprite_load_parameters();	
	}
}

if (loaded) {
	if !(instance_exists(menu)) {
		behaviorFunction();
		overworld_sprite_state_machine();
		overworld_sprite_manage_moving();
		overworld_sprite_animate();
		overworld_sprite_get_draw_position();
		overworld_sprite_set_depthY();
		overworld_sprite_set_depth();
	}
}