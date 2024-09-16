///@desc This function takes a string and the address of a variable within which
/// to store a substring. It then takes each character from the string one-by-one
/// and copies them to the substring. This is called in the step event of different
/// objects to create a rolling-text effect.
function increment_text(_source, _target) {
	var source	= _source;
	var target	= _target;
	
	target += string_char_at(source, string_length(target) + 1);
	
	return target;
}

///@desc This function is used to draw text in the battle scene. It's just a way of safely ensuring that when text
/// is drawn with a centered alignment, it corrects if the width of the string being drawn is an odd number (can't draw
/// pixels at decimal values) This should only be used when drawing text with a center and/or middle alignment
/// This function also takes a separation and width value to ensure that the text is drawn fashionably.
function draw_text_pixel_perfect(_x, _y, _text, _separation, _width) {
	var xx = _x;
	var yy = _y;
	var tt = _text;
	var ss = _separation;
	var ww = _width;
	
	if (draw_get_halign() == fa_center) {
		if ((string_width(tt) / 2) mod 2 != 0) {
			xx -= 1;	
		}
	}
	
	if (draw_get_valign() == fa_middle) {
		if ((string_height(tt) / 2) mod 2 != 0) {
			yy -= 1;	
		}
	}
	
	draw_text_ext(xx, yy, tt, ss, ww);
}
