///@desc This function is called whenever the player is loaded or changes outfit.
/// the function stores the value for each appearance parameter in the proper variable
function character_creator_load_appearance() {
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

///@desc This function is called by the player_draw_from_state function when drawing
/// the player in the human draw event, while in the overworld. The function draws the
/// player in their standard state (walking)
function character_creator_draw_player(_skintone, _outfit, _outfitColor, _hair, _hairColor, _hat, _hatColor, _shoes, _shoeColor, _accessory, _accColor) {
	draw_sprite_part_ext(humanBody,		0, (playerFacing * (humanSpriteWidth * 4)),		0,								humanSpriteWidth, humanSpriteHeight, playerDisplayX, playerDisplayY, 1, 1, _skintone,		1.0);
	draw_sprite_part_ext(outfitSheet,	0, (playerFacing * (humanSpriteWidth * 4)),		humanSheetHeight * _outfit,		humanSpriteWidth, humanSpriteHeight, playerDisplayX, playerDisplayY, 1, 1, _outfitColor,	1.0);
	draw_sprite_part_ext(hairSheet,		0, (playerFacing * (humanSpriteWidth * 4)),		humanSheetHeight * _hair,		humanSpriteWidth, humanSpriteHeight, playerDisplayX, playerDisplayY, 1, 1, _hairColor,		1.0);
	draw_sprite_part_ext(hatSheet,		0, (playerFacing * (humanSpriteWidth * 4)),		humanSheetHeight * _hat,		humanSpriteWidth, humanSpriteHeight, playerDisplayX, playerDisplayY, 1, 1, _hatColor,		1.0);
	draw_sprite_part_ext(shoeSheet,		0, (playerFacing * (humanSpriteWidth * 4)),		humanSheetHeight * _shoes,		humanSpriteWidth, humanSpriteHeight, playerDisplayX, playerDisplayY, 1, 1, _shoeColor,		1.0);
	//draw_sprite_part_ext(accessorySheet,0, (facing * (humanSpriteWidth * 4)) + (frame * humanSpriteWidth),	humanSheetHeight * _accessory,	humanSpriteWidth, humanSpriteHeight, drawX, drawY, 1, 1, _accColor,	1.0);
}