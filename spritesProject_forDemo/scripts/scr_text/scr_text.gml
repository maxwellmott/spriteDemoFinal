///@desc This function was initially made to be called anytime that text needed
/// to be formatted to a textbox. I didn't end up expanding this function or
/// using it for dialogue or literature, but it's still a helpful function if
/// some text needs to be displayed within a confined space! 
///
/// HOWEVER: this is currently set up only for undercase letters in plainFont.
/// to make this function more dynamic, you'll need to find a way to get the
/// approximate size of a letter in the font you'll be using and store that in
/// fontLetterWidth.
function format_text(_string, _width, _fontSize, _scale) {	
	var fs = _fontSize;

	var str		= _string;
	var width	= _width;
	var scale	= _scale;
	
	var currentLine = "";
	var substring = "";
	var nextSpace = 0;
	var nextWord = "";
	
	var testString = "";
	var testWidth = 0;
	
	var spaceCount = string_count(" ", str);
	
	repeat (spaceCount) {
		// get the position of the next space
		nextSpace = string_pos(" ", str);
		
		// copy the next word
		nextWord = string_copy(str, 1, nextSpace - 1);
		
		// get the prospective width of the substring
		testString = currentLine + nextWord;
		testWidth = string_length(testString) * fs;
		
		// check if it's greater than the width of the textbox
		if (testWidth > width) {
			// if so, add a new line and the nextWord
			substring += currentLine;
			substring += "\n";
			currentLine = nextWord;
			currentLine += " ";
		}
		else {
			// else, add the nextWord
			currentLine += nextWord;
			currentLine += " ";
		}
		
		// delete the nextWord from the original string
		str = string_delete(str, 1, nextSpace);
	}
	
	// copy currentLine to substring since that might not have happened
	substring += currentLine;
	
	// there should still be one word left, so we'll
	// find it and copy it here
	var l = string_length(str);
	
	if (l > 0) {
		testString = currentLine + str;
		testWidth = string_length(testString) * fs;
		
		if (testWidth > width) {
			substring += "\n";
		}
		
		substring += str;	
	}
	
	return substring;
}

///@desc This function takes a string and the address of a variable within which
/// to store a substring. It then takes each character from the string one-by-one
/// and copies them to the substring. This is called in the step event of different
/// objects to create a rolling-text effect.
function increment_text(_source, _target) {
	var source	= _source;
	var target	= _target;
	
	target += string_char_at(source, string_length(target) + 1);
	
	return target;
}