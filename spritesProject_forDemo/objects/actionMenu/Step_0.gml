// check if intro is finished AND outro has started
if (introFinished)
&& (outroStarted) {
	// check if image index is on the final frame
	if (image_index >= image_number - 1) {
		// destroy this instance
		instance_destroy(id);
	}
}

// check if intro is finished AND outro has NOT started
if (introFinished)
&& !(outroStarted) {
	// set image index to the final frame (display the actual menu)
	image_index = image_number - 1;
	
	// check for select input
	if (global.select) {
		// set image index to 0 to start outro animation
		image_index = 0;
		
		// start the outro
		outroStarted = true;
	}	
	
	// check for right directional input
	if (global.menuRight) {
		// check if the selectedButton is higher than 0
		if (selectedButton < ACTION_MENU_OPTIONS.HEIGHT - 1) {
			selectedButton++;	
		}
	}
	
	// check for left directional input
	if (global.menuLeft) {
		// check if the selectedButton is lower than the highest emote
		if (selectedButton > 0) {
			selectedButton--;	
		}
	}
	
	// check for up directional input
	if (global.menuUp) {
		// check if the selectedButton is on the top row
		if (selectedButton div 2 > 0) {
			selectedButton -= 2;	
		}
	}
	
	// check for down directional input
	if (global.menuDown) {
		// check if the selectedButton is on the bottom row
		if (selectedButton div 2 < (ACTION_MENU_OPTIONS.HEIGHT div 2) - 1) 
		|| (selectedButton == ACTION_MENU_OPTIONS.HEIGHT - 3) {
			selectedButton += 2;	
		}
	}
	
	// check if back button is being pressed
	if (global.back) {
		selectedButton = -1;
		
		// set image index to 0 to start outro animation
		image_index = 0;
		
		// set outro started to true
		outroStarted = true;
	}
	
	// use a repeat loop to check for any button collisions
	var i = 0;	repeat (ACTION_MENU_OPTIONS.HEIGHT) {
		// get all bbox vars
		var left	= leftList[| i];
		var right	= rightList[| i];
		var top		= topList[| i];
		var bottom	= bottomList[| i];
		
		// check if the mouse is colliding with this button
		if (collision_rectangle(left, top, right, bottom, mouse, false, false)) {
			// set this button to selectedButton
			selectedButton = i;
			
			// check if the mouse is being clicked
			if (global.click) {				
				// set image index to 0 to start outro animation
				image_index = 0;
				
				// start the outro
				outroStarted = true;
			}
		}
		
		// increment i
		i++;
	}
}

// check if intro is not finished
if !(introFinished) {
	// check if image index is on the final frame
	if (image_index >= image_number - 1) {
		// set intro finished to true
		introFinished = true;	
	}
}