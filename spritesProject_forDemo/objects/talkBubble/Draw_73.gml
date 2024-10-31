	// set font
	draw_set_font(plainFont);
	
	// set color
	draw_set_color(COL_BLACK);
	
	/// set halign and valign
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);

	// draw talk bubble
	draw_sprite(bubbleSprite, 0, bubbleX, bubbleY);
	
	// draw current page of text
	draw_text_pixel_perfect(textX, textY, currentText, 9, 256);