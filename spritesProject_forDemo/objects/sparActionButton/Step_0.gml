/// @description Insert description here
// You can write your code in this editor

// constantly reset selected sprite in case it changes
sprite = player.selectedAlly;

if (instance_exists(sparActionMenu)) {
	// check if mouse is hovering over button
	if (collision_rectangle(bboxLeft, bboxTop, bboxRight, bboxBottom, mouse, false, true)) {
		// set selectedButton and index to match the button being hovered over
		sparActionMenu.selectedButton = id;
		sparActionMenu.index = action;
		
		// if the mouse is clicked, set the action
		if (global.click) {
			spar_set_action();
		}		
	}
}

if (instance_exists(sparActionMenu)) {
	// check if button is selected
	if (sparActionMenu.selectedButton == id) {
		// set frame
		frame = 1;
		textColor = COL_WHITE;
		
		// check if enter is clicked
		if (global.select) {
			spar_set_action();	
		}
	}

	// if button is not selected, reset frame
	else {
		frame = 0;
		textColor = COL_BLACK;
	}
}