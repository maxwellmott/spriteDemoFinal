/// @description Insert description here
// You can write your code in this editor

if (global.select) {
	spar.turnMsg = "";
	
	// set animation built-ins for spar object
	spar.sprite_index = animation;
	spar.image_speed = 1;
	spar.image_index = 0;
}

// if animation finishes,				destroy object
if (spar.image_index >= maxFrame) {
		instance_destroy(id);
}