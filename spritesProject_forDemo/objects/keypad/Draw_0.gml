/// @desc

draw_sprite(spr_keypadStandard, 0, x, y);

draw_set_font(fnt_keypadStandard);
draw_set(fa_right, fa_middle, 1.0, c_green);
draw_text(textStartX, textStartY, string(currentAnswer));