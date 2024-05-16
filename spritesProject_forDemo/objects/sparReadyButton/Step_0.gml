/// @description Insert description here
// You can write your code in this editor

if (collision_rectangle(bboxLeft, bboxTop, bboxRight, bboxBottom, mouse, false, false)) {
	frame = 1;
	
	// button pressing logic
	if (global.click) {
		spar.potentialCost = 0;
		spar.totalSelectionCost = 0;
		
		player_submit_turn();
		player.ready = true;
	}
}
else {
	frame = 0;	
}

if !(global.gameTime mod 2) {
	if (x1 == 0 - spriteWidth) {
		x1 = 0;
		x2 = x1 + spriteWidth;
		x3 = x2 + spriteWidth;
		x4 = x3 + spriteWidth;
		x5 = x4 + spriteWidth;
		x6 = x5 + spriteWidth;
		x7 = x6 + spriteWidth;
		x8 = x7 + spriteWidth;
		
		exit;
	}
	
	x1--;
	x2 = x1 + spriteWidth;
	x3 = x2 + spriteWidth;
	x4 = x3 + spriteWidth;
	x5 = x4 + spriteWidth;
	x6 = x5 + spriteWidth;
	x7 = x6 + spriteWidth;
	x8 = x7 + spriteWidth;
}