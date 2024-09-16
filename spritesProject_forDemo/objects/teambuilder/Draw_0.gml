// find the first index
var start = (bottomRowNum * rowWidth);

// draw background
draw_sprite(spr_teambuilderBackground, 0, 0, 0);

// check if there are more options above the visible options
if (bottomRowNum != 0)	{
	draw_sprite(spr_teambuilderUpSlot, rowOneFrame, nameSlotColumnOne,		nameSlotRowOne);
	draw_sprite(spr_teambuilderUpSlot, rowOneFrame, nameSlotColumnTwo,		nameSlotRowOne);
}

// check if there are more options below the visible options
if (bottomRowNum + 2 < rosterHeight) {
	draw_sprite(spr_teambuilderDownSlot, rowSixFrame, nameSlotColumnOne,	nameSlotRowSix);
	draw_sprite(spr_teambuilderDownSlot, rowSixFrame, nameSlotColumnTwo,	nameSlotRowSix);
}

// draw nameslots
draw_sprite(spr_teambuilderNameSlot,	rowTwoFrame,	nameSlotColumnOne,		nameSlotRowTwo);
draw_sprite(spr_teambuilderNameSlot,	rowTwoFrame,	nameSlotColumnTwo,		nameSlotRowTwo);

draw_sprite(spr_teambuilderNameSlot,	rowThreeFrame,	nameSlotColumnOne,		nameSlotRowThree);
draw_sprite(spr_teambuilderNameSlot,	rowThreeFrame,	nameSlotColumnTwo,		nameSlotRowThree);

draw_sprite(spr_teambuilderNameSlot,	rowFourFrame,	nameSlotColumnOne,		nameSlotRowFour);
draw_sprite(spr_teambuilderNameSlot,	rowFourFrame,	nameSlotColumnTwo,		nameSlotRowFour);

draw_sprite(spr_teambuilderNameSlot,	rowFiveFrame,	nameSlotColumnOne,		nameSlotRowFive);
draw_sprite(spr_teambuilderNameSlot,	rowFiveFrame,	nameSlotColumnTwo,		nameSlotRowFive);

// check if changing at all
if !(optionsChangingUp) 
&& !(optionsChangingDown) {
	// set text params
	draw_set(fa_center, fa_middle, 1.0, COL_BLACK);
	draw_set_font(plainFont);
	
	// draw names if options are not changing
	var i = 0;	repeat (visibleRowCount * rowWidth) {
		// get index relative to the 9 visible names
		var ind = i + start;
		
		if (ind >= 0) 
		&& (ind < rosterHeight) {
		
			// use index to get spriteID
			var sid = talismanList[| ind];
		
			// use spriteID to get name
			var name = spriteGrid[# SPRITE_PARAMS.NAME, sid];
		
			// get x and y using a switch statement
			switch (i) {
				case 0:		var nameX = nameSlotColumnOne;		var nameY = nameSlotRowTwo;		break;
				case 1:		var nameX = nameSlotColumnTwo;		var nameY = nameSlotRowTwo;		break;
			
				case 2:		var nameX = nameSlotColumnOne;		var nameY = nameSlotRowThree;	break;
				case 3:		var nameX = nameSlotColumnTwo;		var nameY = nameSlotRowThree;	break;
			
				case 4:		var nameX = nameSlotColumnOne;		var nameY = nameSlotRowFour;	break;
				case 5:		var nameX = nameSlotColumnTwo;		var nameY = nameSlotRowFour;	break;
				
				case 6:		var nameX = nameSlotColumnOne;		var nameY = nameSlotRowFive;	break;
				case 7:		var nameX = nameSlotColumnTwo;		var nameY = nameSlotRowFive;	break;
			}
		
			// draw name
			if (ds_list_find_index(teamList, talismanList[| ind]) == -1)	draw_text_pixel_perfect(nameX, nameY + 3, name, 1, 256);
			else															draw_sprite(spr_teambuilderSelectedSlot, 0, nameX, nameY);
		
		
		
			// increment i
			i++;
		}
	}
	
	// draw selector
	draw_sprite(spr_teambuilderSelector, image_index, selectorX, selectorY);
}

var i = 0;	repeat (4) {
	
	switch (i) {
		case 0:
			var _x = spriteSlotOneX;
		break;
		
		case 1:
			var _x = spriteSlotTwoX;
		break;
		
		case 2:
			var _x = spriteSlotThreeX;
		break;
		
		case 3:
			var _x = spriteSlotFourX;
		break;
	}
	
	var _y = spriteSlotY;

	// check if selected
	if (selectedSpriteSlot == i) {		
		// draw spriteslot
		draw_sprite(spr_teambuilderSpriteSlot, 1, _x, _y);
		
		// set draw params
		draw_set(fa_center, fa_middle, 1.0, COL_WHITE);
		
		if (recentSelection) {
			// get the ID of the newly selected sprite
			var spriteID = teamList[| i];
			
			// get the name of the newly selected sprite
			var n = spriteGrid[# SPRITE_PARAMS.NAME, spriteID];
			
			// draw name of newly selected sprite
			draw_text_pixel_perfect(_x, _y + 3, n, 1, 256);
		}	else	{
			// draw "SELECTING"
			if (global.gameTime mod 24 < 12) {
				draw_text_pixel_perfect(_x + 2, _y + 3, "SELECTING", 1, 256);
			}
		}
	}
	// else
	else {
		// get spriteID
		var spriteID = teamList[| i];
			
		// draw spriteSlot
		draw_sprite(spr_teambuilderSpriteSlot, 0, _x, _y);
		
		// set alignment
		draw_set(fa_center, fa_middle, 1.0, COL_WHITE);
		
		// check if there is a sprite
		if (spriteID >= 0) {
			// get sprite
			var n = spriteGrid[# SPRITE_PARAMS.NAME, spriteID];
			
			// set alignment
			draw_set(fa_center, fa_middle, 1.0, COL_BLACK);
			
			// draw name
			draw_text_pixel_perfect(_x, _y + 3, n, 1, 256);
		}
	}
	
	// increment i
	i++;
}

// set draw params
draw_set(fa_center, fa_middle, 1.0, COL_BLACK);

if (currentSprite != "-4") {

	// draw all current params, starting with sprite
	draw_sprite(currentSprite, 0, currentSpriteX, currentSpriteY);
	
	// draw all stats
	// power
	draw_sprite(spr_statIndicator, 4, statColumnOne + 9, statRowOne - 3);
	draw_text_pixel_perfect(statColumnOne + 23, statRowOne + 5, currentPower, 1, 256);
	
	// resistance
	draw_sprite(spr_statIndicator, 5, statColumnTwo + 9, statRowOne - 3);
	draw_text_pixel_perfect(statColumnTwo + 23, statRowOne + 5, currentResistance, 1, 256);
	
	// fire
	draw_sprite(spr_statIndicator, 0, statColumnOne + 9, statRowTwo - 3);
	draw_text_pixel_perfect(statColumnOne + 23, statRowTwo + 5, currentFire, 1, 256);
	
	// water
	draw_sprite(spr_statIndicator, 1, statColumnTwo + 9, statRowTwo - 3);
	draw_text_pixel_perfect(statColumnTwo + 23, statRowTwo + 5, currentWater, 1, 256);
	
	// storm
	draw_sprite(spr_statIndicator, 2, statColumnOne + 9, statRowThree - 3);
	draw_text_pixel_perfect(statColumnOne + 23, statRowThree + 5, currentStorm, 1, 256);
	
	// earth
	draw_sprite(spr_statIndicator, 3, statColumnTwo + 9, statRowThree - 3);
	draw_text_pixel_perfect(statColumnTwo + 23, statRowThree + 5, currentEarth, 1, 256);
	
	// agility
	draw_sprite(spr_statIndicator, 6, statColumnOne + 9, statRowFour - 3);
	draw_text_pixel_perfect(statColumnOne + 23, statRowFour + 5, currentAgility, 1, 256);
	
	// luck
	draw_sprite(spr_statIndicator, 7, statColumnTwo + 9, statRowFour - 3);
	draw_text_pixel_perfect(statColumnTwo + 23, statRowFour + 5, currentLuck, 1, 256);
	
	// draw ability info
	draw_set(fa_center, fa_middle, 1.0, COL_BLACK);
	draw_text_pixel_perfect(abilityNameX, abilityNameY, currentAbilityName, 1, 256);
	draw_text_pixel_perfect(abilityDescX, abilityDescY, currentAbilityDesc, 8, abilityDescWidth);
}

// draw stat coverage and spell usage score marks
draw_sprite(spr_scoreMarks, statCoverageScore,	statCoverageX,	statCoverageY);
draw_sprite(spr_scoreMarks, spellUsageScore,	spellUsageX,	spellUsageY);

if (onlineWaiting) {
	draw_set_alpha(0.5);
	
	draw_rectangle_color(0, 0, guiWidth, guiHeight, COL_BLACK, COL_BLACK, COL_BLACK, COL_BLACK, false);
	
	draw_set(fa_center, fa_middle, 1.0, COL_WHITE);
	var str = "Waiting for other player";
	
	var modVar = global.gameTime mod 56;
	
	if (modVar < 14)	str += ".";
	if (modVar < 28)	str += "..";
	if (modVar < 42)	str += "...";
	
	draw_text_pixel_perfect(guiWidth / 2, guiHeight / 2, str, 1, 256);
}
else {
	if (global.gameTime mod 80 < 40) {
		draw_set(fa_center, fa_middle, 1.0, COL_BLACK);
	
		draw_text_pixel_perfect(msgX, msgY, msg, 1, 256);
	}
}