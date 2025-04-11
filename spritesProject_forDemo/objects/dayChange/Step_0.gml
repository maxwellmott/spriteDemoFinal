/// @description Insert description here
// You can write your code in this editor

// CREATE STARS
if (starsPlaced < starCount) {
	if !(global.gameTime mod 8) {
		randomize();
		var xx = irandom_range(0, room_width);
		var yy = irandom_range(0, room_height);
	
		var star = layer_sprite_create("Stars", xx, yy, starSprite);
			
		starsPlaced++;
	}
}

if !(global.roomBuilt) && (starsPlaced == starCount) {
	global.roomBuilt = true;
}

if (displaying == dcDisplay.height) {
		if (global.select) {
			room_transition(player.x, player.y, player.facing, rm_overworld, bgm_magicIsInTheAir);
		}
}