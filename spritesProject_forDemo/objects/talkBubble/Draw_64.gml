/// @description Insert description here
// You can write your code in this editor

surface_set_target(game.guiSurface);

	// set font
	draw_set_font(plainFont);
	
	// set color
	draw_set_color(c_black);
	
	/// set halign and valign
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);

	// draw arm
	draw_sprite_ext(talkArmSprite, 0, armX, armY, armXScale, 1, 0, c_white, 1.0);

	// draw talk bubble
	draw_sprite_ext(bubbleSprite, 0, bubbleX, bubbleY, 1, yScale, 0, c_white, 1.0);
	
	// draw cover
	draw_sprite_ext(coverSprite, 0, coverX, coverY, 1, yScale, 0, c_white, 1.0);
	
	// draw current page of text
	draw_text(bubbleX + 4, bubbleY + 4, pages[| pageIndex]);
	// draw any current emojis

surface_reset_target();