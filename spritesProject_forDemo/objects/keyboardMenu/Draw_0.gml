/// @description Insert description here
// You can write your code in this editor

// draw background
draw_sprite(spr_keyboardBackground, 0, 0, 0);

draw_set_font(keyboardFont);

// draw all keys
var i = 0;	repeat (charCount + 4) {
	// initialize drawX and drawY
	var drawX = -1;
	var drawY = -1;
	
	// initialize colNum and rowNum
	var colNum = -1;
	var rowNum = -1;
	
	// initialize keyChar
	var keyChar = "";
	
	// initialize drawFrame and drawColor
	var drawFrame = 0;
	var drawColor = COL_BLACK;
	
	// check if this is one of the normal keys
	if (i < charCount) {
		// use mod to set colNum
		colNum = i mod columnCount;
		
		// use div to set rowNum
		rowNum = i div columnCount;
		
		// use a switch statement to set drawX
		switch (colNum) {
			case 0:		drawX = keyColOneX;		break;
			case 1:		drawX = keyColTwoX;		break;
			case 2:		drawX = keyColThreeX;	break;
			case 3:		drawX = keyColFourX;	break;
			case 4:		drawX = keyColFiveX;	break;
			case 5:		drawX = keyColSixX;		break;
			case 6:		drawX = keyColSevenX;	break;
			case 7:		drawX = keyColEightX;	break;
			case 8:		drawX = keyColNineX;	break;
			case 9:		drawX = keyColTenX;		break;
		}
		
		// use a switch statement to set drawY
		switch (rowNum) {
			case 0:		drawY = keyRowOneY;		break;
			case 1:		drawY = keyRowTwoY;		break;
			case 2:		drawY = keyRowThreeY;	break;
			case 3:		drawY = keyRowFourY;	break;
		}
		
		// get the character to draw over the key
		if (shiftSet)	keyChar = shiftList[| i];
		if !(shiftSet)	keyChar = charList[| i];
	}
	// if this is not one of the normal keys
	else {
		// set drawX and drawY for shift key
		if (i == charCount) {
			drawX = shiftKeyX;
			drawY = shiftKeyY;
		}
		
		// set drawX and drawY for delete key
		if (i == charCount + 1) {
			drawX = deleteKeyX;
			drawY = deleteKeyY;
		}
		
		// set drawX and drawY for clear key
		if (i == charCount + 2) {
			drawX = clearKeyX;
			drawY = clearKeyY;
		}
		
		// set drawX and drawY for accept key
		if (i == charCount + 3) {
			drawX = acceptKeyX;
			drawY = acceptKeyY;
		}
	}
	
	// check if this is the selected key
	if (selectedKey == i) {
		// check if key is being pressed 
		if (pressedKey == i) {
			// set frame
			drawFrame = 1;
			
			// set color
			drawColor = c_white;
		}
		
		// check if it is time to draw the selector
		if (global.gameTime mod 32 < 16) {
			var left = keyLeftList[| i];
			var right = keyRightList[| i];
			var top = keyTopList[| i];
			var bottom = keyBottomList[| i];
			
			var sx = drawX - round((right - left) / 2) - 2;
			var sy = drawY - round((bottom - top) / 2) - 2;
			
			// draw the selector
			draw_sprite_stretched(spr_selectorBox, 0, sx, sy, (right - left) + 4, (bottom - top) + 4);	
		}
		
	}
	
	// set draw params
	draw_set(fa_center, fa_middle, 1.0, drawColor);
	
	// check if this is a normal key
	if (i < charCount) {
		// draw key sprite
		draw_sprite(spr_keyboardKey, drawFrame, drawX, drawY);
	}
	// if this is not a normal key
	else {
		// initialize button sprite
		var btnSprite = -1;
		
		// check if this is the shift key
		if (i == charCount) {
			// set the button sprite for the shift key
			btnSprite = spr_keyboardMenuShiftKey;
			
			// get the character to draw over the key
			if (shiftSet)	keyChar = shiftList[| i];
			if !(shiftSet)	keyChar = charList[| i];
			
		}
		// if this is not the shift key
		else {
			// set the button sprite for non shift key button
			btnSprite = spr_keyboardMenuButton;
			
			// set keyChar for delete button
			if (i == charCount + 1)		keyChar = "Delete";
			
			// set keyChar for clear button
			if (i == charCount + 2)		keyChar = "Clear";
			
			// set keyChar for accept button
			if (i == charCount + 3)		keyChar = "Accept";
		}
		
		// draw button sprite
		draw_sprite(btnSprite, drawFrame, drawX, drawY);
	}
	
	if (pressedKey != i) {
		// draw keyChar
		draw_text_pixel_perfect(drawX + 1, drawY - 6, keyChar, 1, 256);
	}
	
	// increment i
	i++;
}

// draw type line
if (global.gameTime mod 64 < 32) {
	draw_sprite(spr_keyboardMenuTypeLine, 0, typeLineStartX + string_width(inputString), typeLineStartY);
}

// set draw params
draw_set(fa_left, fa_middle, 1.0, COL_BLACK);

draw_text_pixel_perfect(inputStringX, inputStringY - 5, inputString, 1, 256);

// check if the confirm window is present
if (pnMenuEntering + pnMenuExiting + pnMenuPresent > 0) {
	// check that we are not exiting
	if !(pnMenuExiting) {
		// set alpha for dark rectangle
		draw_set_alpha((image_index / pronounWindowMaxFrame) * 0.85);
		
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
		draw_set_alpha(((pronounWindowMaxFrame - image_index) / pronounWindowMaxFrame) * 0.85);
		
		// draw a rectangle over everything else
		draw_rectangle_color(0, 0, guiWidth, guiHeight, c_black, c_black, c_black, c_black, false);
		
		// reset alpha
		draw_set_alpha(1.0);
		
		// draw the confirm window in reverse
		draw_sprite(sprite_index, pronounWindowMaxFrame - image_index, x, y);
	}
}

// check if the confirm window is set
if (pnMenuPresent) {
	// draw the yes no button
	draw_sprite(spr_pronounSelectionButtons, selectedPronouns, sheButtonLeft, sheButtonTop);
}