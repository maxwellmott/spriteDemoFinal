///@desc

function encode_list(_list) {
	// it checks the list for commas to determine if it is a structList
	var i = 0; var commaCount = 0;
	repeat (ds_list_size(_list)) {
		commaCount += string_scan(string(_list[|i]), ",");
		i++;
	}
	
	// it then sets the parse character depending on whether it is a structList
	if (commaCount > 0) {var parseChar = ";";}
	else	{var parseChar = ",";}
	
	// it creates an empty string for the return variable
	var substring = "";
	
	// initializes i
	var i = 0;
	
	// it repeats the copying process for every item in the list
	repeat (ds_list_size(_list)) {
		// it copies the list item to the return string
		substring += string(_list[|i]);
		
		// then it adds the parse character
		substring += parseChar;
		
		// increment i
		i++;
	}
	
	// return the substring
	return substring;
}

function encode_grid(_grid) {	 
	// set the parseChar depending on whether there were commas present
	
	var newRowChar		= "|";
	var newColumnChar	= "_";
	
	// repeat for all columns
	var i = 0;	var substring	= "";
	repeat (ds_grid_height(_grid)) {
		var ii = 0;
		// repeat for all rows
		repeat (ds_grid_width(_grid)) {
			// add the grid token at i, ii to the return string
			substring += string(_grid[# ii, i]);
			
			// add the parse character to the string
			substring += newColumnChar;
			
			// increment ii
			ii++;
		}
		// add the secondary parse character 
		substring += newRowChar;
		
		// increment i
		i++;
	}
	
	return substring;
}

function encode_map(_map) {
	var m = _map;
	
	// establish parse characters
	var tokenKeyChar	= "|";
	var newItemChar		= "_";
	
	// initialize substring
	var substring	= "";
	
	// find first key in ds_map and its respective token
	var firstKey	= ds_map_find_first(m);
	var firstToken	= ds_map_find_value(m, firstKey);
	
	// add key, tokenKeyChar, token, and newItemChar to substring
	substring += firstKey;
	substring += tokenKeyChar;
	substring += firstToken;
	substring += newItemChar;
	
	// set first key as the first key to use to find the next
	var key = firstKey;
	
	// use a repeat loop to find each key coming after the first
	repeat (ds_map_size(m) - 1) {
		// get next key and token
		var key		= ds_map_find_next(m, key);
		var token	= ds_map_find_value(m, key);
		
		// add key, tokenKeyChar, token, and newItemChar to substring
		substring += key;
		substring += tokenKeyChar;
		substring += token;
		substring += newItemChar;
	}
	
	// return substring
	return substring;
}

function decode_list(_list, _target) {
	// ensure that the list is a string
	var list = string(_list);
	
	// check for structs
	var hasStructs = string_scan(list, ";");

	// set parse character
	if (hasStructs) {var parseChar = ";";}
	else	{var parseChar = ",";}

	// count list tokens
	var listSize = string_count(parseChar, list);
	
	// copy the list to an empty string
	var substring = list;

	// repeat for every token in the list
	var i = 0;
	repeat (listSize) {
	// find the first token in the string
		var position = string_pos(parseChar, substring);
		var token = string_copy(substring, 1, position - 1);

		// put the token on the list
		_target[|i] = token;

		// delete the token from the string
		var temp = string_delete(substring, 1, position);
		substring = temp;
		
		// increment i
		i++;
	}
}

function decode_grid(_grid, _target) {
	
	var newRowChar		= "|";
	var newColumnChar	= "_";
	
	// count grid rows and columns
	var rowCount	= string_count(newRowChar,		_grid);
	var columnCount = string_count(newColumnChar,	_grid) / rowCount;
	
	// ensure that the target grid is the proper size
	ds_grid_resize(_target, columnCount, rowCount);
	
	// store the encoded grid in a substring
	var substring = _grid;
	
	// repeat for every column
	var i = 0;	
	repeat (rowCount) {
		var ii = 0;
		// repeat for every row
		repeat (columnCount) {
			// find the first token in the row
			var position = string_pos(newColumnChar, substring);
			var token = string_copy(substring, 1, position - 1);
			
			// put the token on the target grid
			_target[# ii, i] = token;
			
			// delete the token from the string
			var temp = string_delete(substring, 1, position);
			substring = temp;
			
			// delete the secondary parse character for this row
			var position = string_pos(newRowChar, substring);
			var temp = string_delete(substring, position, 1);
			substring = temp;
			
			// increment ii
			ii++;
		}
		// increment i
		i++;
	}
}

function decode_map(_map, _target) {
	var m = _map;	var t = _target;
	
	// establish tokenKeyChar and newItemChar
	var tokenKeyChar	= "|";
	var newItemChar		= "_";
	
	// get size of map by counting newItemChars
	var mapSize = string_count(newItemChar, m);
	
	// initialize substring
	var substring = m;
	
	// use a repeat loop to get each token and key from the encoded map
	repeat (mapSize) {
		// get position of first tokenKeyChar and use it to find the next key
		var tokenKeyPos	= string_pos(tokenKeyChar, substring);
		var key			= string_copy(substring, 1, tokenKeyPos - 1);
		
		// get position of first newItemChar, then find the length of the next token
		// and use both values to find the next token 
		var newItemPos	= string_pos(newItemChar, substring);
		var tokenLength	= newItemPos - tokenKeyPos - 1;
		var token		= string_copy(substring, tokenKeyPos + 1, tokenLength);
		
		// add key and token to target map
		ds_map_add(t, key, token);
		
		var temp = string_delete(substring, 1, newItemPos);
		substring = temp;
	}
}

function draw_structs(_list) {
	// use a repeat to do the draw method for each struct
	var i = 0;
	repeat(ds_list_size(_list)) {
		var struct = _list[|i];						// get struct from list
		struct.method_draw();						// execute draw method
		i++;										// increment i
	}
}

function construct_scenery(_list, _target) {
	// decode the overworld object list
	var str		= _list;
	var list	= ds_list_create();
	var target	= _target;
	
	decode_list(str, list);

	// use the dummy list to create each struct (use a repeat here)
	var i = 0; 
	repeat (ds_list_size(list)) {
		var structParams = ds_list_create();
		decode_list(list[|i], structParams);
		
		var struct = new scenery(structParams[|0], structParams[|1], structParams[|2], structParams[|3]);
		target[|i] = struct;
		
		ds_list_destroy(structParams);
		i++;
	}

	// delete the list
	ds_list_destroy(list);
}

function struct_step(_list) {
	// use a repeat to do the draw method for each struct
	var i = 0;
	repeat (ds_list_size(_list)) {
		var struct = _list[| i];					// get struct from list
		struct.method_step();						// execute step method
		i++;										// increment i
	}
}