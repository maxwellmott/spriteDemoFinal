/// @description Insert description here
// You can write your code in this editor

gridNum = instance_number(object_index) - 1;

emoteID = overworld.activeEmotes[# 0, gridNum];

emoteHeight = 16;
emoteWidth = 16;

emoter = overworld.activeEmotes[# 1, gridNum];

depth = emoter.depth;

x = (guiWidth / 2) + (camera.x - emoter.x);
y = (guiHeight / 2) + (camera.y - emoter.y) - 12;

if (x >= (guiWidth / 2)) {
	x += 12;
}
else {
	x -= 12;	
}

image_index = 0;

sprite_index = spr_emoteSheet; 