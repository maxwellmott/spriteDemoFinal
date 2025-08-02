/// @desc

/// IMPORTANT NOTE ABT NPCS
/// THE DECISION TO TRANSPORT TO A NEW LOCATION SHOULD COME AS
/// AN ACTION INDICATED ON THE NPCS PATH LIST. THIS SHOULD ALWAYS
/// OCCUR WHEN THE NPC HAS REACHED THE GIVEN MEANS OF TRANSPORT (DOOR,
/// STAIRWAY, EDGE OF SCREEN, ETC)

event_inherited();

if !(parametersLoaded) && (ID >= 0) {
	npc_load_parameters(ID);
}

if (parametersLoaded) {
	if (instance_exists(overworld)) {
		npc_set_sprite();
		
		if !(instance_exists(menu)) {
			behaviorFunction();
			overworld_character_state_machine();
			npc_animate();
			overworld_character_get_draw_position();
			overworld_character_set_depthY();
			overworld_character_set_depth();
		}
	}
}

human_set_depth();

