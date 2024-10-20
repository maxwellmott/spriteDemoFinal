if !(bookBuilt) exit;

surface_set_target(game.guiSurface);

	// check that outro has not yet started
	if !(outroStarted) {
		// check that intro is not yet finished
		if !(introFinished) {
			// draw book cover in set color
			draw_sprite_ext(sprite_index, image_index, 0, 0, 1, 1, 0, color, 1.0);
			
			// draw book pages 
			draw_sprite(spr_bookPages, image_index, 0, 0);
		}
		// if intro IS finished
		else {
			draw_sprite_ext(sprite_index, 3, 0, 0, 1, 1, 0, color, 1.0);
			
			draw_set_color(c_black);
			
			draw_sprite(spr_bookPages, 3, 0, 0);
			
			draw_set_font(font);
			
			draw_set_valign(fa_top);
			
			draw_set_halign(fa_center);
			
			if !(turningPage) {
				if (headingCount > 0) {
					var i = 0; repeat (headingCount) {
						if (string_digits(headingGrid[# 3, i]) div 2 == pageIndex) {
							draw_text_pixel_perfect(headingGrid[# 1, i], headingGrid[# 2, i], headingGrid[# 0, i], fontHeight + 1, pageWidth);
						}
					i++;
					}
				}
			
				draw_set_halign(fa_left);
				
				draw_set_color(textColor);
				
				draw_text_pixel_perfect(leftPageX, textY, leftPageText, fontHeight + 1, 256);
				draw_text_pixel_perfect(rightPageX, textY, rightPageText, fontHeight + 1, 256);
				
				draw_set_color(c_white);
				
				if (imageCount > 0) {
					var i = 0; repeat (imageCount) {
						if (string_digits(imageGrid[# 3, i]) div 2 == pageIndex) {
							draw_sprite(imageGrid[# 0, i], 0, imageGrid[# 1, i], imageGrid[# 2, i]);
							
							i++;
						}
					}
				}
			}
			
			if (turningPage) {
				draw_sprite(spr_pageFlip, flipFrame, 0, 0);	
			}
		}
	}
	// if outro HAS started
	else {
		// draw book cover in reverse
		draw_sprite_ext(sprite_index, 3 - image_index, 0, 0, 1, 1, 0, color, 1.0);
		
		// draw book pages in reverse
		draw_sprite(spr_bookPages, 3 - image_index, 0, 0);
	}
		
surface_reset_target();