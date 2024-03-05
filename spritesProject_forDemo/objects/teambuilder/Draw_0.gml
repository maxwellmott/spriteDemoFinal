// draw background
draw_sprite(spr_teambuilderBackground, 0, 0, 0);

// check if there are more options above the visible options
if (bottomRowNum != 0)	{
	draw_sprite(spr_teambuilderUpSlot, rowOneFrame, nameSlotColumnOne,		nameSlotRowOne);
	draw_sprite(spr_teambuilderUpSlot, rowOneFrame, nameSlotColumnTwo,		nameSlotRowOne);
	draw_sprite(spr_teambuilderUpSlot, rowOneFrame, nameSlotColumnThree,	nameSlotRowOne);
}

// check if there are more options below the visible options
if (topRowNum != columnHeight) {
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
if (optionsChangingUp) 
|| (optionsChangingDown) {
	// set text params
	draw_set(fa_center, fa_middle, 1.0, c_black);
	draw_set_font(plainFont);
	
	// find the first index
	var start = (bottomRowNum * rowWidth) - 1;
	
	// draw names if options are not changing
	var i = 0;	repeat (visibleRowCount * rowWidth) {
		// get index
		var ind = i + start;
		
		// get name
		var name = spriteGrid[# SPRITE_PARAMS.NAME, ind];
		
		// get x and y using a switch statement
		switch (i) {
			case 0:		var nameX = nameSlotColumnOne;		var nameY = nameSlotRowOne;		break;
			case 1:		var nameX = nameSlotColumnTwo;		var nameY = nameSlotRowOne;		break;
			case 2:		var nameX = nameSlotColumnThree;	var nameY = nameSlotRowOne;		break;
			
			case 3:		var nameX = nameSlotColumnOne;		var nameY = nameSlotRowTwo;		break;
			case 4:		var nameX = nameSlotColumnTwo;		var nameY = nameSlotRowTwo;		break;
			case 5:		var nameX = nameSlotColumnThree;	var nameY = nameSlotRowTwo;		break;
			
			case 6:		var nameX = nameSlotColumnOne;		var nameY = nameSlotRowThree;	break;
			case 7:		var nameX = nameSlotColumnTwo;		var nameY = nameSlotRowThree;	break;
			case 8:		var nameX = nameSlotColumnThree;	var nameY = nameSlotRowThree;	break;
		}
		
		// draw name
		spar_draw_text(nameX, nameY, name);
		
		// increment i
		i++;
	}
}

// draw spriteslots

// draw sprites

// draw selector
draw_sprite(spr_teambuilderSelector, selectorFrame, selectorX, selectorY);

// draw inspect menu