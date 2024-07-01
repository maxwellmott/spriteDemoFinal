// find the first index
var start = (bottomRowNum * rowWidth);

// draw background
draw_sprite(spr_teambuilderBackground, 0, 0, 0);

// check if there are more options above the visible options
if (bottomRowNum != 0)	{
	draw_sprite(spr_teambuilderUpSlot, rowOneFrame, nameSlotColumnOne,		nameSlotRowOne);
	draw_sprite(spr_teambuilderUpSlot, rowOneFrame, nameSlotColumnTwo,		nameSlotRowOne);
	draw_sprite(spr_teambuilderUpSlot, rowOneFrame, nameSlotColumnThree,	nameSlotRowOne);
}

// check if there are more options below the visible options
if (bottomRowNum + 2 < columnHeight) {
	draw_sprite(spr_teambuilderDownSlot, rowFiveFrame, nameSlotColumnOne,	nameSlotRowFive);
	draw_sprite(spr_teambuilderDownSlot, rowFiveFrame, nameSlotColumnTwo,	nameSlotRowFive);
	draw_sprite(spr_teambuilderDownSlot, rowFiveFrame, nameSlotColumnThree,	nameSlotRowFive);
}

// draw nameslots
draw_sprite(spr_teambuilderNameSlot,	rowTwoFrame,	nameSlotColumnOne,		nameSlotRowTwo);
draw_sprite(spr_teambuilderNameSlot,	rowTwoFrame,	nameSlotColumnTwo,		nameSlotRowTwo);
draw_sprite(spr_teambuilderNameSlot,	rowTwoFrame,	nameSlotColumnThree,	nameSlotRowTwo);

draw_sprite(spr_teambuilderNameSlot,	rowThreeFrame,	nameSlotColumnOne,		nameSlotRowThree);
draw_sprite(spr_teambuilderNameSlot,	rowThreeFrame,	nameSlotColumnTwo,		nameSlotRowThree);
draw_sprite(spr_teambuilderNameSlot,	rowThreeFrame,	nameSlotColumnThree,	nameSlotRowThree);

draw_sprite(spr_teambuilderNameSlot,	rowFourFrame,	nameSlotColumnOne,		nameSlotRowFour);
draw_sprite(spr_teambuilderNameSlot,	rowFourFrame,	nameSlotColumnTwo,		nameSlotRowFour);
draw_sprite(spr_teambuilderNameSlot,	rowFourFrame,	nameSlotColumnThree,	nameSlotRowFour);

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
				case 2:		var nameX = nameSlotColumnThree;	var nameY = nameSlotRowTwo;		break;
			
				case 3:		var nameX = nameSlotColumnOne;		var nameY = nameSlotRowThree;	break;
				case 4:		var nameX = nameSlotColumnTwo;		var nameY = nameSlotRowThree;	break;
				case 5:		var nameX = nameSlotColumnThree;	var nameY = nameSlotRowThree;	break;
			
				case 6:		var nameX = nameSlotColumnOne;		var nameY = nameSlotRowFour;	break;
				case 7:		var nameX = nameSlotColumnTwo;		var nameY = nameSlotRowFour;	break;
				case 8:		var nameX = nameSlotColumnThree;	var nameY = nameSlotRowFour;	break;
			}
		
			// draw name
			if (ds_list_find_index(teamList, talismanList[| ind]) == -1)	draw_text_pixel_perfect(nameX, nameY, name, 1);
			else															draw_sprite(spr_teambuilderSelectedSlot, 0, nameX, nameY);
		
		
		
			// increment i
			i++;
		}
	}
	
	// draw selector
	if (global.gameTime mod 32 <= 15) 
	|| (selectorFrame == 1) {
		draw_sprite(spr_teambuilderSelector, selectorFrame, selectorX - selectorBufferWidth, selectorY);
	}
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
		
		// draw poof sprite
		draw_sprite(spr_sparSwapCloud, image_index, _x, _y)
	}
	// else
	else {
		// get spriteID
		var spriteID = teamList[| i];
			
		// draw spriteSlot
		draw_sprite(spr_teambuilderSpriteSlot, 0, _x, _y);
		
		// check if there is a sprite
		if (spriteID >= 0) {
			// get sprite
			var ss = spriteGrid[# SPRITE_PARAMS.SPRITE, spriteID];
			
			// draw sprite
			draw_sprite(ss, 0, _x, _y);
		}
	}
	
	// increment i
	i++;
}

// check if team is complete and there is not a selected spriteSlot
if (ds_list_size(teamList) == 4)
&& (selectedSpriteSlot == -1) {
	if (global.gameTime mod 64 <= 31)
	|| (global.start) {
		draw_set_font(blockFont);
		
		draw_set(fa_center, fa_middle, 1.0, COL_BLACK);

		draw_sprite(spr_teambuilderStringBackdrop, 0, acceptStringX, acceptStringY);
		draw_text_pixel_perfect(acceptStringX + 1, acceptStringY + 5, acceptString, 1);
		
		draw_set_font(plainFont);
	}
}

// draw inspect menu


if (onlineWaiting) {
	draw_set_alpha(0.5);
	
	draw_rectangle_color(0, 0, guiWidth, guiHeight, COL_BLACK, COL_BLACK, COL_BLACK, COL_BLACK, false);
	
	draw_set_alpha(1.0);
}