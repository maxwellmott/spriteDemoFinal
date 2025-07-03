//@TODO DEBUG
// check if there are active dialogue emotes
var egh = ds_grid_height(emoGrid);

if (egh > 0) {
	// create removal list
	var rl = ds_list_create();
	
	var i = 0;	repeat (egh) {
		// if this emote does not indicate to wait for a position in the text
		if (emoGrid[# i, 2] == 0) {
			// get the height of the active emote grid
			var oegh = ds_grid_height(overworld.activeEmotes);
			
			// add 1 to the height of the grid
			ds_grid_resize(overworld.activeEmotes, 2, oegh + 1);
			
			// add the emote ID
			ds_grid_add(overworld.activeEmotes, 0, oegh, emoGrid[# 3, i]);
			
			// add the instance ID of the emoter
			ds_grid_add(overworld.activeEmotes, 1, oegh, speaker);
			
			// add this row to the removal list
			ds_list_add(rl, i);
		}
		// if this emote indicates to wait for a position in the text
		else {
			// check if page index matches the given page
			if (pageIndex == emoGrid[# 0, i]) {
				// check if the length of the currentText is greater than or equal to the given text length
				if (string_length(currentText) >= emoGrid[# 1, i]) {
					// get the height of the active emote grid
					var oegh = ds_grid_height(overworld.activeEmotes);
					
					// add 1 to the height of the grid
					ds_grid_resize(overworld.activeEmotes, 2, oegh + 1);
					
					// add the emote ID
					ds_grid_add(overworld.activeEmotes, 1, oegh, emoGrid[# 3, 1]);
					
					// add the instance ID of the emoter
					ds_grid_add(overworld.activeEmotes, 1, oegh, speaker);
					
					// add this row to the removal list
					ds_list_add(rl, i);
				}
			}
		}
		
		i++;
	}
	
	if (ds_list_size(rl) > 0) {
		var i = ds_list_size(rl);	repeat (ds_list_size(rl)) {
			ds_grid_remove_row(emoGrid, rl[| i]);
			
			i--;
		}
	}
}

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