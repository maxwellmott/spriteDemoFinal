/// @description Insert description here
// You can write your code in this editor

if !global.overworld exit;

surface_set_target(game.guiSurface);
	draw_set(fa_center, fa_bottom, 1.0, overworldFont);
	draw_text(guiWidth / 2, 32, currentObjName);
surface_reset_target();