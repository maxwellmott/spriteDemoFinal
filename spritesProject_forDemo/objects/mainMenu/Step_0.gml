/// @description Insert description here
// You can write your code in this editor

if !(introFinished) {
	if (image_index >= 8) {
		introFinished = true;	
	}
}

if !(outroStarted) {
	if (introFinished) {
		if (global.back) {
			image_index = 0;
			outroStarted = true;	
		}
	}
}

if (outroStarted) {
	if (image_index >= 5) {
		instance_destroy(id);	
	}
}