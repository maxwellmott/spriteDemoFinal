/// @desc

event_inherited();

visible = global.overworld;

if !(parametersLoaded) && (ID >= 0) {
	npc_load_parameters(ID);
}

if (parametersLoaded) {
	if (instance_exists(overworld)) {
		human_set_sprite();
		
		// manage animation
		if (state = humanStates.standard)	{
			if moving {
				animate_human();
			}	
			else {frame = minFrame;}
		}
		else {animate_human();}		
		
		human_check_moving();
		if moving human_set_facing();
		
		if swimming human_swim();
		if !swimming human_walk();
		human_pointer_set();
		
		human_set_shadow_y();
	}
}

human_set_depth();

