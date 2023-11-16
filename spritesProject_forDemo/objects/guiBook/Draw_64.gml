/// @description Insert description here
// You can write your code in this editor

/// @description Insert description here
// You can write your code in this editor

if !(bookBuilt) exit;

surface_set_target(game.guiSurface);

draw_sprite_ext(spr_bookCover, 0, 0, 0, 1, 1, 0, color, 1.0);

draw_set_color(c_black);

draw_sprite(spr_book, 0, 0, 0);

draw_set_font(font);

draw_set_valign(fa_top);

draw_set_halign(fa_center);

if !(turningPage) {
	if (headingCount > 0) {
		var i = 0; repeat (headingCount) {
			if (string_digits(headingGrid[# 3, i]) div 2 == pageIndex) {
				draw_text(headingGrid[# 1, i], headingGrid[# 2, i], headingGrid[# 0, i]);

				i++;
			}
		}
	}

	draw_set_halign(fa_left);
	
	draw_set_color(textColor);
	
	draw_text_transformed(leftPageX, textY, leftPageText, 0.5, 0.5, 0);
	draw_text_transformed(rightPageX, textY, rightPageText, 0.5, 0.5, 0);
	
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

surface_reset_target();