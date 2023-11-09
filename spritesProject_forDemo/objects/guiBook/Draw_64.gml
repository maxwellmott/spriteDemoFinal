/// @description Insert description here
// You can write your code in this editor

/// @description Insert description here
// You can write your code in this editor

if !(bookBuilt) exit;

surface_set_target(game.guiSurface);

draw_set_color(color);

draw_sprite(spr_bookCover, 0, 0, 0);

draw_set_color(c_white);

draw_sprite(spr_book, 0, 0, 0);

draw_set_font(font);

if !(turningPage) {
	if (headingCount > 0) {
		var i = 0; repeat (headingCount) {
			if (string_digits(headingGrid[# 3, i]) div 2 == pageIndex) {
				draw_set_halign(fa_center);
				draw_text(headingGrid[# 0, i], headingGrid[# 1, i], headingGrid[# 2, i]);
				draw_set_halign(fa_left);
				
				i++;
			}
		}
	}
	
	draw_text(leftPageX, textY, leftPageText);
	draw_text(rightPageX, textY, rightPageText);
	
	if (imageCount > 0) {
		var i = 0; repeat (imageCount) {
			if (string_digits(imageGrid[# 3, i]) div 2 == pageIndex) {
				draw_sprite(imageGrid[# 2, i], 0, imageGrid[# 0, i], imageGrid[# 1, i]);
				
				i++;
			}
		}
	}
}

if (turningPage) {
	draw_sprite(spr_pageFlip, 1, 0, 0);	
}

surface_reset_target();