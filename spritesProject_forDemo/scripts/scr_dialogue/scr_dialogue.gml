/*
	encoding key
	
	^[x,y][x,y]...^		= make speaker walk given path
	*emotion*			= make speaker display given emotion
	_					= insert player name
	|					= next page
	&					= don't wait for player to click enter
*/

function talk_bubble_build_dialogue() {
	var initialLength = string_length(text);
	var currentLength = string_length(text);
	
	var last_space = 1;
	
	var currentLine = 1;
	var currentPage = 1;
	
	var height = string_height(text);
	var maxLines = (pageHeight div height) - 1;
	
	pages[| currentPage] = "";

	while (string_length(text) > 0) {
		while (currentLine < maxLines) {
			// check if the text signals to start walking a path
			if (string_char_at(text, 1)) == "^" {										//READY TO TEST
				// delete the opening signal character
				text = string_delete(text, 1, 1);
				
				// get the number containing the truth value of whether dialogue
				// should continue while the path is being walked
				var boolString	= string_copy(text, 1, 1);
				var pathBool	= real(boolString);
				
				// remove the number
				text = string_delete(text, 1, 1);
				
				// find the position of the first bracket
				var startPos = string_pos("[", text);				
				
				// find the next signal character to get the size of the coordString
				var endPos = string_pos("^", text) -1;				
				
				// store the whole group of coordinate pairs in a substring
				var coordString = string_copy(text, 1, endPos);
				
				// get the number of coordinate pairs
				var coordCount = string_count("[", coordString);
				
				// create a list to store the coordinate pairs
				var coordList = ds_list_create();
				
				// use a repeat loop to get each pair of coordinates
				// and store them in an encoded list
				var i = 0; repeat(coordCount) {
					var openingPos = string_pos("[", coordString);
					var closingPos = string_pos("]", coordString);
					
					var coords = string_copy(coordString, 1, closingPos);
					
					coordList[| i] = coords;
					
					coordString = string_delete(coordString, openingPos, closingPos);
				}
				
				// delete the coordString from the text
				text = string_delete(text, 1, endPos);
				
				// resize the pathGrid
				ds_grid_resize(pathGrid, 3, pathCount + 1);
				
				// add currentLength to pathGrid
				pathGrid[# 0, pathCount] = currentLength;
				
				// add pathBool to pathGrid
				pathGrid[# 1, pathCount] = pathBool;
				
				// add the encoded coordString to the pathGrid
				pathGrid[# 2, pathCount] = encode_list(coordList);
				
				// increment pathCount
				pathCount++;
				
				// correct currentLength
				currentLength = string_length(text);
				
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
			
			// check if the text signals to change the talkingSpeed
			if (string_char_at(text, 1)) == "$" {
				
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