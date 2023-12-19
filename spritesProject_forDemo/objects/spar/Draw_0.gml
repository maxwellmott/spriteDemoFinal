/// @description Insert description here
// You can write your code in this editor

draw_set_font(sparFont);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_black);

// draw background
draw_sprite(spr_sparBackground, 0, 0, 0);

// draw spell backdrop

// draw arena if there is one

#region ALLIES AND ENEMIES
var i = 0; repeat (8) {
	// get sprite instance ID
	var inst = spriteList[| i];
	
	// set alpha
	draw_set_alpha(inst.alpha);
	
	// draw ally spot
	draw_sprite(spr_sparAllySpot, 0, inst.x, inst.y);
	
	// check if inst is an enemy or an ally
	if (i < 4) {
		// draw sprite
		draw_sprite(inst.sprite, 0, inst.x, inst.y);
	}
	else {
		draw_sprite_ext(inst.sprite, 0, inst.x, inst.y, -1, 1, 0, c_white, 1.0);	
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
		
		draw_sprite(spr_readyDisplayBox, 0, inst.x, inst.y);
		draw_text_transformed(inst.x - 27, inst.y - 25, inst.readyDisplay, 0.5, 0.5, 0);
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
				draw_text_transformed(selectionMsgX, selectionMsgY, selectionMsg, 0.5, 0.5, 0);
			}
		}
		
		// if there is an action button, draw all the buttons
		if (instance_exists(sparActionButton)) {
			var count = instance_number(sparActionButton);
			
			var i = 0;	repeat (count) {
				var inst = sparActionMenu.actionButtons[| i];
				
				draw_sprite(spr_sparActionButton, inst.frame, inst.x, inst.y);
				draw_set_color(inst.textColor);
				
				draw_text_transformed(inst.x, inst.y, inst.name, 0.5, 0.5, 0);
				
				i++;
			}
			
			draw_set_color(c_black);
		}
	}
#endregion

#region SPELL MENU
	// check that spellMenu exists
	if (instance_exists(sparSpellMenu)) {
		
		// draw spellBook
		draw_sprite(sparSpellMenu.sprite, sparSpellMenu.frame, sparSpellMenu.x, sparSpellMenu.y);
	
		// check if pageFlip is happening
		if (sparSpellMenu.drawFlip) {
			draw_sprite(spr_spellBookPageFlip, sparSpellMenu.flipFrame, sparSpellMenu.x, sparSpellMenu.y);	
		}
	}
#endregion

#region USER INTERFACE
	// draw nameplates
	draw_sprite(spr_sparPlayerNameplate, 0, guiWidth, guiHeight);
	draw_sprite(spr_sparEnemyNameplate, 0, 0, 0);
	
	// draw titles and names
	
	// draw HPMP symbols
	draw_sprite(spr_sparHPMP, 0, 120, guiHeight - 8);
	draw_sprite(spr_sparHPMP, 0, 135, 8);
	
	// draw health and magic bars
	
	// draw hindrance indicators
	if (playerOne.miasma)	draw_sprite(spr_sparMiasma, 0,	playerOne.miasmaX,	playerOne.miasmaY);
	if (playerOne.hum)		draw_sprite(spr_sparHum,	0,	playerOne.humX,		playerOne.humY);
	if (playerOne.rust)		draw_sprite(spr_sparRust,	0,	playerOne.rustX,	playerOne.rustY);
	
	if (playerTwo.miasma)	draw_sprite(spr_sparMiasma,	0,	playerTwo.miasmaX,	playerTwo.miasmaY);
	if (playerTwo.hum)		draw_sprite(spr_sparHum,	0,	playerTwo.humX,		playerTwo.humY);
	if (playerTwo.rust)		draw_sprite(spr_sparRust,	0,	playerTwo.rustX,	playerTwo.rustY);

#endregion

#region HOVER MENU
	if (sparPhase == sparPhases.select)
	&& (selectionPhase != selectionPhases.action) {
		if (global.hoverSprite != -1) {
			if (global.shift) {
				draw_set_font(sparFont);
				draw_set_halign(fa_center);
				draw_set_valign(fa_bottom);
				draw_set_color(c_white);
				
				var hs = global.hoverSprite;
				
				// draw message sprite
				draw_sprite(spr_sparMessage, 0, turnMsgX, turnMsgY);
				
				// draw hoverMenu sprite
				draw_sprite(spr_sparHoverMenuNameplate, 0, hoverMenu_nameplateX, hoverMenu_nameplateY);
				
				// draw name
				draw_text_transformed(hoverMenu_nameplateX,		hoverMenu_nameplateY,	hs.name, 0.5, 0.5, 0);
				
				draw_set_color(c_black);
				
				draw_set_halign(fa_left);
				
				// draw alignment and size
				draw_text_transformed(hoverMenu_alignmentX,	hoverMenu_alignmentY,	"SIZE: " + sprite_get_alignment_string(hs.currentAlign),	0.5, 0.5, 0);
				draw_text_transformed(hoverMenu_sizeX,		hoverMenu_sizeY,		"TYPE: " + sprite_get_size_string(hs.currentSize),			0.5, 0.5, 0);
				
				draw_set_halign(fa_center);
				
				// draw power
				if (hs.currentPower < hs.basePower) draw_set_color(c_red);
				if (hs.currentPower > hs.basePower) draw_set_color(c_green);
				
				draw_text_transformed(hoverMenu_columnOneX,			hoverMenu_rowOneY,		"POWER",					0.5, 0.5, 0);
				draw_text_transformed(hoverMenu_columnOneX,			hoverMenu_rowTwoY,		string(hs.currentPower),	0.5, 0.5, 0);
				
				draw_set_color(c_black);
				
				// draw resistance			
				if (hs.currentResist < hs.baseResist)	draw_set_color(c_red);
				if (hs.currentResist > hs.baseResist)	draw_set_color(c_green);
				
				draw_text_transformed(hoverMenu_columnOneX,			hoverMenu_rowThreeY,	"RESIST",					0.5, 0.5, 0);
				draw_text_transformed(hoverMenu_columnOneX,			hoverMenu_rowFourY,		string(hs.currentResist),	0.5, 0.5, 0);
				
				draw_set_color(c_black);
				
				// draw agility
				if (hs.currentAgility < hs.baseAgility)	draw_set_color(c_red);
				if (hs.currentAgility > hs.baseAgility)	draw_set_color(c_green);
				
				draw_text_transformed(hoverMenu_columnTwoX,			hoverMenu_rowOneY,		"AGILITY",					0.5, 0.5, 0);
				draw_text_transformed(hoverMenu_columnTwoX,			hoverMenu_rowTwoY,		string(hs.currentAgility),	0.5, 0.5, 0);
				
				draw_set_color(c_black);
				
				// draw luck	
				if (hs.currentLuck < hs.baseLuck)		draw_set_color(c_red);
				if (hs.currentLuck > hs.baseLuck)		draw_set_color(c_green);
				
				draw_text_transformed(hoverMenu_columnTwoX,			hoverMenu_rowThreeY,	"LUCK",						0.5, 0.5, 0);
				draw_text_transformed(hoverMenu_columnTwoX,			hoverMenu_rowFourY,		string(hs.currentLuck),		0.5, 0.5, 0);
				
				draw_set_color(c_black);
				
				// draw fire	
				if (hs.currentFire < hs.baseFire)		draw_set_color(c_red);
				if (hs.currentFire > hs.baseFire)		draw_set_color(c_green);
				
				draw_text_transformed(hoverMenu_columnThreeX,		hoverMenu_rowOneY,		"FIRE",						0.5, 0.5, 0);
				draw_text_transformed(hoverMenu_columnThreeX,		hoverMenu_rowTwoY,		string(hs.currentFire),		0.5, 0.5, 0);
				
				draw_set_color(c_black);
				
				// draw water		
				if (hs.currentWater < hs.baseWater)		draw_set_color(c_red);
				if (hs.currentWater > hs.baseWater)		draw_set_color(c_green);
				
				draw_text_transformed(hoverMenu_columnThreeX,		hoverMenu_rowThreeY,	"WATER",					0.5, 0.5, 0);
				draw_text_transformed(hoverMenu_columnThreeX,		hoverMenu_rowFourY,		string(hs.currentWater),	0.5, 0.5, 0);
				
				draw_set_color(c_black);
				
				// draw storm	
				if (hs.currentStorm < hs.baseStorm)		draw_set_color(c_red);
				if (hs.currentStorm > hs.baseStorm)		draw_set_color(c_green);
				
				draw_text_transformed(hoverMenu_columnFourX,		hoverMenu_rowOneY,		"STORM",					0.5, 0.5, 0);
				draw_text_transformed(hoverMenu_columnFourX,		hoverMenu_rowTwoY,		string(hs.currentStorm),	0.5, 0.5, 0);
				
				draw_set_color(c_black);
				
				// draw earth																							
				if (hs.currentEarth < hs.baseEarth)		draw_set_color(c_red);
				if (hs.currentStorm > hs.baseStorm)		draw_set_color(c_green);
				
				draw_text_transformed(hoverMenu_columnFourX,		hoverMenu_rowThreeY,	"EARTH",					0.5, 0.5, 0);
				draw_text_transformed(hoverMenu_columnFourX,		hoverMenu_rowFourY,		string(hs.currentEarth),	0.5, 0.5, 0);
				
				draw_set_color(c_black);
			}
		}
	}
	
	// check that shift is not being pressed
	if !(global.shift) {
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

// draw spell FX