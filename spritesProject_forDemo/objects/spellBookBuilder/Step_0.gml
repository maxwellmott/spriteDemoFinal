/// @description Insert description here
// You can write your code in this editor

if (spellBookX < spellBookTargetX) {
	spellBookX += 2;	
}

if (spellBookX > spellBookTargetX) && (spellBookFrame == 0) {
	spellBookX -= 2;	
}

if (spellBookX == targetX) && (spellBookFrame < spellBookFrameMax) {
	if !(global.gameTime mod 4) spellBookFrame++;
}

if (spellBookX > targetX) && (spellBookFrame > 0) {
	if !(global.gameTime mod 4) spellBookFrame--;
}

if (spellBookX == targetX) 
&& (targetX == spriteWidth / 2) {
	if (shadeAlpha <= 0.0) {		
		if !(pageFlip) {
			
			// check if the mouse is being clicked
			if (global.click) {
				// @TODO check for any current spell name selection
				var i = 0;	repeat (ds_list_size(nameSlotBottoms)) {
					// get the bbox params for the current spell
					var left	= nameSlotLefts[| i];
					var right	= nameSlotRights[| i];
					var top		= nameSlotTops[| i];
					var bottom	= nameSlotBottoms[| i];
					
					// check for a collision
					if (collision_rectangle(left, top, right, bottom, mouse, false, false)) {
						selectedSpellSlot = i;	
						break;
					}
					
					// increment i
					i++;
				}
			}
			
			// check if there has been a recent category change
			if !(categoryChanging) {
				// check for a click on the category button
				if (collision_rectangle(cFlash_bbLeft, cFlash_bbTop, cFlash_bbRight, cFlash_bbBottom, mouse, false, false)) {
					if (global.click) {
						// start category alarm
						alarm[0] = 24;
						
						// increment current category
						currentCategory++;
						
						// loop through spell types
						if (currentCategory >= SPELL_TYPES.HEIGHT + 1)	currentCategory -= SPELL_TYPES.HEIGHT + 1;
						
						// reset categoryString
						categoryString = spell_type_get_string(currentCategory);
						
						// set page flip to true
						pageFlip = true;
						
						// set flipLeft to true
						flipLeft = true;
						
						// set flipFrame to 1
						flipFrame = flipMax;
						
						currentSpellIndex = 0;
						
						// get the current catList
						var cl = categoryLists[| currentCategory];
						
						// set current spell
						currentSpell = cl[| currentSpellIndex];
						
						// get spell params
						builder_load_spell_params();
						
						// change categoryChanging to true
						categoryChanging = true;
					}
				}
			}
			
			if (global.menu_left) {
				// check if currentSpellIndex is at 0
				if (currentSpellIndex > 0) {
					
					pageFlip = true;
					
					// set flipLeft to true
					flipLeft = true;
					
					// set flipFrame to 1
					flipFrame = flipMax;
					
					// if not, decrement currentSpellIndex
					currentSpellIndex--;
				
					// get the current catList
					var cl = categoryLists[| currentCategory];
					
					// set current spell
					currentSpell = cl[| currentSpellIndex];
					
					// get spell params
					builder_load_spell_params();
				}
			}
		
			if (global.menu_right) {
				// check if currentSpellIndex is at max
				if (currentSpellIndex < ds_list_size(categoryLists[| currentCategory]) - 1) {					
					pageFlip = true;
						
					// set flipRight to true
					flipRight = true;
				
					// set flipFrame to 0
					flipFrame = 0;
					
					// if not, increment currentSpellIndex
					currentSpellIndex++;
					
					// get the current catList
					var cl = categoryLists[| currentCategory];
					
					// set current spell
					currentSpell = cl[| currentSpellIndex];
					
					// get spell params
					builder_load_spell_params();
				}
			}
		}
		
		// check if select is being pressed
		if (global.select) {		
			// check that selectedSpellSlot is set
			if (selectedSpellSlot >= 0) {
				// check that currentSpell is not already on the spellBookList
				if (ds_list_find_index(spellBookList, currentSpell) == -1) {
					spellBookList[| selectedSpellSlot] = currentSpell;	
					selectedSpellSlot = -1;
				}
				// if currentSpell is already on spellBook list
				else {
					// push error SFX
				}
			}
		}
		
		if (global.back) {		
			// close book
			targetX = 0 - (spriteWidth / 2);
		}
	}
	else	{
		// decrement shade alpha	
		shadeAlpha -= 0.05;
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

if !(onlineWaiting) {	
	if (global.start) {
		player.spellBookString = "";
		player.spellBookString = encode_list(spellBookList);			
		
		if (instance_exists(onlineEnemy)) {
			client_set_match_ready();	
			onlineWaiting = true;		
		}
		else	{			
			room_transition(player.x, player.y, player.facing, rm_overworld, bgm_springRelaxSunny);
		}
	}
}

if (onlineWaiting) {
	if !(cancelled) {
		if (global.back) {
			player_cancel_spellbook();
		}
		
		// check if the enemy is ready every couple of turns
		if !(global.gameTime mod 600)	ready_check_begin();
	}
}

if (x == targetX) && (targetX == 0 - (spriteWidth / 2)) {

	// destroy self
	instance_destroy(self);	
}