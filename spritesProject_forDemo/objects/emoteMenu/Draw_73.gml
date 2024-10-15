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
		
		// draw all emotion names
		var i = 0;	repeat (emotions.height) {
			draw_set(fa_center, fa_middle, 1.0, COL_BLACK);
			draw_set_font(emoteMenuFont);
			
			var left = leftList[| i];
			var top = topList[| i];
			
			draw_text_pixel_perfect(left + (btnWidth / 2) + 1, top + (btnHeight / 2) - 5, nameList[| i], 1, 256);
			
			i++;
		}
	}
}
else {
	draw_sprite(sprite_index, (image_number - 1) - image_index, x, y);
}