/// @description Insert description here
// You can write your code in this editor

// check if count has not yet reached the limit
if (count < string_length(pages[| pageIndex])) {
	if !(global.gameTime mod talkingSpeed) {
		// add the next character to currentText
		currentText = string_copy(pages[| pageIndex], 1, count);
		
		// increment count
		count++;
	}
}

// check if count has reached the end of the page
if count == string_length(pages[| pageIndex]) {
	// check if on last page
	if (pageIndex == ds_list_size(pages) - 1) {
		
		// if there is a yes no prompt
		if (global.ynFunction != -1) {
			instance_create_depth(0, 0, layer_get_depth(LAYER.meta), yesNoPrompt);	
		}
		
		// else if there is not a yes no prompt
		else {
			// check if waiting for player input
			if (waitForInput) {
				if (global.select) {
					instance_destroy(id);	
				}
			}
			// else statement (if skipping input)
			else {
				instance_destroy(id);
			}
		}
	}
	// else statement (if not on last page)
	else {
		// check if waiting for player input
		if (waitForInput) {
			if (global.select) {
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