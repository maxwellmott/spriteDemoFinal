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