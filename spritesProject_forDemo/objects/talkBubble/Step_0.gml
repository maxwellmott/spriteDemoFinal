/// @description Insert description here
// You can write your code in this editor


// check if count has reached the end of the page
if count == string_length(pages[| currentPage]) {
	// check if on last page
	if (pageIndex == ds_list_size(pages) - 1) {
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
	// else statement (if not on last page)
	else {
		// check if waiting for player input
		if (waitForInput) {
			if (global.select) {
				pageIndex++;	
			}
		}
		// else statement (if skipping input)
		else {
			pageIndex++;	
		}
	}
}