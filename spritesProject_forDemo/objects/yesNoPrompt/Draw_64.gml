/// @description Insert description here
// You can write your code in this editor

surface_set_target(game.guiSurface);

	draw_set_font(plainFont);

	draw_sprite(sprite, yesButtonFrame, yesButtonX, yesButtonY);
	draw_sprite(sprite, noButtonFrame, noButtonX, noButtonY);
	
	draw_set_color(yesColor);
	draw_text(yesButtonX, yesButtonY, "yes");
	
	draw_set_color(noColor);
	draw_text(noButtonX, noButtonY, "no");
	
surface_reset_target();