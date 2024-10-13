/// @description Insert description here
// You can write your code in this editor

if (introFinished)
&& (outroStarted) {
	if (image_index >= image_number - 1) {
		instance_destroy(id);
	}
}

if (introFinished)
&& !(outroStarted) {
	
	image_index = image_number - 1;
	
	if (global.back) {
		image_index = 0;
		outroStarted = true;	
	}
}

if !(introFinished) {
	if (image_index >= image_number - 1) {
		introFinished = true;	
	}
}