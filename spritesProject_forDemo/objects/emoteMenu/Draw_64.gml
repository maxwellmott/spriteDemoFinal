/// @description Insert description here
// You can write your code in this editor

surface_set_target(game.guiSurface);

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
			draw_sprite_stretched(spr_selectorBox, 0, left + btnWidth, top + btnHeight, btnWidth, btnHeight);
		}
		
		// check if pressedButton is set
		if (pressedButton >= 0) {
			// draw a white rectangle over the pressed button
			draw_rectangle_color(left, top, right, bottom, COL_WHITE, COL_WHITE, COL_WHITE, COL_WHITE, false);
		}
	}
}
else {
	draw_sprite(sprite_index, image_number - image_index - 1, x, y);	
}
surface_reset_target();