/// @description Insert description here
// You can write your code in this editor

surface_set_target(game.guiSurface);

if !(outroStarted) {
	draw_self();
}
else {
	draw_sprite(sprite_index, image_number - image_index - 1, x, y);	
}
surface_reset_target();