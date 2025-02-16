/// @description Insert description here
// You can write your code in this editor

// correct typeLineStartX depending on whether there are any characters
// in the inputString
if (string_length(inputString) > 0) {
	typeLineStartX = 40;	
}	else {
	typeLineStartX = 36;	
}

// use a repeat loop to check for any button collisions
var i = 0;	repeat (charCount + 4) {
	var left	= keyLeftList[| i];
	var right	= keyRightList[| i];
	var top		= keyTopList[| i];
	var bottom	= keyBottomList[| i];
	
	// check for a collision between the mouse and the current key
	if (collision_rectangle(left, top, right, bottom, mouse, false, false)) {
		// set selectedKey
		selectedKey = i;
		
		// check for mouse click
		if (global.click) {
			alarm[0] = 16;
			pressedKey = i;
			
			keyboard_press_key(selectedKey);
		}
	}
	
	i++;
}

// use arrow keys to change selectedKey
if (global.menuRight) {
	if (selectedKey < charCount + 3) {
		selectedKey++;	
	}
}

if (global.menuLeft) {
	if (selectedKey > 0) {
		selectedKey--;	
	}
}

if (global.menuDown) {
	if (selectedKey div columnCount < 3) {
		selectedKey += columnCount;	
	}
	else {
		if (selectedKey <= charCount) {
			selectedKey = charCount + 1;	
		}
	}
}

if (global.menuUp) {
	if (selectedKey div columnCount > 0) {
		selectedKey -= columnCount;	
	}
	else {
		selectedKey = charCount + 1;	
	}
}

// check for select click
if (global.select) {
	keyboard_press_key(selectedKey);	
}

// check for start click
if (global.start) {
	if (selectedKey != charCount + 3) {
		selectedKey = charCount + 3;	
	}
	else {
		keyboard_press_key(charCount + 3);
	}
}