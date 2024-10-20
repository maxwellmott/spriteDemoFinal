/// @description Insert description here
// You can write your code in this editor

if !(outroStarted) {
	draw_self();
	
	// check if intro is finished
	if (introFinished) {
		// get the bbox vals for the selected button
		var left	= leftList[| selectedButton];
		var right	= rightList[| selectedButton];
		var top		= topList[| selectedButton];
		var bottom	= bottomList[| selectedButton];
		
		// check if its time to draw the selector box
		if (global.gameTime mod 32 < 16) {
			// draw the selected box around the button
			draw_sprite_stretched(spr_selectorBox, 0, left, top, btnWidth, btnHeight);
		}
	}
}
else {
	draw_sprite(sprite_index, image_number - image_index - 1, x, y);
}