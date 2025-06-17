///@desc This function is called by the character creator in the draw event. It draws
/// a sample version of the player character using the currently set appearance parameters
function character_creator_draw_player(_eyewear, _skintone, _outfit, _outfitColor, _hair, _hairColor, _hat, _hatColor, _shoes, _shoeColor, _accessory) {
	draw_sprite_part_ext(humanBody,		0, (playerFacing * (humanSpriteWidth * 4)),		0,								humanSpriteWidth, humanSpriteHeight, 0, 0, 1, 1, _skintone,		1.0);
	draw_sprite_part_ext(eyewearSheet,	0, (playerFacing * (humanSpriteWidth * 4)),		humanSheetHeight * _eyewear,	humanSpriteWidth, humanSpriteHeight, 0, 0, 1, 1, c_white,			1.0);
	draw_sprite_part_ext(outfitSheet,	0, (playerFacing * (humanSpriteWidth * 4)),		humanSheetHeight * _outfit,		humanSpriteWidth, humanSpriteHeight, 0, 0, 1, 1, _outfitColor,	1.0);
	draw_sprite_part_ext(hairSheet,		0, (playerFacing * (humanSpriteWidth * 4)),		humanSheetHeight * _hair,		humanSpriteWidth, humanSpriteHeight, 0, 0, 1, 1, _hairColor,		1.0);
	
	// check if the player is wearing a hat
	if (_hat != hats.nothing) {
		// set blend mode to subtractive
		gpu_set_blendmode(bm_subtract);
	
			// draw rectangle
			draw_rectangle_color(0, 0, 24, 11, c_black, c_black, c_black, c_black, false);
		
		// reset blendmode
		gpu_set_blendmode(bm_normal);
	}
	
	draw_sprite_part_ext(hatSheet,		0, (playerFacing * (humanSpriteWidth * 4)),		humanSheetHeight * _hat,		humanSpriteWidth, humanSpriteHeight, 0, 0, 1, 1, _hatColor,		1.0);
	draw_sprite_part_ext(shoeSheet,		0, (playerFacing * (humanSpriteWidth * 4)),		humanSheetHeight * _shoes,		humanSpriteWidth, humanSpriteHeight, 0, 0, 1, 1, _shoeColor,		1.0);
	draw_sprite_part_ext(accessorySheet,0, (playerFacing * (humanSpriteWidth * 4)),		humanSheetHeight * _accessory,	humanSpriteWidth, humanSpriteHeight, 0, 0, 1, 1, c_white,			1.0);
}

///@desc This function is called by the character creator in the clean up event. It sets
/// all the chosen appearance parameters as the player's set appearance parameters.
function character_creator_save_appearance() {
	appearance[| APPEARANCE_PARAMS.skintone]		= ds_list_find_index(colorList, skintone);
	appearance[| APPEARANCE_PARAMS.eyewear]			= eyewear;
	appearance[| APPEARANCE_PARAMS.outfit]			= outfit;
	appearance[| APPEARANCE_PARAMS.outfitColor]		= ds_list_find_index(colorList, outfitColor);
	appearance[| APPEARANCE_PARAMS.hairstyle]		= hairstyle;
	appearance[| APPEARANCE_PARAMS.hairColor]		= ds_list_find_index(colorList, hairColor);
	appearance[| APPEARANCE_PARAMS.hat]				= hat;
	appearance[| APPEARANCE_PARAMS.hatColor]		= ds_list_find_index(colorList, hatColor);
	appearance[| APPEARANCE_PARAMS.shoes]			= shoes;
	appearance[| APPEARANCE_PARAMS.shoeColor]		= ds_list_find_index(colorList, shoeColor);
	appearance[| APPEARANCE_PARAMS.accessory]		= accessory;
	
	player.appearance = encode_list(appearance);
}