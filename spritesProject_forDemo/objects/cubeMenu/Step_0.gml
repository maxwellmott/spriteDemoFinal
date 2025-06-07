// reset all frame vars
talismanButtonFrame = 0;
wavephoneButtonFrame = 0;
inventoryButtonFrame = 0;
wardrobeButtonFrame = 0;
spellbookButtonFrame = 0;

// create a state machine using the phase variable
switch (phase) {
	case CUBE_MENU_PHASES.OPENING:
		if (topOpen) {
			// check if rectangleSurfaceY is greater than rectTargetY
			if (rectangleY > rectTargetY) {
				// move rectangleY toward rectTargetY
				rectangleY -= 2;
			}
			// if rectangleSurfaceY is less than or equal to rectTargetY
			else {	
				// move to display phase
				phase = CUBE_MENU_PHASES.DISPLAY;
			}		
		}
		else {
			// check if image_index has hit openingFinalFrame
			if (image_index >= openingFinalFrame) {
				// switch sprite index to frontLight
				sprite_index = spr_cubeMenu_frontlight;
				
				// reset image_index
				image_index = 0;
				
				// set topOpen to true
				topOpen = true;
			}		
		}
	break;
	
	case CUBE_MENU_PHASES.DISPLAY:
		// use a switch statement to manage button input
		switch(index) {
			case CUBE_MENU_BUTTONS.TALISMANS:
				talismanButtonFrame = 1;
				
				wavephoneButtonDrawY	= wavephoneButtonY + (sin(global.gameTime / 40) * 2);
				
				talismanButtonDrawY		= talismanButtonY + (sin(global.gameTime / 10) * 2);
										  
				inventoryButtonDrawY	= inventoryButtonY + (sin(global.gameTime / 40) * 2);
										  
				wardrobeButtonDrawY		= wardrobeButtonY + (sin(global.gameTime / 40) * 2);
										  
				spellbookButtonDrawY	= spellbookButtonY + (sin(global.gameTime / 40) * 2);
				
				// check for left input
				if (global.menuLeft) {
					index = CUBE_MENU_BUTTONS.WARDROBE;
				}
				
				// check for right input
				if (global.menuRight) {
					index = CUBE_MENU_BUTTONS.INVENTORY;
				}
				
				// check for up input
				if (global.menuUp) {
					index = CUBE_MENU_BUTTONS.WAVEPHONE;
				}
				
				// check for down input
				if (global.menuDown) {
					index = CUBE_MENU_BUTTONS.WAVEPHONE;
				}
				
			break;
			
			case CUBE_MENU_BUTTONS.WAVEPHONE:
				wavephoneButtonFrame = 1;
				
				wavephoneButtonDrawY	= wavephoneButtonY + (sin(global.gameTime / 10) * 2);
				
				talismanButtonDrawY		= talismanButtonY + (sin(global.gameTime / 40) * 2);
										  
				inventoryButtonDrawY	= inventoryButtonY + (sin(global.gameTime / 40) * 2);
										  
				wardrobeButtonDrawY		= wardrobeButtonY + (sin(global.gameTime / 40) * 2);
										  
				spellbookButtonDrawY	= spellbookButtonY + (sin(global.gameTime / 40) * 2);
				
				// check for left input
				if (global.menuLeft) {
					index = CUBE_MENU_BUTTONS.SPELLBOOK;
				}
				
				// check for right input
				if (global.menuRight) {
					index = CUBE_MENU_BUTTONS.SPELLBOOK;
				}
				
				// check for up input
				if (global.menuUp) {
					index = CUBE_MENU_BUTTONS.TALISMANS;
				}
				
				// check for down input
				if (global.menuDown) {
					index = CUBE_MENU_BUTTONS.INVENTORY;
				}
			break;
			
			case CUBE_MENU_BUTTONS.INVENTORY:
				inventoryButtonFrame = 1;
				
				wavephoneButtonDrawY	= wavephoneButtonY + (sin(global.gameTime / 40) * 2);
				
				talismanButtonDrawY		= talismanButtonY + (sin(global.gameTime / 40) * 2);
										  
				inventoryButtonDrawY	= inventoryButtonY + (sin(global.gameTime / 10) * 2);
										  
				wardrobeButtonDrawY		= wardrobeButtonY + (sin(global.gameTime / 40) * 2);
										   
				spellbookButtonDrawY	= spellbookButtonY + (sin(global.gameTime / 40) * 2);
				
				// check for left input
				if (global.menuLeft) {
					index = CUBE_MENU_BUTTONS.TALISMANS;
				}
				
				// check for right input
				if (global.menuRight) {
					index = CUBE_MENU_BUTTONS.WARDROBE;
				}
				
				// check for up input
				if (global.menuUp) {
					index = CUBE_MENU_BUTTONS.WAVEPHONE;
				}
				
				// check for down input
				if (global.menuDown) {
					index = CUBE_MENU_BUTTONS.SPELLBOOK;
				}
			break;
			
			case CUBE_MENU_BUTTONS.WARDROBE:
				wardrobeButtonFrame = 1;
				
				wavephoneButtonDrawY	= wavephoneButtonY + (sin(global.gameTime / 40) * 2);
				
				talismanButtonDrawY		= talismanButtonY + (sin(global.gameTime / 40) * 2);
										  
				inventoryButtonDrawY	= inventoryButtonY + (sin(global.gameTime / 40) * 2);
										  
				wardrobeButtonDrawY		= wardrobeButtonY + (sin(global.gameTime / 10) * 2);
										  
				spellbookButtonDrawY	= spellbookButtonY + (sin(global.gameTime / 40) * 2);
				
				// check for left input
				if (global.menuLeft) {
					index = CUBE_MENU_BUTTONS.INVENTORY;
				}
				
				// check for right input
				if (global.menuRight) {
					index = CUBE_MENU_BUTTONS.TALISMANS;
				}
				
				// check for up input
				if (global.menuUp) {
					index = CUBE_MENU_BUTTONS.SPELLBOOK;
				}
				
				// check for down input
				if (global.menuDown) {
					index = CUBE_MENU_BUTTONS.SPELLBOOK;
				}
			break;
			
			case CUBE_MENU_BUTTONS.SPELLBOOK:
				spellbookButtonFrame = 1;
				
				wavephoneButtonDrawY	= wavephoneButtonY + (sin(global.gameTime / 40) * 2);
				
				talismanButtonDrawY		= talismanButtonY + (sin(global.gameTime / 40) * 2);
										  
				inventoryButtonDrawY	= inventoryButtonY + (sin(global.gameTime / 40) * 2);
										  
				wardrobeButtonDrawY		= wardrobeButtonY + (sin(global.gameTime / 40) * 2);
										  
				spellbookButtonDrawY	= spellbookButtonY + (sin(global.gameTime / 10) * 2);
				
				// check for left input
				if (global.menuLeft) {
					index = CUBE_MENU_BUTTONS.WAVEPHONE;
				}
				
				// check for right input
				if (global.menuRight) {
					index = CUBE_MENU_BUTTONS.WAVEPHONE;
				}
				
				// check for up input
				if (global.menuUp) {
					index = CUBE_MENU_BUTTONS.INVENTORY;
				}
				
				// check for down input
				if (global.menuDown) {
					index = CUBE_MENU_BUTTONS.WARDROBE;
				}
			break;
		}
		
		// check for a click
			// check all bboxes for collisions with the mouse
			
		// check for backout input
		if (global.back) {
			// set new rectTargetY
			rectTargetY = 40;
			
			// move to closing phase
			phase = CUBE_MENU_PHASES.CLOSING;
		}
		
		// check for selection input
		if (global.select) {
			// set new rectTargetY
			rectTargetY = 40;
			
			// set selectedFunction
			selectedFunction = buttonFunctions[| index];
			
			// move to closing phase
			phase = CUBE_MENU_PHASES.CLOSING;
		}
	break;
	
	case CUBE_MENU_PHASES.CLOSING:
		// check if rectangleY is less than rectTargetY
		if (rectangleY < rectTargetY) {
			rectangleY += 2;
		}
		// if rectangleY has reached rectTargetY
		else {
			// check if top is still open
			if (topOpen) {
				// set sprite_index to closing animation
				sprite_index = spr_cubeMenu_closing;
				
				// reset image_index
				image_index = 0;
				
				// unset topOpen
				topOpen = false;
			}
			// if top is no longer open
			else {
				// check if animation is finished
				if (floor(image_index) >= closingFinalFrame) {
					// destroy this instance
					instance_destroy(id);
				}
			}
		}
	break;
}

// check if sprite_index is set to frontLight
if (sprite_index == spr_cubeMenu_frontlight) {
	var modVar = glowBarFrame mod frontLightFrameCount;
	
	// check if glowBarFrame needs to be incremented
	if (floor(image_index) != (modVar)) {
		// reset glowBarFrame
		glowBarFrame = floor(image_index) + (frontLightCount * frontLightFrameCount);
		
		// check if image_idnex has reached frontLightCount
		if (floor(image_index) >= frontLightFrameCount - 1) {
			frontLightCount++;
		}
		
		// check if frontLightCount has reached frontLightCycle
		if (frontLightCount >= frontLightCycle) {
			frontLightCount = 0;	
		}
	}
}