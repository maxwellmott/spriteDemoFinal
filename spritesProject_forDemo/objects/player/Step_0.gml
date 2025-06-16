event_inherited();

if (global.shiftPressed)
&& (keyboard_check_released(ord("Q"))) {
	appearance[| APPEARANCE_PARAMS.hairstyle] = hairstyles.shortMessy;
	appearance[| APPEARANCE_PARAMS.hairColor] = COLORS.DYNOCTA_PINK;
	appearanceLoaded = false;
}

#region OVERWORLD MOVEMENT AND INTERACTION
if (instance_exists(overworld)) 
&& !(instance_exists(menu)) {
	if !(appearanceLoaded) {
		player_load_appearance();
	}
	
	if (state == humanStates.standard) {
		player_move(); 
	}
	
	player_set_draw_position();
	
	human_check_moving();
	if moving human_set_facing();
	
	player_set_frames();
	
	if (state == humanStates.standard)	{
		if moving {
			animate_human();
		}	
		else {frame = minFrame;}
	}
	else {animate_human();}	
	
	if (swimming)	human_swim();
	if !(swimming)	human_walk();		
	human_set_depth();
	
	if (global.select) interact();
}
#endregion

if (instance_exists(overworld)) {
#region HANDLE TIME
	if !(instance_exists(menu)) 
	|| (instance_exists(mainMenu)) {
		increment_seconds();
		increment_minutes();
		increment_hours();
	
		begin_day_change();
	}
#endregion

#region HANDLE SUNDOWN AND DARKALPHA
	if (overworld.outdoorLocation) {
		set_dark();
	}	else	{indoor_set_dark();}


	if (sundown) && (darkAlpha < 1.0)	darkAlpha += 0.0005;
	if !(sundown) && (darkAlpha > 0.0)	darkAlpha -= 0.0005;
}

#endregion

if (instance_exists(overworld))
&& !(instance_exists(menu)) {	
	if (global.start)		{
		open_main_menu();
	}
	
	if (global.rightBumper) {
		open_emote_menu();
	}
	
	if (global.leftBumper) 
	&& !(global.rightBumper) {
		open_cube_menu();
	}
}

// FOR TESTING ONLY!!!
if (instance_exists(overworld)) {
	if !(instance_exists(menu)) {
		if (global.shiftPressed)
		&& (global.select) {
			global.opponent = npcs.mercurioGallant;
			spar_begin_ingame();
		}
	}
}