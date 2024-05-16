event_inherited();

/*
#region OVERWORLD MOVEMENT AND INTERACTION
// get appearance variables

visible = global.overworld;

if (instance_exists(overworld)) {
	if !appearanceLoaded && global.roomBuilt	player_get_sprites();
	if appearanceLoaded && global.roomBuilt		human_set_sprite();
}

if (global.overworld) {
	player_move(); 
	
	human_check_moving();
	if moving human_set_facing();
	
	human_set_frames();
	
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

	if (global.start) {
		if !(instance_exists(soulStone)) {open_soulStone();}
	}
	
	if (global.select) interact();
}
#endregion

#region HANDLE TIME
	increment_seconds();
	increment_minutes();
	increment_hours();
	
	begin_day_change();
#endregion

#region HANDLE SUNDOWN AND DARKALPHA
if (instance_exists(overworld)) {
	if (overworld.outdoorLocation) {
		set_dark();
	}	else	{indoor_set_dark();}
}


if (sundown) && (darkAlpha < 1.0)	darkAlpha += 0.0005;
if !(sundown) && (darkAlpha > 0.0)	darkAlpha -= 0.0005;
	
#endregion

*/