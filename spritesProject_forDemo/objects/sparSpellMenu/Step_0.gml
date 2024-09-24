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
	if (enoughMP) {
		if (global.select) {	
			// check if the current spell is on the usable spells list
			if (ds_list_find_index(usable_spells, currentSpell) != -1) {
				// set global.action
				global.action = currentSpell + sparActions.height;
				
				// check if range is self
				if (spellRange == ranges.onlySelf) {
					// if so, set action and target to indicate self-targeting spell
					self_target_set();
					
					// set next phase
					nextPhase = SELECTION_PHASES.ALLY;
				}
				else {
					// if not self range, set action normally
					spar_set_spell();	
				}
			
				// close book
				targetX = 0 - (spriteWidth / 2);
			}
		}
	}
	else {
		if (global.select) {
			// indicate that the player does not have enough MP	
		}
	}
	
	if (global.back) {
		spar.potentialCost = 0;
		global.mpCostDiff = 0;
		
		// set next phase
		nextPhase = SELECTION_PHASES.ALLY;
		
		// close book
		targetX = 0 - (spriteWidth / 2);
	}
	
	if (global.menu_left) {
		// check if index is at 0
		if (index > 0) {
			spar.potentialCost = 0;
			
			pageFlip = true;
			
			// set flipLeft to true
			flipLeft = true;
			
			// set flipFrame to 1
			flipFrame = flipMax;
			
			// if not, decrement index
			index--;
		
			// set current spell
			currentSpell = player.spellBook[| index];
			
			// get spell params
			spellbook_load_spell_params();
		}
	}
	
	if (global.menu_right) {
		// check if index is at max
		if (index < spellBookHeight - 1) {
			spar.potentialCost = 0;
			
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
			spellbook_load_spell_params();
		}
	}
}

if (x == targetX) && (targetX == 0 - (spriteWidth / 2)) {
	// change selectionPhase
	spar.selectionPhase = nextPhase;
	
	// destroy self
	instance_destroy(self);	
}

// if pageFlip is over, set flipRight and flipLeft to false
if !(global.gameTime mod modVar) {
	if !(pageFlip) {
		if drawFlip		drawFlip	= false;
		if flipRight	flipRight	= false;
		if flipLeft		flipLeft	= false;
	}
}

// check if pageFlip is true
if pageFlip {
	if drawFlip {
		// check if flipping right
		if flipRight {
			// if flip is over, change pageFlip to false
			if (flipFrame == flipMax) {
				if !(global.gameTime mod modVar) {
					pageFlip = false;
				}
			}
		
			// if flip isn't over, increment frame
			if (flipFrame < flipMax) {
				if !(global.gameTime mod modVar) {
					flipFrame++;
				}
			}
		}
	
		// check if flipping left
		if flipLeft {
			// if flip is over, change pageFlip to false
			if (flipFrame == 0) {
				if !(global.gameTime mod modVar) {
					pageFlip = false;	
				}
			}
			
			// if flip isn't over, decrement frame
			if (flipFrame > 0) {
				if !(global.gameTime mod modVar) {
					flipFrame--;	
				}
			}
		}
	}
}

if !drawFlip {
	if pageFlip {
		if !(global.gameTime mod modVar) {
			drawFlip = true;	
		}
	}
}