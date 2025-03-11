/// @description Insert description here
// You can write your code in this editor

// draw background
draw_sprite(spr_appearanceEditorBackground, 0, 0, 0);

// use a repeat loop to draw all skintone splotches
var i = 0;	repeat (ds_list_size(usableDyes)) {
	// get left and top positions
	var left			= dyeLefts[| i];
	var outfitTop		= outfitColorTops[| i];
	var hatTop			= hatColorTops[| i];
	var shoeTop			= shoeColorTops[| i];
	
	// draw all splotches with a color blend
	draw_sprite_ext(spr_dyeSplotch, 0, left, outfitTop,	1, 1, 0, colorList[| usableDyes[| i]], 1.0);
	draw_sprite_ext(spr_dyeSplotch, 0, left, hatTop,	1, 1, 0, colorList[| usableDyes[| i]], 1.0);
	draw_sprite_ext(spr_dyeSplotch, 0, left, shoeTop,	1, 1, 0, colorList[| usableDyes[| i]], 1.0);
	
	// increment i
	i++;
}

// initialize left and top positions
var left	= -1;
var top		= -1;

// draw both outfit arrows
i = 0;	repeat (2) {
	// initialize a variable to store the appropriate frame
	var f = 0;
	
	// check if this is the currentHairstyleArrow
	if (i == currentOutfitArrow) {
		f = 1;	
	}
	
	// check if this is the left arrow
	if (i == 0) {
		// get left and top positions
		left	= leftArrowLeft;
		top		= outfitArrowTop;
		
		// draw the arrow with the appropriate frame
		draw_sprite(spr_appearanceEditorLeftArrow, f, left, top);
	}
	
	// check if this is the right arrow
	if (i == 1) {
		// get left and top positions
		left	= rightArrowLeft;
		top		= outfitArrowTop;
		
		// draw the arrow with the appropriate frame	
		draw_sprite(spr_appearanceEditorRightArrow, f, left, top);
	}
	// increment i
	i++;
}

// draw both hat arrows
i = 0;	repeat (2) {
	// initialize a variable to store the appropriate frame
	var f = 0;
	
	// check if this is the currentHairstyleArrow
	if (i == currentHatArrow) {
		f = 1;	
	}
	
	// check if this is the left arrow
	if (i == 0) {
		// get left and top positions
		left	= leftArrowLeft;
		top		= hatArrowTop;
		
		// draw the arrow with the appropriate frame
		draw_sprite(spr_appearanceEditorLeftArrow, f, left, top);
	}
	
	// check if this is the right arrow
	if (i == 1) {
		// get left and top positions
		left	= rightArrowLeft;
		top		= hatArrowTop;
		
		// draw the arrow with the appropriate frame	
		draw_sprite(spr_appearanceEditorRightArrow, f, left, top);
	}
	// increment i
	i++;
}

// draw both shoe arrows
i = 0;	repeat (2) {
	// initialize a variable to store the appropriate frame
	var f = 0;
	
	// check if this is the currentHairstyleArrow
	if (i == currentShoeArrow) {
		f = 1;	
	}
	
	// check if this is the left arrow
	if (i == 0) {
		// get left and top positions
		left	= leftArrowLeft;
		top		= shoeArrowTop;
		
		// draw the arrow with the appropriate frame
		draw_sprite(spr_appearanceEditorLeftArrow, f, left, top);
	}
	
	// check if this is the right arrow
	if (i == 1) {
		// get left and top positions
		left	= rightArrowLeft;
		top		= shoeArrowTop;
		
		// draw the arrow with the appropriate frame	
		draw_sprite(spr_appearanceEditorRightArrow, f, left, top);
	}
	// increment i
	i++;
}

// draw both eyewear arrows
i = 0;	repeat (2) {
	// initialize a variable to store the appropriate frame
	var f = 0;
	
	// check if this is the currentHairstyleArrow
	if (i == currentEyewearArrow) {
		f = 1;	
	}
	
	// check if this is the left arrow
	if (i == 0) {
		// get left and top positions
		left	= leftArrowLeft;
		top		= eyewearArrowTop;
		
		// draw the arrow with the appropriate frame
		draw_sprite(spr_appearanceEditorLeftArrow, f, left, top);
	}
	
	// check if this is the right arrow
	if (i == 1) {
		// get left and top positions
		left	= rightArrowLeft;
		top		= eyewearArrowTop;
		
		// draw the arrow with the appropriate frame	
		draw_sprite(spr_appearanceEditorRightArrow, f, left, top);
	}
	// increment i
	i++;
}

// draw both accessory arrows
i = 0;	repeat (2) {
	// initialize a variable to store the appropriate frame
	var f = 0;
	
	// check if this is the currentHairstyleArrow
	if (i == currentAccessoryArrow) {
		f = 1;	
	}
	
	// check if this is the left arrow
	if (i == 0) {
		// get left and top positions
		left	= leftArrowLeft;
		top		= accessoryArrowTop;
		
		// draw the arrow with the appropriate frame
		draw_sprite(spr_appearanceEditorLeftArrow, f, left, top);
	}
	
	// check if this is the right arrow
	if (i == 1) {
		// get left and top positions
		left	= rightArrowLeft;
		top		= accessoryArrowTop;
		
		// draw the arrow with the appropriate frame	
		draw_sprite(spr_appearanceEditorRightArrow, f, left, top);
	}
	// increment i
	i++;
}

// set all draw vals
draw_set(fa_center, fa_middle, 1.0, COL_BLACK);

// set font
draw_set_font(plainFont);

// draw outfit name
draw_text_pixel_perfect(nameDrawX, outfitNameY,		outfitNameList[| outfit],		9, 256);

// draw hat name
draw_text_pixel_perfect(nameDrawX, hatNameY,		hatNameList[| hat],				9, 256);

// draw shoe name
draw_text_pixel_perfect(nameDrawX, shoeNameY,		shoesNameList[| shoes],			9, 119);

// draw eyewear name
draw_text_pixel_perfect(nameDrawX, eyewearNameY,	eyewearNameList[| eyewear],		9, 119); 

// draw accessory name
draw_text_pixel_perfect(nameDrawX, accessoryNameY,	accessoryNameList[| accessory],	9, 119);

// use a switch statement to check each possible phase to draw the appropriate selector
switch (phase) {	
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
		left	= dyeLefts[| index];
		top		= outfitColorTops[| index];
		
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
character_creator_draw_player(eyewear, skintone, outfit, outfitColor, hairstyle, hairColor, hat, hatColor, shoes, shoeColor, accessory);