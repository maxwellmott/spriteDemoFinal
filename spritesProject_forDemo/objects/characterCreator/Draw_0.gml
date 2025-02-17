
// draw background
draw_sprite(spr_characterCreatorBackground, 0, 0, 0);

// use a repeat loop to draw all skintone splotches
var i = 0;	repeat (ds_list_size(skintones)) {
	// get left and top positions
	var left	= skintoneLefts[| i];
	var top		= skintoneTops[| i];
	
	// draw the skintone splotch with a color blend
	draw_sprite_ext(spr_skintoneSplotch, 0, left, top, 1, 1, 0, colorList[| skintones[| i]], 1.0);
	
	// increment i
	i++;
}

// use a repeat loop to draw all outfit color splotches
var i = 0;	repeat (ds_list_size(usableDyes)) {
	// get left and top positions
	var left	= outfitColorLefts[| i];
	var top		= outfitColorTops[| i];
	
	// draw the dye splotch with a color blend
	draw_sprite_ext(spr_dyeSplotch, 0, left, top, 1, 1, 0, colorList[| usableDyes[| i]], 1.0);
	
	// increment i
	i++;
}

// use a repeat loop to draw all hair color splotches
var i = 0;	repeat (ds_list_size(usableHairColors)) {
	// get left and top positions
	var left	= hairColorLefts[| i];
	var top		= hairColorTops[| i];
	
	// draw the dye splotch with a color blend
	draw_sprite_ext(spr_dyeSplotch, 0, left, top, 1, 1, 0, colorList[| usableHairColors[| i]], 1.0);
	
	// increment i
	i++;
}

// draw both outfit arrows
var i = 0;	repeat (2) {
	// get left and top positions
	var left	= outfitArrowLefts[| i];
	var top		= outfitArrowTops[| i];
	
	// initialize a variable to store the appropriate frame
	var f = 0;
	
	// check if this is the currentOutfitArrow
	if (i == currentOutfitArrow) {
		f = 1;	
	}
	
	// check if this is the left arrow
	if (i == 0) {
		// draw the arrow with the appropriate frame
		draw_sprite(spr_ccLeftArrow, f, left, top);
	}
	
	// check if this is the right arrow
	if (i == 1) {
		// draw the arrow with the appropriate frame	
		draw_sprite(spr_ccRightArrow, f, left, top);
	}
	// increment i
	i++;
}

// draw both hairstyle arrows
var i = 0;	repeat (2) {
	// get left and top positions
	var left	= hairArrowLefts[| i];
	var top		= hairArrowTops[| i];
	
	// initialize a variable to store the appropriate frame
	var f = 0;
	
	// check if this is the currentHairstyleArrow
	if (i == currentHairstyleArrow) {
		f = 1;	
	}
	
	// check if this is the left arrow
	if (i == 0) {
		// draw the arrow with the appropriate frame
		draw_sprite(spr_ccLeftArrow, f, left, top);
	}
	
	// check if this is the right arrow
	if (i == 1) {
		// draw the arrow with the appropriate frame	
		draw_sprite(spr_ccRightArrow, f, left, top);
	}
	// increment i
	i++;
}

// draw outfit name

// draw hairstyle name

// use a switch statement to check each possible phase to draw the appropriate selector
switch (phase) {
	case CHARACTER_CREATOR_PHASES.SKINTONE_SELECTION:
		// get the position of the selected skintone on the colorList
		var colorNum = ds_list_find_index(colorList, skintone);
		
		// get the position of the colorNum on the skintone list
		var index = ds_list_find_index(skintones, colorNum);
	
		// get the left and top of the current skintone splotch
		var left	= skintoneLefts[| index];
		var top		= skintoneTops[| index];
		
		// draw the skintone selector at this position
		draw_sprite(spr_skintoneSelector, 0, left, top);
		
	break;
	
	case CHARACTER_CREATOR_PHASES.OUTFIT_SELECTION:
	break;
	
	case CHARACTER_CREATOR_PHASES.OUTFIT_COLOR_SELECTION:
	break;
	
	case CHARACTER_CREATOR_PHASES.HAIRSTYLE_SELECTION:
	break;
	
	case CHARACTER_CREATOR_PHASES.HAIR_COLOR_SELECTION: 	
	break;
}

character_creator_draw_player(skintone, outfit, outfitColor, hairstyle, hairColor, hat, hatColor, shoes, shoeColor, accessory, accessoryColor);