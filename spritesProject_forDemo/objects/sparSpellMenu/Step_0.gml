/// @description Insert description here
// You can write your code in this editor

if (x < targetX) {
	x--;	
}

if (x > targetX) {
	x++;	
}

if (x == targetX) && (targetX == spriteWidth / 2) {
	if (global.select) {
		// set spell
		
		// close book
		targetX = 0 - (spriteWidth / 2);
	}
	
	if (global.back) {
		// close book
		targetX = 0 - (spriteWidth / 2);
	}
}

if (x == targetX) && (targetX == 0 - (spriteWidth / 2)) {
	// @TODO change selectionPhase
	
	
	// destroy self
	instance_destroy(self);	
}