/// @desc

event_inherited();

if !(parametersLoaded) && (ID >= 0) {
	npc_load_parameters(ID);
}

if (parametersLoaded) {
	if (instance_exists(overworld)) {
		npc_set_sprite();
		
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
	}
}

human_set_depth();

