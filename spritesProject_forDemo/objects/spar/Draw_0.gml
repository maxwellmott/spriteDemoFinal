if !(surface_exists(playerBarSurface))		playerBarSurface = surface_create(48, 16);
if !(surface_exists(enemyBarSurface))		enemyBarSurface = surface_create(48, 16);

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
	
	// check if sprite is flashing
	if (inst.flashRate != -1) {
		if (inst.flashNum == 0)		global.gameTime -= global.gameTime mod inst.flashRate;
		
		// check if its a flash frame
		if (global.gameTime mod inst.flashRate <= 4) {
			// if this is the first frame of a flash of visibility, increment the flashNum by 1
			if (global.gameTime mod inst.flashRate == 0)		inst.flashNum += 1;
			
			draw_sprite_ext(inst.sprite, spriteFrame, inst.x, inst.y, inst.xscale, 1, 0, c_white, inst.alpha);
			
			// if this is the last frame of a flash of visibility, and the flashNum has already 
			// reached the flashCount, set the alarm to reset the flash variables
			if (global.gameTime mod inst.flashRate == 4)
			&& (inst.flashNum == inst.flashCount) {
				inst.flashNum = 0;
				inst.flashRate = -1;
				inst.flashCount = -1;
			}
		}
	}	else	{
		// else draw the sprite normally
		draw_sprite_ext(inst.sprite, spriteFrame, inst.x, inst.y, inst.xscale, 1, 0, c_white, inst.alpha);
	}
	
	// if sprite has any status effects, draw the indicators
	if (inst.hexed) draw_sprite(spr_sparHexed, 0, inst.hexedX, inst.hexedY);
	if (inst.bound) draw_sprite(spr_sparBound, 0, inst.boundX, inst.boundY);
	if (inst.invulnerable)	draw_sprite(spr_sparInvulnerable,	0, inst.hexedX, inst.hexedY);
	if (inst.berserk)		draw_sprite(spr_sparBerserk,		0, inst.hexedX, inst.hexedY);
	
	// if sprite has a curse or blessing, draw the indicator
	if (inst.mindset != MINDSETS.NORMAL) {
		// if it is a blessing
		if (inst.mindset < MINDSETS.TREE_CURSE)	 draw_sprite(spr_sparBlessings,	inst.mindset - 1,	inst.mindsetX, inst.mindsetY);
		
		// if it is a curse
		if (inst.mindset >= MINDSETS.TREE_CURSE)	draw_sprite(spr_sparCurses,		inst.mindset - 5,	inst.mindsetX, inst.mindsetY);
	}

	// if sprite's readyDisplay is built, draw the box and the text
	if (inst.readyDisplayBuilt) {
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		
		draw_set_font(plainFont);
		
		draw_sprite(spr_readyDisplayBox, 0, inst.x, inst.y);
		draw_text_pixel_perfect(inst.x - 27, inst.y - 15, inst.readyDisplay, 7, sprite_get_width(spr_readyDisplayBox) - 4);
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

#region DRAW ARENA DISPLAY

	// check if arena is not normal
	if (currentArena != -1) {
		// draw arena tiled across the screen
		draw_sprite(spr_sparArenas, currentArena, 0,				guiHeight / 2 - 16);
		draw_sprite(spr_sparArenas, currentArena, guiWidth / 4,		guiHeight / 2 - 16);
		draw_sprite(spr_sparArenas, currentArena, guiWidth / 2,		guiHeight / 2 - 16);
		draw_sprite(spr_sparArenas, currentArena, guiWidth * 0.75,	guiHeight / 2 - 16);
	}
	
#endregion

#region SELECTION INTERFACE
	if !(instance_exists(sparReadyButton)) 
	&& !(instance_exists(sparEffectAlert)) {
		draw_set_font(plainFont);
		
		// draw selectionMenu
		if (sparPhase == SPAR_PHASES.SELECT) {
			draw_sprite(spr_sparSelectionMenu, 0, selectionMsgX, selectionMsgY);
			if !(instance_exists(sparReadyButton)) {
				draw_text_pixel_perfect(selectionMsgX, selectionMsgY, selectionMsg, 1, 256);
			}
		}
		
		// check if sparActionMenu exists
		if (instance_exists(sparActionMenu)) {
			// if there is an action button, draw all the buttons
			if (instance_exists(sparActionButton)) {
				var count = instance_number(sparActionButton);
				
				var i = 0;	repeat (count) {
					if !(instance_exists(sparActionMenu))	break;
					
					var inst = sparActionMenu.actionButtons[| i];
					
					draw_sprite(spr_sparActionButton, inst.frame, inst.x, inst.y);
					draw_set_color(inst.textColor);
					
					draw_text_pixel_perfect(inst.x, inst.y + 3, inst.name, 1, 256);
					
					i++;
				}
			
				draw_set_color(COL_BLACK);
			}
		}
	}
#endregion

#region SPELL MENU
	// check that spellMenu exists
	if (instance_exists(sparSpellMenu)) {
		// get params for selection message
		var sm = "What spell should " + player.selectedAlly.name + " cast?";
		var smx = selectionMsgX;
		var smy = selectionMsgY - (sprite_get_height(sparSpellMenu.sprite) / 2) + (sprite_get_height(spr_sparSelectionMenu) / 2);
		
		// draw selection message
		draw_sprite(spr_sparSelectionMenu, 0, selectionMsgX, smy);
		draw_text_pixel_perfect(selectionMsgX, smy, sm, 1, 256);
		
		// draw spellBook
		draw_sprite(sparSpellMenu.sprite, sparSpellMenu.frame, sparSpellMenu.x, sparSpellMenu.y);
		
		// set info display alpha
		draw_set_alpha(sparSpellMenu.infoDisplayAlpha);
		
		// draw spell info display
		draw_sprite(sparSpellMenu.infoDisplaySprite, 0, sparSpellMenu.infoDisplayX, sparSpellMenu.infoDisplayY);
	
		// if the book is open and the page isn't being flipped, draw the current spell icon and all spell params
		if !(sparSpellMenu.drawFlip) && (sparSpellMenu.frame == 5) {
			draw_set_font(spellbookFont);
			
			// if spell cannot be used, draw it in grayscale
			if (ds_list_find_index(sparSpellMenu.usableSpells, sparSpellMenu.currentSpell) == -1) {
				gpu_set_fog(true, c_black, 0, 666);
				draw_sprite(sparSpellMenu.sprite, sparSpellMenu.frame, sparSpellMenu.x, sparSpellMenu.y);
				draw_sprite(spr_spellBookIconSheet, sparSpellMenu.currentSpell, sparSpellMenu.x, sparSpellMenu.y + 4);
				gpu_set_fog(false, c_gray, 0, 100);
				
				 draw_sprite(spr_unusableSpell, 0, sparSpellMenu.x, sparSpellMenu.y + 8);
			}	else	{
				// else draw it normally
				draw_sprite(spr_spellBookIconSheet, sparSpellMenu.currentSpell, sparSpellMenu.x, sparSpellMenu.y + 4);
			}
			draw_sprite(spr_spellRangeIndicator, sparSpellMenu.spellRange, sparSpellMenu.rangeDrawX, sparSpellMenu.rangeDrawY);
			draw_sprite(spr_spellTypeIndicator, sparSpellMenu.spellType, sparSpellMenu.typeDrawX, sparSpellMenu.typeDrawY);
			
			// check if power is greater than 0
			if (sparSpellMenu.spellPower > 0) {
				draw_text_pixel_perfect(sparSpellMenu.powerDrawX, sparSpellMenu.powerDrawY, string(sparSpellMenu.spellPower), 1, 256);
			}	else	{
				draw_text_pixel_perfect(sparSpellMenu.powerDrawX, sparSpellMenu.powerDrawY + 1, "--", 1, 256);	
			}
			
			// check if cost is greater than 0
			if (sparSpellMenu.spellCost > 0) {
				draw_text_pixel_perfect(sparSpellMenu.costDrawX, sparSpellMenu.costDrawY, string(sparSpellMenu.spellCost), 1, 256);	
			}	else	{
				draw_text_pixel_perfect(sparSpellMenu.costDrawX, sparSpellMenu.costDrawY, "--", 1, 256);	
			}
			
			draw_set_halign(fa_left);
			draw_set_valign(fa_top);
			
			draw_text_pixel_perfect(sparSpellMenu.descDrawX, sparSpellMenu.descDrawY, sparSpellMenu.description, 8, sparSpellMenu.infoBannerWidth);
			
			draw_set_halign(fa_center);
			draw_set_valign(fa_middle);
		}
		
		// reset alpha
		draw_set_alpha(1.0);
		
		// check if pageFlip is happening
		if (sparSpellMenu.drawFlip) {
			draw_sprite(spr_spellBookPageFlip, sparSpellMenu.flipFrame, sparSpellMenu.x, sparSpellMenu.y);	
		}
	}
#endregion

#region SPELL FX DARK LAYER
	if (instance_exists(sparActionProcessor)) 
	&& !(sparActionProcessor.spellFailed) {
		// set alpha to sparActionProcessor.shadeAlpha
		draw_set_alpha(sparActionProcessor.shadeAlpha);
		
		// draw rectangle
		draw_rectangle_color(0, 0, guiWidth, guiHeight, c_black, c_black, c_black, c_black, false);
		
		// reset alpha
		draw_set_alpha(1.0);
		
		// set fog distance (it decrements from 1000 - 750 relative to shadeAlphaMax's incrementing) this causes
		// the gray to slowly fade in
		var fd = 1000 - ((sparActionProcessor.shadeAlpha / sparActionProcessor.shadeAlphaMax) * 250);
		
		// store global.spellTargetTeam in a local var
		var stt = global.spellTargetTeam;
		
		// check if an instance id is being stored in stt
		if (stt > 0) {
			if (stt == playerOne) {
				var i = 0;	repeat (ds_list_size(allyList)) {
					var sid = allyList[| i];
					
					draw_sprite_ext(sid.sprite, 0, sid.x, sid.y, sid.xscale, 1, 0, c_white, 1.0);
					
					i++;
				}
			}
		}	else	{
			// get active sprite and target sprite
			var a = sparActionProcessor.activeSprite;
			var t = sparActionProcessor.targetSprite;
		
			gpu_set_fog(true, c_white, 0.0, 1.0);
		
			// draw target sprite normal
			draw_sprite_ext(t.sprite, 0, t.x, t.y, t.xscale, 1, 0, c_white, sparActionProcessor.shadeAlpha);
			
			gpu_set_fog(false, c_white, 0.0, 1.0);
		
			// check if active sprite is the same as target sprite
			if (a != t) {
				// if not, draw active sprite
				draw_sprite_ext(a.sprite, 0, a.x, a.y, a.xscale, 1, 0, c_white, 1.0);
			}
		}
	}
#endregion
	
#region SPELL FX / SPAR FX
	if (instance_exists(sparSpellFX)) {
		draw_sprite(sparSpellFX.spellAnimation, image_index, sparSpellFX.drawX, sparSpellFX.drawY);
	}
	
	if (instance_exists(sparEffectAlert))
	&& (sparEffectAlert.drawReady) {
		if (sparEffectAlert.animation >= 0) {
			var i = 0;	repeat (ds_list_size(sparEffectAlert.xList)) {
				draw_sprite(sparEffectAlert.animation, image_index, sparEffectAlert.xList[| i], sparEffectAlert.yList[| i]);
				
				i++;
			}
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
	
	// set alignment for player HPMP numbers
	draw_set_halign(fa_right);
	
	// draw HPMP numbers
	draw_text_pixel_perfect(64, guiHeight - 12, playerOne.currentHP, 7, 16);
	draw_text_pixel_perfect(64, guiHeight - 6, playerOne.currentMP, 7, 16);
	
	// set alignment for enemy HPMP numbers
	draw_set_halign(fa_left);
	
	draw_text_pixel_perfect(192, 6, playerTwo.currentHP, 7, 16);
	draw_text_pixel_perfect(192, 12, playerTwo.currentMP, 7, 16);
	
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
	
	// reset alignment for turnMsg
	draw_set_halign(fa_center);
	
	// draw turn message
	if (turnMsg != "") {	
		draw_set_font(plainFont);
		
		draw_sprite(spr_sparTurnMessage, 0, turnMsgX, turnMsgY);
		draw_text_pixel_perfect(turnMsgX, turnMsgY, turnMsg, 7, 256);
	}

	draw_set_alpha(1.0);
#endregion

#region HOVER MENU
	if (sparPhase == SPAR_PHASES.SELECT)
	&& (selectionPhase != SELECTION_PHASES.ACTION) {
		if (global.hoverSprite != -1) {
			if (global.shiftPressed) {
				draw_set_font(plainFont);
				draw_set_halign(fa_center);
				draw_set_color(COL_WHITE);
				
				var hs = global.hoverSprite;
				
				// draw message sprite
				draw_sprite(spr_inspectMenuBackdrop, 0, turnMsgX, turnMsgY);
				
				// draw hoverMenu sprite
				draw_sprite(spr_sparHoverMenuNameplate, 0, hoverMenu_nameplateX, hoverMenu_nameplateY);
				
				// draw name
				draw_text_pixel_perfect(hoverMenu_nameplateX, hoverMenu_nameplateY + 3.5, hs.name, 1, 256);
				
				draw_set_color(COL_BLACK);
				
				draw_set_halign(fa_left);
				draw_set_valign(fa_middle);
				
				// draw alignment and size
				draw_text(hoverMenu_alignmentX,		hoverMenu_alignmentY + 2,	"TYPE   " + sprite_get_alignment_string(hs.currentAlign));
				draw_text(hoverMenu_sizeX,			hoverMenu_sizeY + 3,		"SIZE   " + sprite_get_size_string(hs.currentSize));
				
				draw_set_halign(fa_center);
				
				#region DRAW POWER
				
					// draw indicator plate
					draw_sprite(spr_indicatorPlate, 0, hoverMenu_columnOneX, hoverMenu_rowOneY);
				
					// draw label
					draw_sprite(spr_statIndicator, 4, hoverMenu_columnOneX, hoverMenu_rowOneY);
					
					// check if the stat has been changed at all
					if (hs.currentPower < hs.basePower) draw_set_color(c_red);
					if (hs.currentPower > hs.basePower) draw_set_color(c_green);
					
					// draw stat
					draw_text_pixel_perfect(hoverMenu_columnOneX + 12,		hoverMenu_rowTwoY + 0.5,		string(hs.currentPower), 1, 256);
					
					// reset color to black
					draw_set_color(COL_BLACK);
				
				#endregion
				
				#region DRAW RESISTANCE
				
					// draw indicator plate
					draw_sprite(spr_indicatorPlate, 0, hoverMenu_columnOneX, hoverMenu_rowThreeY);
				
					// draw label
					draw_sprite(spr_statIndicator, 5, hoverMenu_columnOneX, hoverMenu_rowThreeY);
					
					// check if the stat has been changed at all
					if (hs.currentResistance< hs.baseResistance)	draw_set_color(c_red);
					if (hs.currentResistance> hs.baseResistance)	draw_set_color(c_green);
					
					// draw stat
					draw_text_pixel_perfect(hoverMenu_columnOneX + 12,		hoverMenu_rowFourY + 0.5,		string(hs.currentResistance), 1, 256);
					
					// reset color to black
					draw_set_color(COL_BLACK);
				
				#endregion
				
				#region DRAW AGILITY
				
					// draw indicator plate
					draw_sprite(spr_indicatorPlate, 0, hoverMenu_columnTwoX, hoverMenu_rowOneY);
				
					// draw label
					draw_sprite(spr_statIndicator, 6, hoverMenu_columnTwoX, hoverMenu_rowOneY);
					
					// check if the stat has been changed at all
					if (hs.currentAgility < hs.baseAgility)	draw_set_color(c_red);
					if (hs.currentAgility > hs.baseAgility)	draw_set_color(c_green);
					
					// draw stat
					draw_text_pixel_perfect(hoverMenu_columnTwoX + 12,		hoverMenu_rowTwoY + 0.5,		string(hs.currentAgility), 1, 256);
					
					// reset color to black
					draw_set_color(COL_BLACK);

				#endregion
				
				#region DRAW LUCK
				
					// draw indicator plate
					draw_sprite(spr_indicatorPlate, 0, hoverMenu_columnTwoX, hoverMenu_rowThreeY);
				
					// draw label
					draw_sprite(spr_statIndicator, 7, hoverMenu_columnTwoX, hoverMenu_rowThreeY);
					
					// check if the stat has been changed at all
					if (hs.currentLuck < hs.baseLuck)		draw_set_color(c_red);
					if (hs.currentLuck > hs.baseLuck)		draw_set_color(c_green);
					
					// draw stat
					draw_text_pixel_perfect(hoverMenu_columnTwoX + 12,		hoverMenu_rowFourY + 0.5,		string(hs.currentLuck), 1, 256);
					
					// reset color to black
					draw_set_color(COL_BLACK);
				
				#endregion
				
				#region DRAW FIRE
				
					// draw indicator plate
					draw_sprite(spr_indicatorPlate, 0, hoverMenu_columnThreeX, hoverMenu_rowOneY);
				
					// draw label
					draw_sprite(spr_statIndicator, 0, hoverMenu_columnThreeX, hoverMenu_rowOneY);
					
					// check if the stat has been changed at all
					if (hs.currentFire < hs.baseFire)		draw_set_color(c_red);
					if (hs.currentFire > hs.baseFire)		draw_set_color(c_green);
					
					// draw stat
					draw_text_pixel_perfect(hoverMenu_columnThreeX + 12,		hoverMenu_rowTwoY + 0.5,		string(hs.currentFire), 1, 256);
					
					// reset color to black
					draw_set_color(COL_BLACK);
				
				#endregion
				
				#region DRAW WATER
				
					// draw indicator plate
					draw_sprite(spr_indicatorPlate, 0, hoverMenu_columnThreeX, hoverMenu_rowThreeY);
				
					// draw label
					draw_sprite(spr_statIndicator, 1, hoverMenu_columnThreeX, hoverMenu_rowThreeY);
					
					// check if the stat has been changed at all
					if (hs.currentWater < hs.baseWater)		draw_set_color(c_red);
					if (hs.currentWater > hs.baseWater)		draw_set_color(c_green);
					
					// draw stat
					draw_text_pixel_perfect(hoverMenu_columnThreeX + 12,		hoverMenu_rowFourY + 0.5,		string(hs.currentWater), 1, 256);
					
					// reset color to black
					draw_set_color(COL_BLACK);
				
				#endregion
				
				#region DRAW STORM
				
					// draw indicator plate
					draw_sprite(spr_indicatorPlate, 0, hoverMenu_columnFourX, hoverMenu_rowOneY);

					// draw the label
					draw_sprite(spr_statIndicator, 2, hoverMenu_columnFourX, hoverMenu_rowOneY);
					
					// check if the stat has been changed at all
					if (hs.currentStorm < hs.baseStorm)		draw_set_color(c_red);
					if (hs.currentStorm > hs.baseStorm)		draw_set_color(c_green);
					
					// draw stat
					draw_text_pixel_perfect(hoverMenu_columnFourX + 12,		hoverMenu_rowTwoY + 0.5,		string(hs.currentStorm), 1, 256);
					
					// reset the color to black
					draw_set_color(COL_BLACK);
				
				#endregion
				
				#region DRAW EARTH
				
					// draw indicator plate
					draw_sprite(spr_indicatorPlate, 0, hoverMenu_columnFourX, hoverMenu_rowThreeY);
				
					// draw label
					draw_sprite(spr_statIndicator, 3, hoverMenu_columnFourX, hoverMenu_rowThreeY);
					
					// check if the stat has been changed at all
					if (hs.currentEarth < hs.baseEarth)		draw_set_color(c_red);
					if (hs.currentEarth > hs.baseEarth)		draw_set_color(c_green);
					
					// draw stat
					draw_text_pixel_perfect(hoverMenu_columnFourX + 12,		hoverMenu_rowFourY + 0.5,		string(hs.currentEarth), 1, 256);
					
					// reset color to black
					draw_set_color(COL_BLACK);
				
				#endregion
				
				#region DRAW ABILITY INFO
					
					// set draw params
					draw_set(fa_left, fa_top, 1.0, COL_BLACK);

					// draw ability name
					draw_text_pixel_perfect(hoverMenu_abilityNameX, hoverMenu_abilityNameY, hs.currentAbilityName, 1, guiWidth - 6);
					
					// set draw params
					draw_set(fa_center, fa_top, 1.0, COL_BLACK);
					
					// draw ability desc
					draw_text_pixel_perfect(hoverMenu_abilityDescX, hoverMenu_abilityDescY, hs.currentAbilityDesc, 1, guiWidth - 6);
				#endregion
			}
		}
	}
	
	// check that shift is not being pressed
	if !(global.shiftPressed) 
	&& !(onlineWaiting) {
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

#region WAITING FOR OTHER PLAYER

if (onlineWaiting) {
	draw_set_alpha(0.5);
	
	draw_rectangle_color(0, 0, guiWidth, guiHeight, COL_BLACK, COL_BLACK, COL_BLACK, COL_BLACK, false);
	
	draw_set(fa_center, fa_middle, 1.0, COL_WHITE);
	var str = "Waiting for other player";
	
	var modVar = global.gameTime mod 56;
	
	if (modVar < 14)		str += "...";
	else if (modVar < 28)	str += "..";
	else if (modVar < 42)	str += ".";
	
	draw_text_pixel_perfect(guiWidth / 2, guiHeight / 2, str, 1, 256);
}

#endregion

#region WIN LOSE DISPLAY
	if (instance_exists(winLoseDisplay)) {
		draw_set_alpha(0.5);
		draw_rectangle_color(0, 0, guiWidth, guiHeight, c_black, c_black, c_black, c_black, false);
		
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		
		draw_set_alpha(1.0);
		
		draw_text_pixel_perfect(guiWidth / 2, guiHeight / 2, winLoseDisplay.text, 1, 256);
	}
#endregion