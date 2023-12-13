/// @description Insert description here
// You can write your code in this editor

if (x < targetX) {
	x += 2;	
}

if (x > targetX) && (frame == 0) {
	x -= 2;	
}

if (x == targetX) && (frame < frameMax) {
	if !(global.gameTime mod 4) frame++;
}

if (x > targetX) && (frame > 0) {
	if !(global.gameTime mod 4) frame--;
}

if (x == targetX) && (targetX == spriteWidth / 2) {
	if (global.select) {
		// set global.action
		global.action = currentSpell + sparActions.height;
		
		// check if range is self
		if (spellRange == ranges.onlySelf) {
			// if so, set action and target to indicate self-targeting spell
			self_target_set();
			
			// set next phase
			nextPhase = selectionPhases.ally;
		}
		else {
			// if not self range, set action normally
			spar_set_target();
			
			// set next phase
			nextPhase = selectionPhases.target;
		}
		
		// close book
		targetX = 0 - (spriteWidth / 2);
	}
	
	if (global.back) {
		// set next phase
		nextPhase = selectionPhases.ally;
		
		// close book
		targetX = 0 - (spriteWidth / 2);
	}
	
	if (global.menu_left) {
		// check if index is at 0
		if (index > 0) {
			// set pageFlip to true
			pageFlip = true;
			
			// set flipLeft to true
			flipLeft = true;
			
			// set flipFrame to 1
			flipFrame = 1;
			
			// if not, decrement index
			index--;
		
			// set current spell
			currentSpell = player.spellBook[| index];
			
			// get spell params
			spar_spell_load_params();
		}
	}
	
	if (global.menu_right) {
		// check if index is at max
		if (index < SPELLMAX - 1) {
			// set pageFlip to true
			pageFlip = true;
			
			// set flipRight to true
			flipRight = true;
			
			// set flipFrame to 0
			flipFrame = 0;
			
			// if not, increment index
			index++;
			
			// set current spell
			currentSpell = player.spellBook[| index];
			
			// get spell params
			spar_spell_load_params();
			
		}
	}
}

if (x == targetX) && (targetX == 0 - (spriteWidth / 2)) {
	// change selectionPhase
	spar.selectionPhase = nextPhase;
	
	// destroy self
	instance_destroy(self);	
}

// check if page flip is happening
if (pageFlip) {
	if flipRight {
		// if flip is over, change pageFlip to false
		if (flipFrame == 0) {
			if !(global.gameTime mod 4) {
				pageFlip = false;	
			}
		}
		
		// if flip isn't over, increment frame
		if (flipFrame > 0) {
			if !(global.gameTime mod 4) {
				flipFrame++;	
			}
		}
	}
	
	if flipLeft {
		// if flip is over, change pageFlip to false
		if (flipFrame == flipMax) {
			if !(global.gameTime mod 4) {
				pageFlip = false;	
			}
		}
		
		// if flip isn't over, decrement frame
		if (flipFrmae < flipMax) {
			if !(global.gameTime mod 4) {
				flipFrame--;	
			}
		}
	}
}

// if pageFlip is over, set flipRight and flipLeft to false
if !(pageFlip) {
	if flipRight	flipRight	= false;
	if flipLeft		flipLeft	= false;
}