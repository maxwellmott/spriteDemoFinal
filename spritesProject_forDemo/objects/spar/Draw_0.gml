#macro MAX_HP	1000
#macro MAX_MP	100

draw_set_font(plainFont);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(COL_BLACK);

// draw background
draw_sprite(spr_sparBackground, 0, 0, 0);

// draw arena if there is one

#region ALLIES AND ENEMIES
var i = 0; repeat (8) {
	// get sprite instance ID
	var inst = spriteList[| i];
	
	// set alpha
	draw_set_alpha(inst.alpha);
	
	var spriteFrame = 0;
	
	// check if inst is swapping
	if (inst.swapping) {
		// set sriteFrame to image_index
		spriteFrame = image_index;
		
		if (inst.resting) && !(instance_exists(sparRestProcessor)) {
			spriteFrame = 15;	
		}
	}
	else if (inst.resting) {
		// check if animation has started and not stopped
		if (instance_exists(sparRestProcessor)) {
			if (sparRestProcessor.animationStarted)
			&& !(sparRestProcessor.animationStopped) {
				// set spriteFrame to image_index
				spriteFrame = image_index;
			}
			
			// check if animation has stopped
			if (sparRestProcessor.animationStopped)	spriteFrame = 15;
		}
		else	spriteFrame = 15;
	}
	else {
		//spriteFrame = inst.currentPose;
		spriteFrame = 0;
	}
	
	if (inst.dodging) && (inst.sprite == spr_sparDodge) {
		spriteFrame = image_index;
	}	else _spriteFrame = 0;
	
	// check if inst is an enemy or an ally
	if (i < 4) {
		// draw sprite
		draw_sprite(inst.sprite, spriteFrame, inst.x, inst.y);
	}
	else {
		// draw sprite flipped
		draw_sprite_ext(inst.sprite, spriteFrame, inst.x, inst.y, -1, 1, 0, c_white, inst.alpha);
	}

	
	// if sprite has any status effects, draw the indicators
	if (inst.hexed) draw_sprite(spr_sparHexed, 0, inst.hexedX, inst.hexedY);
	if (inst.bound) draw_sprite(spr_sparBound, 0, inst.boundX, inst.boundY);
	
	// if sprite has a curse or blessing, draw the indicator
	if (inst.mindset > 0) draw_sprite(spr_sparBlessings,	abs(inst.mindset) - 1,	inst.mindsetX, inst.mindsetY);
	if (inst.mindset < 0) draw_sprite(spr_sparCurses,		abs(inst.mindset) - 1,	inst.mindsetX, inst.mindsetY);

	// if sprite's readyDisplay is built, draw the box and the text
	if (inst.readyDisplayBuilt) {
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		
		draw_set_font(plainFont);
		
		draw_sprite(spr_readyDisplayBox, 0, inst.x, inst.y);
		draw_text_pixel_perfect(inst.x - 27, inst.y - 15, inst.readyDisplay, 1);
	}
	
	// reset halign and valign
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);

	// increment i
	i++;
}

// reset alpha
draw_set_alpha(1.0);

#endregion

#region SELECTION INTERFACE
	if !(instance_exists(sparReadyButton)) {
		draw_set_font(plainFont);
		
		// draw selectionMenu
		if (sparPhase == sparPhases.select) {
			draw_sprite(spr_sparSelectionMenu, 0, selectionMsgX, selectionMsgY);
			if !(instance_exists(sparReadyButton)) {
				draw_text_pixel_perfect(selectionMsgX, selectionMsgY, selectionMsg, 1);
			}
		}
		
		// if there is an action button, draw all the buttons
		if (instance_exists(sparActionButton)) {
			var count = instance_number(sparActionButton);
			
			var i = 0;	repeat (count) {
				var inst = sparActionMenu.actionButtons[| i];
				
				draw_sprite(spr_sparActionButton, inst.frame, inst.x, inst.y);
				draw_set_color(inst.textColor);
				
				draw_text_pixel_perfect(inst.x, inst.y + 3, inst.name, 1);
				
				i++;
			}
			
			draw_set_color(COL_BLACK);
		}
	}
#endregion

#region SPELL MENU
	// check that spellMenu exists
	if (instance_exists(sparSpellMenu)) {
		
		// draw spellBook
		draw_sprite(sparSpellMenu.sprite, sparSpellMenu.frame, sparSpellMenu.x, sparSpellMenu.y);
		
		// draw spell info display
		draw_sprite(sparSpellMenu.infoDisplaySprite, 0, sparSpellMenu.infoDisplayX, sparSpellMenu.infoDisplayY);
	
		// if the book is open and the page isn't being flipped, draw the current spell icon and all spell params
		if !(sparSpellMenu.drawFlip) && (sparSpellMenu.frame == 5) {
			draw_set_font(spellbookFont);
			
			draw_sprite(spr_spellBookIconSheet, sparSpellMenu.currentSpell, sparSpellMenu.x, sparSpellMenu.y + 4);
			
			draw_sprite(spr_spellRangeIndicator, sparSpellMenu.spellRange, sparSpellMenu.rangeDrawX, sparSpellMenu.rangeDrawY);
			draw_sprite(spr_spellTypeIndicator, sparSpellMenu.spellType, sparSpellMenu.typeDrawX, sparSpellMenu.typeDrawY);
			
			draw_text_pixel_perfect(sparSpellMenu.powerDrawX, sparSpellMenu.powerDrawY, string(sparSpellMenu.spellPower), 0.5);
			draw_text_pixel_perfect(sparSpellMenu.costDrawX, sparSpellMenu.costDrawY, string(sparSpellMenu.spellCost), 0.5);
			
			draw_set_halign(fa_left);
			draw_set_valign(fa_top);
			
			draw_text_transformed(sparSpellMenu.descDrawX, sparSpellMenu.descDrawY, sparSpellMenu.description, 0.5, 0.5, 0);
			
			draw_set_halign(fa_center);
			draw_set_valign(fa_middle);
		}
		
		// check if pageFlip is happening
		if (sparSpellMenu.drawFlip) {
			draw_sprite(spr_spellBookPageFlip, sparSpellMenu.flipFrame, sparSpellMenu.x, sparSpellMenu.y);	
		}
	}
#endregion

#region SPELL FX DARK LAYER
	// check if the action processor is present
	if (instance_exists(sparActionProcessor)) {
		// set alpha to match shadeAlpha
		draw_set_alpha(sparActionProcessor.shadeAlpha);
		
		// draw the spell shade surface
		draw_surface(spellShadeSurface, 0, 0);
		
		// reset alpha
		draw_set_alpha(1.0);
	}

#endregion

#region SPELL FX
	if (instance_exists(sparSpellFX)) {
		draw_sprite(sparSpellFX.spellAnimation, image_index, sparSpellFX.drawX, sparSpellFX.drawY);
	}
	
	if (instance_exists(sparEffectAlert)) {
		if (sparEffectAlert.drawingMultiple) {
			var i = 0;	repeat (ds_list_size(sparEffectAlert.effectedSprites)) {
				draw_sprite(sparEffectAlert.animation, image_index, sparEffectAlert.effectedSprites[| i].x, sparEffectAlert.effectedSprites[| i].y);
				
				i++;
			}
		}	else {
			draw_sprite(sparEffectAlert.animation, image_index, sparEffectAlert.drawX, sparEffectAlert.drawY);	
		}
	}
#endregion

#region USER INTERFACE

	// set alpha to uiAlpha
	draw_set_alpha(uiAlpha);
	
	// draw nameplates
	draw_sprite(spr_sparPlayerNameplate, 0, guiWidth, guiHeight);
	draw_sprite(spr_sparEnemyNameplate, 0, 0, 0);
	
	// draw titles and names
	
	// draw HPMP symbols
	draw_sprite(spr_sparHPMP, 0, 120, guiHeight - 8);
	draw_sprite(spr_sparHPMP, 0, 135, 8);
	
	// draw playerBars surface
	draw_surface_ext(playerBarSurface, playerBarSurfaceX, playerBarSurfaceY, -1, 1, 0, COL_WHITE, uiAlpha);
	
	// draw enemyBars surface
	draw_surface(enemyBarSurface, enemyBarSurfaceX, enemyBarSurfaceY);
	
	// draw hindrance indicators
	if (playerOne.miasma)	draw_sprite(spr_sparMiasma, 0,	playerOne.miasmaX,	playerOne.miasmaY);
	if (playerOne.hum)		draw_sprite(spr_sparHum,	0,	playerOne.humX,		playerOne.humY);
	if (playerOne.rust)		draw_sprite(spr_sparRust,	0,	playerOne.rustX,	playerOne.rustY);
	
	if (playerTwo.miasma)	draw_sprite(spr_sparMiasma,	0,	playerTwo.miasmaX,	playerTwo.miasmaY);
	if (playerTwo.hum)		draw_sprite(spr_sparHum,	0,	playerTwo.humX,		playerTwo.humY);
	if (playerTwo.rust)		draw_sprite(spr_sparRust,	0,	playerTwo.rustX,	playerTwo.rustY);
	
	// draw turn message
	if (turnMsg != "") {	
		draw_set_font(plainFont);
		
		draw_sprite(spr_sparTurnMessage, 0, turnMsgX, turnMsgY);
		draw_text_pixel_perfect(turnMsgX, turnMsgY, turnMsg, 1);
	}

	draw_set_alpha(1.0);
#endregion

#region HOVER MENU
	if (sparPhase == sparPhases.select)
	&& (selectionPhase != selectionPhases.action) {
		if (global.hoverSprite != -1) {
			if (global.shiftPressed) {
				draw_set_font(plainFont);
				draw_set_halign(fa_center);
				draw_set_valign(fa_bottom);
				draw_set_color(COL_WHITE);
				
				var hs = global.hoverSprite;
				
				// draw message sprite
				draw_sprite(spr_sparMessage, 0, turnMsgX, turnMsgY);
				
				// draw hoverMenu sprite
				draw_sprite(spr_sparHoverMenuNameplate, 0, hoverMenu_nameplateX, hoverMenu_nameplateY);
				
				// draw name
				draw_text_pixel_perfect(hoverMenu_nameplateX, hoverMenu_nameplateY, hs.name, 1);
				
				draw_set_color(COL_BLACK);
				
				draw_set_halign(fa_left);
				
				// draw alignment and size
				draw_text_pixel_perfect(hoverMenu_alignmentX,	hoverMenu_alignmentY,	"TYPE   " + sprite_get_size_string(hs.currentAlign), 1);
				draw_text_pixel_perfect(hoverMenu_sizeX,			hoverMenu_sizeY,		"SIZE   " + sprite_get_size_string(hs.currentSize), 1);
				
				draw_set_halign(fa_center);
				
				#region DRAW POWER
				
					// draw label
					draw_text_pixel_perfect(hoverMenu_columnOneX,		hoverMenu_rowOneY,		"POWER", 1);
					
					// check if the stat has been changed at all
					if (hs.currentPower < hs.basePower) draw_set_color(c_red);
					if (hs.currentPower > hs.basePower) draw_set_color(c_green);
					
					// draw stat
					draw_text_pixel_perfect(hoverMenu_columnOneX,		hoverMenu_rowTwoY,		string(hs.currentPower), 1);
					
					// reset color to black
					draw_set_color(COL_BLACK);
				
				#endregion
				
				#region DRAW RESISTANCE
				
					// draw label
					draw_text_pixel_perfect(hoverMenu_columnOneX,		hoverMenu_rowThreeY,	"RESIST", 1);
					
					// check if the stat has been changed at all
					if (hs.currentResist < hs.baseResist)	draw_set_color(c_red);
					if (hs.currentResist > hs.baseResist)	draw_set_color(c_green);
					
					// draw stat
					draw_text_pixel_perfect(hoverMenu_columnOneX,		hoverMenu_rowFourY,		string(hs.currentResist), 1);
					
					// reset color to black
					draw_set_color(COL_BLACK);
				
				#endregion
				
				#region DRAW AGILITY
				
					// draw label
					draw_text_pixel_perfect(hoverMenu_columnTwoX,			hoverMenu_rowOneY,		"AGILITY", 1);
					
					// check if the stat has been changed at all
					if (hs.currentAgility < hs.baseAgility)	draw_set_color(c_red);
					if (hs.currentAgility > hs.baseAgility)	draw_set_color(c_green);
					
					// draw stat
					draw_text_pixel_perfect(hoverMenu_columnTwoX,		hoverMenu_rowTwoY,		string(hs.currentAgility), 1);
					
					// reset color to black
					draw_set_color(COL_BLACK);

				#endregion
				
				#region DRAW LUCK
				
					// draw label
					draw_text_pixel_perfect(hoverMenu_columnTwoX,		hoverMenu_rowThreeY,	"LUCK", 1);
					
					// check if the stat has been changed at all
					if (hs.currentLuck < hs.baseLuck)		draw_set_color(c_red);
					if (hs.currentLuck > hs.baseLuck)		draw_set_color(c_green);
					
					// draw stat
					draw_text_pixel_perfect(hoverMenu_columnTwoX,		hoverMenu_rowFourY,		string(hs.currentLuck), 1);
					
					// reset color to black
					draw_set_color(COL_BLACK);
				
				#endregion
				
				#region DRAW FIRE
				
					// draw label
					draw_text_pixel_perfect(hoverMenu_columnThreeX,		hoverMenu_rowOneY,		"FIRE", 1);
					
					// check if the stat has been changed at all
					if (hs.currentFire < hs.baseFire)		draw_set_color(c_red);
					if (hs.currentFire > hs.baseFire)		draw_set_color(c_green);
					
					// draw stat
					draw_text_pixel_perfect(hoverMenu_columnThreeX,		hoverMenu_rowTwoY,		string(hs.currentFire), 1);
					
					// reset color to black
					draw_set_color(COL_BLACK);
				
				#endregion
				
				#region DRAW WATER
				
					// draw label
					draw_text_pixel_perfect(hoverMenu_columnThreeX,		hoverMenu_rowThreeY,	"WATER", 1);
					
					// check if the stat has been changed at all
					if (hs.currentWater < hs.baseWater)		draw_set_color(c_red);
					if (hs.currentWater > hs.baseWater)		draw_set_color(c_green);
					
					// draw stat
					draw_text_pixel_perfect(hoverMenu_columnThreeX,		hoverMenu_rowFourY,		string(hs.currentWater), 1);
					
					// reset color to black
					draw_set_color(COL_BLACK);
				
				#endregion
				
				#region DRAW STORM

					// draw the label
					draw_text_pixel_perfect(hoverMenu_columnFourX,		hoverMenu_rowOneY,		"STORM", 1);
					
					// check if the stat has been changed at all
					if (hs.currentStorm < hs.baseStorm)		draw_set_color(c_red);
					if (hs.currentStorm > hs.baseStorm)		draw_set_color(c_green);
					
					// draw stat
					draw_text_pixel_perfect(hoverMenu_columnFourX,		hoverMenu_rowTwoY,		string(hs.currentStorm), 1);
					
					// reset the color to black
					draw_set_color(COL_BLACK);
				
				#endregion
				
				#region DRAW EARTH
				
					// draw label
					draw_text_pixel_perfect(hoverMenu_columnFourX,		hoverMenu_rowThreeY,	"EARTH", 1);
					
					// check if the stat has been changed at all
					if (hs.currentEarth < hs.baseEarth)		draw_set_color(c_red);
					if (hs.currentStorm > hs.baseStorm)		draw_set_color(c_green);
					
					// draw stat
					draw_text_pixel_perfect(hoverMenu_columnFourX,		hoverMenu_rowFourY,		string(hs.currentEarth), 1);
					
					// reset color to black
					draw_set_color(COL_BLACK);
				
				#endregion
			}
		}
	}
	
	// check that shift is not being pressed
	if !(global.shiftPressed) {
		with (sparReadyButton) {
			draw_sprite(spr_sparReadyButton,	frame,	x1,	y);
			draw_sprite(spr_sparReadyButton,	frame,	x2,	y);
			draw_sprite(spr_sparReadyButton,	frame,	x3, y);
			draw_sprite(spr_sparReadyButton,	frame,	x4, y);
			draw_sprite(spr_sparReadyButton,	frame,	x5,	y);
			draw_sprite(spr_sparReadyButton,	frame,	x6,	y);
			draw_sprite(spr_sparReadyButton,	frame,	x7,	y);
			draw_sprite(spr_sparReadyButton,	frame,	x8, y);
		}
	}
#endregion
