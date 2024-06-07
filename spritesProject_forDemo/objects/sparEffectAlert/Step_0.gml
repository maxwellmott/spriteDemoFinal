/// @description Insert description here
// You can write your code in this editor

if (global.select) {
	// set animation built-ins for spar object
	spar.sprite_index = animation;
	spar.image_speed = 1;
	spar.image_index = 0;	
	
	spar.turnMsg = "";
}

// if animation finishes,				destroy object
if (spar.image_index >= frameCount)		instance_destroy(id);