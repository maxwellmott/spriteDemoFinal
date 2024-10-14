/// @description Insert description here
// You can write your code in this editor

surface_set_target(game.guiSurface);
	// draw the emote
	draw_sprite_part(sprite_index, image_index, 0, emoteID * emoteHeight, emoteWidth, emoteHeight, x, y);
surface_reset_target();
