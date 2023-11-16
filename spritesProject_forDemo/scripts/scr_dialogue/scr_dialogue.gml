/*
	encoding key
	
	^[x,y][x,y]...^		= make speaker walk given path
	*emotion*			= make speaker display given emotion
	_					= insert player name
	|					= next page
	&					= don't wait for player to click enter
*/

function talk_bubble_build_dialogue() {
	var text = _string;
	
	var last_space = 1;
	
	var currentLine = 1;
	var currentPage = 1;
	
	var height = string_height(text);
	var maxLines = (pageHeight div height) - 1;
	
	pages[| currentPage] = "";

	while (string_length(text) > 0) {
		while (currentLine < maxLines) {
			// check if the text signals to start walking a path
			if (string_char_at(text, 1)) == "^" {
				
			}
			
			// check if the text signals to display an emotion
			if (string_char_at(text, 1)) == "*" {
				
			}
			
			// check if the text signals to insert the player's name
			if (string_char_at(text, 1)) == "_" {
				
			}
			
			// check if the text signals to skip to the next page
			if (string_char_at(text, 1)) == "|" {
				
			}
			
			// check if the text signals to move on without player input
			if (string_char_at(text, 1)) == "&" {
				
			}
			
			// check if the next character is a space
			if (string_char_at(text, 1)) == " " {
				
			}
			
			
			if (string_length(text) == 0) currentLine = maxLines;
		}
		// if the currentLine has moved beyond maxLines, move to the next page and start from line 1	
		currentPage++;
		pages[|currentPage] = "";
		currentLine = 1;
	}
	

}