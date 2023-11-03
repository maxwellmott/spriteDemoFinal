/// @description Insert description here
// You can write your code in this editor
draw_set_font(overworldFont);
draw_set(fa_center, fa_middle, 1.0, c_white);

if moonPhase != moonPhases.newMoon {
	draw_sprite(moonSprite, moonPhase, moonX, moonY);
}

if displaying >= dcDisplay.day {
	draw_text(room_width / 2, room_height * (2/16), "Current Day:");
}

if displaying >= dcDisplay.sprites {
	draw_text(room_width / 2, room_height * (5/16), "Sprites Befriended:");
}

if displaying >= dcDisplay.spells {
	draw_text(room_width / 2, room_height * (8/16), "Spells Learned:");
}

if displaying >= dcDisplay.conversations {
	draw_text(room_width / 2, room_height * (11/16), "Conversations Had:");
}

if displaying >= dcDisplay.spars {
	draw_text(room_width / 2, room_height * (14/16), "Spars Won:");
}