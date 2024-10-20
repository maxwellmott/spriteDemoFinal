#macro playerStartX			128
#macro playerStartY			128
#macro playerStartFacing	directions.south

// interactions enum
enum interactions {
	swimStart,
	swimStop,
	doorCheck,
	talk,
	read,
	sendport,
	height
}

///@desc This function is called whenever the player is loaded or changes outfit.
/// the function stores the value for each appearance parameter in the proper variable
function player_load_appearance() {
	var list = ds_list_create();
	
	decode_list(appearance, list);
	
	// ensure that none of the parameters are undefined,
	// and convert them all to reals
	var i = 0;	repeat (ds_list_size(list)) {
		if (list[| i] != "-1")
		&& (list[| i] != -1) {
			list[| i] = real(list[| i]);
		}
		else {
			list[| i] = -1;	
		}
		
		i++;
	}
	
	// load color list
	var cl = ds_list_create();
	
	decode_list(global.allColors, cl);
	
	// get all parameters
	skintone		= list[| appearanceParams.skintone];
	outfit			= list[| appearanceParams.outfit];
	outfitColor		= list[| appearanceParams.outfitColor];
	hairstyle		= list[| appearanceParams.hairstyle];
	hairColor		= list[| appearanceParams.hairColor];
	hat				= list[| appearanceParams.hat];
	hatColor		= list[| appearanceParams.hatColor];
	shoes			= list[| appearanceParams.shoes];
	shoeColor		= list[| appearanceParams.shoeColor];
	accessory		= list[| appearanceParams.accessory];
	accessoryColor	= list[| appearanceParams.accessoryColor];
	
	// get all colors from color list using colorIDs
	skintone		= cl[| skintone];
	outfitColor		= cl[| outfitColor];
	hairColor		= cl[| hairColor];
	hatColor		= cl[| hatColor];
	shoeColor		= cl[| shoeColor];
	accessoryColor	= cl[| accessoryColor];
	
	// destroy temp lists
	ds_list_destroy(list);
	ds_list_destroy(cl);
}

function player_set_draw_position() {
	drawX = x - 12;
	drawY = y - 21;
}

///@desc This function is called in the player step event while in the overworld. The
/// function sets the player's min and max frame to be used for looping the current
/// animation depending on the player's state (walk cycle, eating animation, etc)
function player_set_frames() {
	switch (state) {
		case humanStates.standard:
			minFrame = 0;
			maxFrame = 3;
		break;
		
		case humanStates.eating:
			minFrame = 0;
			maxFrame = 7;
		break;
		
		case humanStates.drinking:
			minFrame = 0;
			maxFrame = 7;
			
		case humanStates.meditating:
			minFrame = 0;
			maxFrame = 0;
		break;
		
		case humanStates.playingWavephone:
			minFrame = 0;
			maxFrame = 7;
		break;
	}
}

///@desc This function is called by the player_draw_from_state function when drawing
/// the player in the human draw event, while in the overworld. The function draws the
/// player in their standard state (walking)
function draw_standard_player(_skintone, _outfit, _outfitColor, _hair, _hairColor, _hat, _hatColor, _shoes, _shoeColor, _accessory, _accColor) {
	draw_sprite_part_ext(humanBody,		0, (facing * (humanSpriteWidth * 4)) + (frame * humanSpriteWidth),	0,								humanSpriteWidth, humanSpriteHeight, drawX, drawY, 1, 1, _skintone,		1.0);
	draw_sprite_part_ext(outfitSheet,	0, (facing * (humanSpriteWidth * 4)) + (frame * humanSpriteWidth),	humanSheetHeight * _outfit,		humanSpriteWidth, humanSpriteHeight, drawX, drawY, 1, 1, _outfitColor,	1.0);
	draw_sprite_part_ext(hairSheet,		0, (facing * (humanSpriteWidth * 4)) + (frame * humanSpriteWidth),	humanSheetHeight * _hair,		humanSpriteWidth, humanSpriteHeight, drawX, drawY, 1, 1, _hairColor,	1.0);
	draw_sprite_part_ext(hatSheet,		0, (facing * (humanSpriteWidth * 4)) + (frame * humanSpriteWidth),	humanSheetHeight * _hat,		humanSpriteWidth, humanSpriteHeight, drawX, drawY, 1, 1, _hatColor,		1.0);
	draw_sprite_part_ext(shoeSheet,		0, (facing * (humanSpriteWidth * 4)) + (frame * humanSpriteWidth),	humanSheetHeight * _shoes,		humanSpriteWidth, humanSpriteHeight, drawX, drawY, 1, 1, _shoeColor,	1.0);
	//draw_sprite_part_ext(accessorySheet,0, (facing * (humanSpriteWidth * 4)) + (frame * humanSpriteWidth),	humanSheetHeight * _accessory,	humanSpriteWidth, humanSpriteHeight, drawX, drawY, 1, 1, _accColor,	1.0);
}

///@desc This function is called by the player_draw_from_state function when drawing
/// the player in the human draw event, while in the overworld. The function draws the
/// player's eating animation
function draw_eating_player(_skintone, _outfit, _outfitColor, _hair, _hairColor, _hat, _hatColor, _shoes, _shoeColor, _accessory, _accColor) {
}

///@desc This function is called by the player_draw_from_state function when drawing
/// the player in the human draw event, while in the overworld. The function draws the
/// player's eating animation
function draw_drinking_player(_skintone, _outfit, _outfitColor, _hair, _hairColor, _hat, _hatColor, _shoes, _shoeColor, _accessory, _accColor) {	
}

///@desc This function is called by the player_draw_from_state function when drawing
/// the player in the human draw event, while in the overworld. The function draws the
/// player's wavephone animation
function draw_wavephone_player(_skintone, _outfit, _outfitColor, _hair, _hairColor, _hat, _hatColor, _shoes, _shoeColor, _accessory, _accColor) {	
	draw_sprite_part_ext(wavephoneHumanBody,	frame,	0,									facing * humanSpriteHeight,		24,	42, drawX, drawY, 1, 1, _skintone,		1.0);
	draw_sprite_part_ext(outfitSheet,			0,		facing * (humanSpriteWidth * 4),	humanSheetHeight * _outfit,		24, 42, drawX, drawY, 1, 1, _outfitColor,	1.0);
	draw_sprite_part_ext(hairSheet,				0,		facing * (humanSpriteWidth * 4),	humanSheetHeight * _hair,		24, 42, drawX, drawY, 1, 1, _hairColor,		1.0);
	draw_sprite_part_ext(hatSheet,				0,		facing * (humanSpriteWidth * 4),	humanSheetHeight * _hat,		24, 42, drawX, drawY, 1, 1, _hatColor,		1.0);
	draw_sprite_part_ext(shoeSheet,				0,		facing * (humanSpriteWidth * 4),	humanSheetHeight * _shoes,		24, 42, drawX, drawY, 1, 1, _shoeColor,		1.0);
	//draw_sprite_part_ext(accessorySheet,		0,		facing * (humanSpriteWidth * 4),	humanSheetHeight * _accessory,	24, 42, drawX, drawY, 1, 1, _accColor,		1.0);
	draw_sprite_part_ext(wavephoneSheet,		frame,	0,									facing * humanSpriteHeight,		24, 42, drawX, drawY, 1, 1, c_white,		1.0);
	draw_sprite_part_ext(wavephoneHands,		frame,	0,									facing * humanSpriteHeight,		24, 42, drawX, drawY, 1, 1, _skintone,		1.0);
}

///@desc This function is called by the player_draw_from_state function when drawing
/// the player in the human draw event, while in the overworld. The function draws the
/// player's meditating animation
function draw_meditating_player(_skintone, _outfit, _outfitColor, _hair, _hairColor, _hat, _hatColor, _shoes, _shoeColor, _accessory, _accColor) {	
}

///@desc This function is called by the player_draw_from_state function when drawing
/// the player in the human draw event, while in the overworld. The function draws the
/// player's swimming animation
function draw_swimming_player(_skintone, _hair, _hairColor, _hat, _hatColor) {
	draw_sprite_part_ext(swimmingHumanBody,		0,	(facing * (humanSpriteWidth * 4)) + (frame * humanSpriteWidth),	0,	humanSpriteWidth, humanSpriteHeight, x,	y,	1,	1,	_skintone,	1.0);
	// add 19 to y to correct height for hair and hat
	draw_sprite_part_ext(hairSheet,		0, (facing * (humanSpriteWidth * 4)) + (frame * humanSpriteWidth),	humanSheetHeight * _hair,		humanSpriteWidth, humanSpriteHeight, drawX, drawY + 19, 1, 1, _hairColor,	1.0);
	draw_sprite_part_ext(hatSheet,		0, (facing * (humanSpriteWidth * 4)) + (frame * humanSpriteWidth),	humanSheetHeight * _hat,		humanSpriteWidth, humanSpriteHeight, drawX, drawY + 19, 1, 1, _hatColor,		1.0);
}

///@desc This function is called in the human draw event, while in the overworld. The
/// function checks the player's current state and then draws the appropriate animation
function player_draw_from_state() {
	switch (state) {
		case humanStates.standard:
			if swimming		draw_swimming_player(skintone, hairstyle, hairColor, hat, hatColor);
			if !swimming	draw_standard_player(skintone, outfit, outfitColor, hairstyle, hairColor, hat, hatColor, shoes, shoeColor, accessory, accessoryColor);
		break;
		
		case humanStates.drinking:
			draw_drinking_player(skintone, outfit, outfitColor, hairstyle, hairColor, hat, hatColor, shoes, shoeColor, accessory, accessoryColor);
		break;
		
		case humanStates.eating:
			draw_eating_player(skintone, outfit, outfitColor, hairstyle, hairColor, hat, hatColor, shoes, shoeColor, accessory, accessoryColor);
		break;
		
		case humanStates.meditating:
			draw_meditating_player(skintone, outfit, outfitColor, hairstyle, hairColor, hat, hatColor, shoes, shoeColor, accessory, accessoryColor);
		break;
		
		case humanStates.playingWavephone:
			draw_wavephone_player(skintone, outfit, outfitColor, hairstyle, hairColor, hat, hatColor, shoes, shoeColor, accessory, accessoryColor);
		break;
	}
}

///@desc This function is called by the player step event, while in the overworld. The 
/// function gets controller input and checks if the player is moving
function player_move() {
	
	if (instance_exists(menu)) return -1;
	
	// store all globals in locals
	var right	= global.char_right;
	var left	= global.char_left;
	var up		= global.char_up;
	var down	= global.char_down;

	hmove = right - left;
	vmove = down - up;	
	
	human_check_moving();
	if moving human_set_facing();
}

///@desc This function is called by the overworld step event. The function constantly checks
/// if the player is walking "off-screen". If there is another location in that direction,
/// it will begin a transition. Otherwise, it will just keep them from walking off-screen
function gate_check_player() {
	// check north gate
	if (player.bbox_top < 0) {
		if (northExit >= 0) {
			overworld_transition(player.x, 772, directions.north, northExit);
		}	else {
			player.y = 2;
		}
	}
	
	// check east gate
	if (player.bbox_right > locationWidth) {
		if (eastExit >= 0) {
			overworld_transition(16, player.y, directions.east, eastExit);	
		}	else {
			player.x = locationWidth - 9;
		}
	}
	
	// check south gate
	if (player.bbox_bottom >= locationHeight) {
		if (southExit >= 0) {
			overworld_transition(player.x, 16, directions.south, southExit);	
		}	else {
			player.y = locationHeight - 2;
		}
	}
	
	// check west gate
	if (player.bbox_left < 0) {
		if (westExit >= 0) {
			overworld_transition(784, player.y, directions.west, westExit);	
		}	else {
			player.x = 9;
		}
	}
}
	
///@desc This function is called when a spar against an in-game human opponent is about to 
/// begin. The function stores the necessary info in global variables and then begins
/// a transition.
function spar_begin_ingame() {
	global.sparType = sparTypes.inGame;
	room_transition(200, 400, directions.south, rm_battleScene, bgm_sparNormal);
}

///@desc This function is called when the player is in the overworld and presses start
function open_main_menu() {
	create_once(0, 0, LAYER.meta, mainMenu);	
}

///@desc This function is called when the emote menu is opened
function open_emote_menu() {
	create_once(0, 0, LAYER.meta, emoteMenu);	
}

///@desc This function is called whenever the action menu is opened
function open_action_menu() {
	create_once(0, 0, LAYER.meta, actionMenu);	
}

///@desc This function is called at the beginning of a spar. It takes the human's
/// spell selections and builds a ds_grid of all their parameters so that the info
/// can be quickly accessed.
function player_build_spellBookGrid() {	
	// decode spell grid
	var grid = ds_grid_create(SPELL_PARAMS.HEIGHT, SPELLS.HEIGHT);
	decode_grid(global.allSpells, grid);

	// build spellBook list
	spellBook = ds_list_create();
	decode_list(spellBookString, spellBook);

	// resize spellBookGrid if needed
	if (ds_grid_height(spellBookGrid) != ds_list_size(spellBook)) {
		ds_grid_resize(spellBookGrid, SPELL_PARAMS.HEIGHT, ds_list_size(spellBook));
	}

	// use a repeat loop to add the info for each spell in spellBook
	var i = 0;	repeat (ds_list_size(spellBook)) {
		// get id
		var spellID = spellBook[| i];
		
		// use a repeat loop to set all vars
		var j = 0;	repeat (SPELL_PARAMS.HEIGHT) {
			// set proper value
			spellBookGrid[# j,	i] = grid[# j, spellID];
			
			if (j == SPELL_PARAMS.EFFECT)
			|| (j == SPELL_PARAMS.DODGEABLE)
			|| (j == SPELL_PARAMS.POWER)
			|| (j == SPELL_PARAMS.RANGE)
			|| (j == SPELL_PARAMS.ID)
			|| (j == SPELL_PARAMS.TYPE)	{
				spellBookGrid[# j, i] = real(string_digits(spellBookGrid[# j, i]));	
			}
			
			// increment j
			j++;
		}
		
		// increment i
		i++;
	}
}

///@desc This function is called whenever the player displays an emotion using the emoteMenu
function player_display_emote(_emotionID) {
	// store args in locals
	var e = _emotionID;
	
	// get activeEmotes height
	var gh = ds_grid_height(overworld.activeEmotes);
	
	// resize activeEmotes
	ds_grid_resize(overworld.activeEmotes, 2, gh + 1);
	
	overworld.activeEmotes[# 0, gh]		= e;
	overworld.activeEmotes[# 1, gh]		= player.id;
}