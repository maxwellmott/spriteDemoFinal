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
	
	// check if back button is being pressed
	if (global.back) {
		// set image index to 0 to start outro animation
		image_index = 0;
		
		// set outro started to true
		outroStarted = true;	
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