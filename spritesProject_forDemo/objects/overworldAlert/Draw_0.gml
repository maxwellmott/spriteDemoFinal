/// @desc

draw_sprite(spr_overworldAlert, 0, x, y);
draw_set_font(overworldFont);
draw_set(fa_left, fa_top, 1.0, c_white);
draw_text(textX - 1, textY - 1, writtenText);
draw_set(fa_left, fa_top, 1.0, c_black);
draw_text(textX, textY, writtenText);

if ynPrompt 
&& writtenText == text
	yesNo.method_draw();