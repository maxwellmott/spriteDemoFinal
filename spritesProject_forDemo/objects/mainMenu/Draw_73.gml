draw_set_font(mainMenuFont);

// check that outro has not yet started
if !(outroStarted) {
	// check that intro is not yet finished
	if !(introFinished) {
		draw_sprite(sprite_index, image_index, x, y);
		
		// check if opening animation has hit the first frame with the device fully visible
		if (image_index >= 4) {
			// draw the screen shine
			draw_sprite(spr_soulStoneScreenShine, 0, x, y);
		}
	}
	// if intro is finished
	else {
		draw_sprite(sprite_index, 8, x, y);
		
		// set alpha to buttonAlpha
		draw_set_alpha(buttonAlpha);
		
		// get half of button width and height
		var hw = sprite_get_width(spr_mainMenuButton) / 2;
		var hh = round(sprite_get_height(spr_mainMenuButton) / 2);
		
		// draw all main menu buttons
		var i = 0;	repeat (buttonCount) {
			var left = buttonLeftList[| i];
			var top = buttonTopList[| i];
			
			// draw button
			draw_sprite(spr_mainMenuButton, 0, left + hw, top + hh);

			// set draw params
			draw_set(fa_center, fa_middle, buttonAlpha, textColor);

			// draw name
			draw_text_pixel_perfect(left + hw, top, buttonNameList[| i], 1, 256);
			
			i++;
		}
		
		// get selector position
		var sy = buttonTopList[| selectedButton] + 1;
		
		
		if (buttonAlpha >= 1.0) {
			if (global.gameTime mod 32 <= 16) {
				// draw main menu selectors
				draw_sprite(spr_mainMenuSelector, 0, leftSelectorX, sy);
				draw_sprite(spr_mainMenuSelector, 0, rightSelectorX, sy);		
			}
		}		
		
		// set font
		draw_set_font(digiClockFont);
		
		var clockString = "";
		
		if (player.minutes < 10) {
			clockString = string(player.hours mod 12) + ":" + "0" + string(player.minutes);	
		}
		else {
			clockString = string(player.hours mod 12) + ":" + string(player.minutes);	
		}
		
		if (player.hours < 12) {
			var ff = 0;
		}
		else {
			var ff = 1;
		}
		
		// draw digital clock
		draw_text_pixel_perfect(x - 7, y + 40, clockString, 6, guiWidth);
		
		// draw ampm sprite
		draw_sprite(spr_ampmSprite, ff, x + 7, y + 49);
		
		// set alpha to shineAlpha
		draw_set_alpha(shineAlpha);
		
		// draw screen shine
		draw_sprite(spr_soulStoneScreenShine, 0, x, y);
		
		// reset alpha
		draw_set_alpha(1.0);
	}
}
// if outro has started
else {
	// draw closing animation
	draw_sprite(spr_soulStoneClose, image_index, x, y);
}