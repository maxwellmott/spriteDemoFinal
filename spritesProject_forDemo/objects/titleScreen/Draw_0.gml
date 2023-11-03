draw_set_alpha(1.0);
draw_rectangle_color(0,	0,	screenWidth,	screenHeight,	backgroundColor,	backgroundColor,	backgroundColor,	backgroundColor,	false);
draw_sprite(spr_titleScreenCliffs, 0, cliffDrawX, cliffDrawY);
draw_sprite_stretched(spr_titleScreenWaves, global.frame, waveDrawX, waveDrawY, waveDrawWidth, waveDrawHeight);