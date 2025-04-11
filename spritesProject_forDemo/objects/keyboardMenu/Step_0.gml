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
		// check for mouse click
		if (global.click) {
			// push click haptic
			audio_push_sfx(sfx_click);
			
			alarm[0] = 16;
			pressedKey = i;
			
			keyboard_press_key(pressedKey);
		}
	}
	
	i++;
}

// check that pnoun menu is not up
if (pnMenuEntering + pnMenuExiting + pnMenuPresent == 0) {
	// use arrow keys to change selectedKey
	if (global.menuRight) {
		// push click haptic
		audio_push_sfx(sfx_click);
		
		if (selectedKey < charCount + 3) {
			selectedKey++;	
		}
	}
	
	if (global.menuLeft) {
		// push click haptic
		audio_push_sfx(sfx_click);
		
		if (selectedKey > 0) {
			selectedKey--;	
		}
	}
	
	if (global.menuDown) {
		// push click haptic
		audio_push_sfx(sfx_click);
		
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
		// push click haptic
		audio_push_sfx(sfx_click);
		
		if (selectedKey div columnCount > 0) {
			selectedKey -= columnCount;	
		}
		else {
			selectedKey = charCount + 1;	
		}
	}
	
	// check for select click
	if (global.select) {
		// push click haptic
		audio_push_sfx(sfx_click);
		
		keyboard_press_key(selectedKey);	
	}
	
	// check for back click
	if (global.back) {
		// push failure haptic
		audio_push_failure_haptic();
		
		inputString = string_delete(inputString, string_length(inputString), 1);
	}
	
	// check for start click
	if (global.start) {
		// push success haptic
		audio_push_success_haptic();
		
		if (selectedKey != charCount + 3) {
			selectedKey = charCount + 3;	
		}
		else {
			keyboard_press_key(charCount + 3);
		}
	}
}

// check if the pronoun menu is entering
if (pnMenuEntering) {
	if (image_index >= pronounWindowMaxFrame) {
		pnMenuPresent = true;
		pnMenuEntering = false;
	}
}

// check if the pronoun menu is present
if (pnMenuPresent) {
	// clamp image index
	image_index = pronounWindowMaxFrame;
	
	// check for a click
	if (global.click) {
		// check for a collision with the she button
		if (collision_rectangle(sheButtonLeft, sheButtonTop, sheButtonRight, sheButtonBottom, mouse, true, false)) {
			// push success haptic
			audio_push_success_haptic();

			// set selectedPronouns
			selectedPronouns = genders.female;
			
			// accept name and pronouns
			keyboard_accept_name_and_pronouns();
		}
		
		// check for a collision with the they button
		if (collision_rectangle(theyButtonLeft, theyButtonTop, theyButtonRight, theyButtonBottom, mouse, true, false)) {
			// push success haptic
			audio_push_success_haptic();
			
			// set selectedPronouns
			selectedPronouns = genders.nonbinary;
			
			// accept name and pronouns
			keyboard_accept_name_and_pronouns();
		}
		
		// check for a collision with the he button
		if (collision_rectangle(heButtonLeft, heButtonTop, heButtonRight, heButtonBottom, mouse, true, false)) {
			// push success haptic
			audio_push_success_haptic();
			
			// set selectedPronouns
			selectedPronouns = genders.male;
			
			// accept name and pronouns
			keyboard_accept_name_and_pronouns();
		}
	}
	
	// check for back input
	if (global.back) {
		// push failure haptic
		audio_push_failure_haptic();
		
		// set image index back to 0
		image_index = 0;
		
		// set pnMenu to exit
		pnMenuExiting = true;
		pnMenuPresent = false;
	}
	
	// navigate index based on player input
	if (global.menuLeft) {
		// push click haptic
		audio_push_sfx(sfx_click);
		
		selectedPronouns--;
		
		// clamp selectedPronouns
		selectedPronouns = clamp(selectedPronouns, 0, genders.height - 1);
	}
	
	if (global.menuRight) {
		// push click haptic
		audio_push_sfx(sfx_click);
		
		selectedPronouns++;	
		
		// clamp selectedPronouns
		selectedPronouns = clamp(selectedPronouns, 0, genders.height - 1);
	}
	
	// check if select is being pressed
	if (global.select) {
		// push success haptic
		audio_push_success_haptic();
		
		// accept name and pronouns
		keyboard_accept_name_and_pronouns();
	}
}

// check if the pronoun menu is exiting
if (pnMenuExiting) {
	// check if	image_index has reached the end
	if (image_index >= pronounWindowMaxFrame) {
		// set all pnMenu bools to false
		pnMenuEntering = false;
		pnMenuExiting = false;
		pnMenuPresent = false;
	}
}