//@TODO rewrite this function so that it breaks the text into pages
//depending on string_height
function format_text(_string, _width) {
	var _length		= string_length(_string);
	var last_space	= 1;
	
	var count		= 1;
	var substring	= "";
	repeat(_length) {
		substring = string_copy(_string, 1, count);
		if (string_char_at(_string, count) == " ") {last_space = count;}
		
		if (string_width(substring) > _width) {
			_string = string_delete(_string, last_space, 1);
			_string = string_insert("\n", _string, last_space);	
		}
		
		count++;
	}
	
	return substring;
}

// this function takes a list of pages of strings and displays 
// eventually add a _sound argument
function increment_text(_source, _target) {
	var source	= _source;
	var target	= _target;
	
	target += string_char_at(source, string_length(target) + 1);
	
	return target;
}