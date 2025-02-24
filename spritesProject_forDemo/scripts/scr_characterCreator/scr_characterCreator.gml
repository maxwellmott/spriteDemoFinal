///@desc This function is called by the character creator in the draw event. It draws
/// a sample version of the player character using the currently set appearance parameters
function character_creator_draw_player(_skintone, _outfit, _outfitColor, _hair, _hairColor, _hat, _hatColor, _shoes, _shoeColor, _accessory, _accColor) {
	draw_sprite_part_ext(humanBody,		0, (playerFacing * (humanSpriteWidth * 4)),		0,								humanSpriteWidth, humanSpriteHeight, playerDisplayX, playerDisplayY, 1, 1, _skintone,		1.0);
	draw_sprite_part_ext(outfitSheet,	0, (playerFacing * (humanSpriteWidth * 4)),		humanSheetHeight * _outfit,		humanSpriteWidth, humanSpriteHeight, playerDisplayX, playerDisplayY, 1, 1, _outfitColor,	1.0);
	draw_sprite_part_ext(hairSheet,		0, (playerFacing * (humanSpriteWidth * 4)),		humanSheetHeight * _hair,		humanSpriteWidth, humanSpriteHeight, playerDisplayX, playerDisplayY, 1, 1, _hairColor,		1.0);
	draw_sprite_part_ext(hatSheet,		0, (playerFacing * (humanSpriteWidth * 4)),		humanSheetHeight * _hat,		humanSpriteWidth, humanSpriteHeight, playerDisplayX, playerDisplayY, 1, 1, _hatColor,		1.0);
	draw_sprite_part_ext(shoeSheet,		0, (playerFacing * (humanSpriteWidth * 4)),		humanSheetHeight * _shoes,		humanSpriteWidth, humanSpriteHeight, playerDisplayX, playerDisplayY, 1, 1, _shoeColor,		1.0);
	//draw_sprite_part_ext(accessorySheet,0, (facing * (humanSpriteWidth * 4)) + (frame * humanSpriteWidth),	humanSheetHeight * _accessory,	humanSpriteWidth, humanSpriteHeight, drawX, drawY, 1, 1, _accColor,	1.0);
}

///@desc This function is called by the character creator in the clean up event. It sets
/// all the chosen appearance parameters as the player's set appearance parameters.
function character_creator_save_appearance() {
	appearance[| APPEARANCE_PARAMS.skintone]			= ds_list_find_index(colorList, skintone);
	appearance[| APPEARANCE_PARAMS.outfit]			= outfit;
	appearance[| APPEARANCE_PARAMS.outfitColor]		= ds_list_find_index(colorList, outfitColor);
	appearance[| APPEARANCE_PARAMS.hairstyle]		= hairstyle;
	appearance[| APPEARANCE_PARAMS.hairColor]		= ds_list_find_index(colorList, hairColor);
	appearance[| APPEARANCE_PARAMS.hat]				= hat;
	appearance[| APPEARANCE_PARAMS.hatColor]			= hatColor;
	appearance[| APPEARANCE_PARAMS.shoes]			= shoes;
	appearance[| APPEARANCE_PARAMS.shoeColor]		= shoeColor;
	appearance[| APPEARANCE_PARAMS.accessory]		= accessory;
	appearance[| APPEARANCE_PARAMS.accessoryColor]	= accessoryColor;
	
	player.appearance = encode_list(appearance);
}