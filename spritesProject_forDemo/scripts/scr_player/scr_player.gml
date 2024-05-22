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
	
	
	
	ds_list_destroy(list);
}

function draw_standard_player(_skintone, _outfit, _outfitColor, _hair, _hairColor, _hat, _hatColor, _shoes, _shoeColor, _accessory, _accColor) {
	draw_sprite_part_ext(humanBody,		0, frame * humanSpriteWidth,	0,								humanSheetWidth, humanSheetHeight, x, y, 1, 1, _skintone,		1.0);
	draw_sprite_part_ext(outfitSheet,	0, frame * humanSpriteWidth,	humanSheetHeight * _outfit,		humanSheetWidth, humanSheetHeight, x, y, 1, 1, _outfitColor,	1.0);
	draw_sprite_part_ext(hairSheet,		0, frame * humanSpriteWidth,	humanSheetHeight * _hair,		humanSheetWidth, humanSheetHeight, x, y, 1, 1, _hairColor,		1.0);
	draw_sprite_part_ext(hatSheet,		0, frame * humanSpriteWidth,	humanSheetHeight * _hat,		humanSheetWidth, humanSheetHeight, x, y, 1, 1, _hatColor,		1.0);
	draw_sprite_part_ext(shoeSheet,		0, frame * humanSpriteWidth,	humanSheetHeight * _shoes,		humanSheetWidth, humanSheetHeight, x, y, 1, 1, _shoeColor,		1.0);
	//draw_sprite_part_ext(accessorySheet,0, 0,	humanSheetHeight * _accessory,	humanSheetWidth, humanSheetHeight, x, y, 1, 1, _accColor,		1.0);
}

function draw_eating_player(_skintone, _outfit, _outfitColor, _hair, _hairColor, _hat, _hatColor, _shoes, _shoeColor, _accessory, _accColor) {
}

function draw_drinking_player(_skintone, _outfit, _outfitColor, _hair, _hairColor, _hat, _hatColor, _shoes, _shoeColor, _accessory, _accColor) {	
}

function draw_wavephone_player(_skintone, _outfit, _outfitColor, _hair, _hairColor, _hat, _hatColor, _shoes, _shoeColor, _accessory, _accColor) {	
}

function draw_meditating_player(_skintone, _outfit, _outfitColor, _hair, _hairColor, _hat, _hatColor, _shoes, _shoeColor, _accessory, _accColor) {	
}

function draw_swimming_player(_skintone, _hair, _hairColor, _hat, _hatColor) {
	draw_sprite_part_ext(swimmingHumanBody,		0,	frame * humanSpriteWidth,	0,							humanSheetWidth, humanSheetHeight,	x,	y,		1,	1,	_skintone,	1.0);
	// add 19 to y to correct height for hair and hat
	draw_sprite_part_ext(hairSheet,				0,	frame * humanSpriteWidth,	humanSheetHeight * _hair,	humanSheetWidth, humanSheetHeight,	x,	y + 19,	1,	1,	_hairColor,	1.0);
	draw_sprite_part_ext(hatSheet,				0,	frame * humanSpriteWidth,	humanSheetHeight * _hat,	humanSheetWidth, humanSheetHeight,	x,	y + 19,	1,	1,	_hatColor,	1.0);
}

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

function player_move() {
	
	// store all globals in locals
	var right	= global.char_right;
	var left	= global.char_left;
	var up		= global.char_up;
	var down	= global.char_down;
	var ow		= global.overworld;
	
	if (ow) {
	
		hmove = right - left;
		vmove = down - up;	
	}
	
	if !(ow) {
		hmove = 0;
		vmove = 0;
	}
	
	human_check_moving();
	if moving human_set_facing();
}

function gate_check_player() {
	// check north gate
	if (player.bbox_top < 0) {
		if (northExit >= 0) {
			overworld_transition(player.x, 772, directions.north, northExit);
		}	else player.y = 2;
	}
	
	// check east gate
	if (player.bbox_right > locationWidth) {
		if (eastExit >= 0) {
			overworld_transition(16, player.y, directions.east, eastExit);	
		}	else player.x = locationWidth - 9;
	}
	
	// check south gate
	if (player.bbox_bottom >= locationHeight) {
		if (southExit >= 0) {
			overworld_transition(player.x, 16, directions.south, southExit);	
		}	else player.y = locationHeight - 2;
	}
	
	// check west gate
	if (player.bbox_left < 0) {
		if (westExit >= 0) {
			overworld_transition(784, player.y, directions.west, westExit);	
		}	else player.x = 9;
	}
}
	
///@desc this sprite takes an NPC id and begins a match with that NPC
function spar_begin_ingame(_opponent) {
	global.opponent = _opponent;
	global.sparType = sparTypes.inGame;
	room_transition(200, 400, directions.south, rm_battleScene);
}