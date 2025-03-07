
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

// set all draw vals
draw_set(fa_center, fa_middle, 1.0, COL_BLACK);

// set font
draw_set_font(plainFont);

// draw outfit name
draw_text_pixel_perfect(nameDrawX, outfitNameY, outfitNameList[| outfit], 9, 256);

// draw hairstyle name
draw_text_pixel_perfect(nameDrawX, hairstyleNameY, hairstyleNameList[| hairstyle], 9, 256);

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
		// check the frames for timing
		if (global.gameTime mod 24 > 12) {
			// draw the selection indicator
			draw_sprite(spr_ccSelectionIndicator, 0, nameDrawX, outfitNameY - 3);	
		}
	break;
	
	case CHARACTER_CREATOR_PHASES.OUTFIT_COLOR_SELECTION:
		// get the position of the selected outfit color on the colorList
		var colorNum = ds_list_find_index(colorList, outfitColor);
		
		// get the position of the colorNum on the usableDyes list
		var index = ds_list_find_index(usableDyes, colorNum);
		
		// get the left and top of the current outfit color splotch
		var left	= outfitColorLefts[| index];
		var top		= outfitColorTops[| index];
		
		// draw the dye selector at this position
		draw_sprite(spr_dyeSelector, 0, left, top);
	break;
	
	case CHARACTER_CREATOR_PHASES.HAIRSTYLE_SELECTION:
		// check the frames for timing
		if (global.gameTime mod 24 > 12) {
			// draw the selection indicator
			draw_sprite(spr_ccSelectionIndicator, 0, nameDrawX, hairstyleNameY - 3);
		}
	break;
	
	case CHARACTER_CREATOR_PHASES.HAIR_COLOR_SELECTION: 	
		// get the position of the selected hair color on the colorList
		var colorNum = ds_list_find_index(colorList, hairColor);
		
		// get the position of the colorNum on the usableHairColors list
		var index = ds_list_find_index(usableHairColors, colorNum);
		
		// get the left and top of the current hair color splotch
		var left	= hairColorLefts[| index];
		var top		= hairColorTops[| index];
		
		// draw the dye selector at this position
		draw_sprite(spr_dyeSelector, 0, left, top);
	break;
}

// check if the confirm window is present
if (phase >= CHARACTER_CREATOR_PHASES.CONFIRM_WINDOW_ENTER) {
	// check that we are not exiting
	if (phase < CHARACTER_CREATOR_PHASES.CONFIRM_WINDOW_EXIT) {		
		// set alpha for dark rectangle
		draw_set_alpha((image_index / confirmWindowMaxFrame) * 0.85);
		
		// draw a rectangle over everything else
		draw_rectangle_color(0, 0, guiWidth, guiHeight, c_black, c_black, c_black, c_black, false);
		
		// reset alpha
		draw_set_alpha(1.0);
		
		// draw the confirm window
		draw_self();
	}
	// if we ARE exiting
	else {
		// set alpha for dark rectangle
		draw_set_alpha(((confirmWindowMaxFrame - image_index) / confirmWindowMaxFrame) * 0.85);
		
		// draw a rectangle over everything else
		draw_rectangle_color(0, 0, guiWidth, guiHeight, c_black, c_black, c_black, c_black, false);
		
		// reset alpha
		draw_set_alpha(1.0);
		
		// draw the confirm window in reverse
		draw_sprite(sprite_index, confirmWindowMaxFrame - image_index, x, y);
	}
}

// check if the confirm window is set
if (phase == CHARACTER_CREATOR_PHASES.CONFIRM_SELECTION) {
	// draw the yes no button
	draw_sprite(spr_ccYesNo, ynSelection, yesButtonLeft, yesButtonTop);
}

// draw the sample player
character_creator_draw_player(skintone, outfit, outfitColor, hairstyle, hairColor, hat, hatColor, shoes, shoeColor, accessory);