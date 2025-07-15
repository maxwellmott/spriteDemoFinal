// check if count has not yet reached the limit
if (count < string_length(pages[| pageIndex])) {
	if !(global.gameTime mod talkingSpeed) {
		// add the next character to currentText
		currentText = string_copy(pages[| pageIndex], 1, count);
		
		// increment count
		count++;
		
		if !(global.gameTime mod (talkingSpeed * 4)) {
			audio_push_sfx(voice);	
		}
	}
	
	// check for player input
	if (global.select)
	|| (global.back)
	|| (global.start) {
		currentText = pages[| pageIndex];
		count = string_length(pages[| pageIndex]);
		
		global.select = 0;
		global.back = 0;
		global.start = 0;
	}
}

// check if count has reached the end of the page
if count == string_length(pages[| pageIndex]) {
	// check if on last page
	if (pageIndex == ds_list_size(pages) - 1) {
		// check if waiting for player input
		if (waitForInput) {
			if (global.select) 
			|| (global.back) 
			|| (global.start) {
				instance_destroy(id);
			}
		}
		// else statement (if skipping input)
		else {
			instance_destroy(id);
		}
	}
	// else statement (if not on last page)
	else {
		// check if waiting for player input
		if (waitForInput) {
			if (global.select) 
			|| (global.back) 
			|| (global.start) {
				pageIndex++;	
				count = 1;
			}
		}
		// else statement (if skipping input)
		else {
			pageIndex++;
			count = 1;
		}
	}
}