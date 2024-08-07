event_inherited();

if !(appearanceLoaded) {
	player_load_appearance();	
}

#region OVERWORLD MOVEMENT AND INTERACTION
// get appearance variables

visible = global.overworld;

if (global.overworld) {
	player_move(); 
	
	player_set_draw_position();
	
	human_check_moving();
	if moving human_set_facing();
	
	player_set_frames();
	
	if (state = humanStates.standard)	{
		if moving {
			animate_human();
		}	
		else {frame = minFrame;}
	}
	else {animate_human();}	
	
	if (swimming)	human_swim();
	if !(swimming)	human_walk();
	human_pointer_set();			
	human_set_depth();
	
	if (global.select) interact();
}
#endregion

if (instance_exists(overworld)) {
#region HANDLE TIME
	increment_seconds();
	increment_minutes();
	increment_hours();
	
	begin_day_change();
#endregion

#region HANDLE SUNDOWN AND DARKALPHA
	if (overworld.outdoorLocation) {
		set_dark();
	}	else	{indoor_set_dark();}


	if (sundown) && (darkAlpha < 1.0)	darkAlpha += 0.0005;
	if !(sundown) && (darkAlpha > 0.0)	darkAlpha -= 0.0005;
}

#endregion

// for debugging only
if (global.overworld)	{	
	if (global.shiftPressed)	{	
		if (global.start)		{
			room_transition(x, y, facing, rm_teambuilder);	
		}
	
		if (global.back)		{
			room_transition(x, y, facing, rm_spellbookBuilder);
		}
	}	
	else	{
	 	if (global.start)		{
	 		global.opponent = npcs.mercurioGallant;
			spar_begin_ingame();
	 	}
	 
	 	if (global.back)		{
	 		room_transition(x, y, facing, rm_onlineLobby);
	 	}
	 }
}