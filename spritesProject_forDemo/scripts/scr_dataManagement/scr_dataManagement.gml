///@desc This function takes a ds_list and loops through it,
/// converting it into a string with some parse character separating
/// each item from the list
function encode_list(_list) {
	// store the list in a local variable
	var list = _list;
	
	// it checks the list for commas to determine if it is a structList
	var i = 0; var hasStructs = false;
	repeat (ds_list_size(_list)) {
		// get the current list item
		var token = list[| i];
		
		// check for commas
		var cc = string_count(",", string(token));
		
		// if there were commas, change hasStructs to true and break the loop
		if (cc > 0) {
			hasStructs = true;
			break;
		}
		
		i++;
	}
	
	// it then sets the parse character depending on whether it is a structList
	if (hasStructs) {var parseChar = ";";}
	else	{var parseChar = ",";}
	
	// it creates an empty string for the return variable
	var substring = "";
	
	// initializes i
	var i = 0;
	
	// it repeats the copying process for every item in the list
	repeat (ds_list_size(list)) {
		// it copies the list item to the return string
		substring += string(list[|i]);
		
		// then it adds the parse character
		substring += parseChar;
		
		// increment i
		i++;
	}
	
	// return the substring
	return substring;
}

///@desc This function takes a ds_grid and loops through it,
/// converting it into a string with two parse characters to
/// indicate the end of each entry or each row of entries
function encode_grid(_grid) {	 
	var g = _grid;
	
	// set navigation characters
	var rowStartChar	= "(";
	var rowEndChar		= ")";

	var colStartChar	= "[";
	var colEndChar		= "]";
	
	var gridStartChar	= "{";
	var gridEndChar		= "}";
	
	var rowCount = ds_grid_height(g);
	var colCount = ds_grid_width(g);

	// repeat for all columns
	var i = 0;	var substring	= gridStartChar;
	repeat (rowCount) {
		var ii = 0;
		substring += rowStartChar;
		
		// repeat for all rows
		repeat (ds_grid_width(_grid)) {
			if (g[# ii, i] != -1) {
				substring += colStartChar;
				
				// add the grid token at i, ii to the return string
				substring += string(_grid[# ii, i]);
			
				// add the parse character to the string
				substring += colEndChar;
			}
			
			// increment ii
			ii++;
		}
		// add the secondary parse character 
		substring += rowEndChar;
		
		// increment i
		i++;
	}
	
	substring += gridEndChar;
	
	return substring;
}

///@desc This function takes a ds_map and checks each key:value pair,
/// adding them each to a string in such a way that each pair and item are
/// separated by two respective parse characters
function encode_map(_map) {
	var substring = "";
	
	var m = _map;
	
	// establish parse characters
	var tokenKeyChar	= "@";
	var newItemChar		= "#";
	
	// find first key in ds_map and its respective token
	var firstKey	= ds_map_find_first(m);
	var firstToken	= ds_map_find_value(m, firstKey);
	
	// add key, tokenKeyChar, token, and newItemChar to substring
	substring = string_insert(firstKey,		substring, string_length(substring) + 1);
	substring = string_insert(tokenKeyChar,	substring, string_length(substring) + 1);
	substring = string_insert(firstToken,	substring, string_length(substring) + 1);
	substring = string_insert(newItemChar,	substring, string_length(substring) + 1);
	
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

///@desc This function takes an encoded list and turns it back into a ds_list
/// so that it's easier to access quickly
function decode_list(_list, _target) {
	// ensure that the list is a string
	var list = string(_list);
	
	// check for structs
	var hasStructs = false;
	
	if (string_count(";", list) > 0)	hasStructs = true;

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

///@desc This function takes an encoded grid and turns it back into a ds_grid
/// so that it's easier to access quickly
function decode_grid(_grid, _target) {
	// store args in locals
	var g = _grid;
	
	// initialize the first spot on the target grid
	_target[# 0, 0] = "";
	
	// set navigation characters
	var rowStartChar	= "(";
	var rowEndChar		= ")";

	var colStartChar	= "[";
	var colEndChar		= "]";
	
	var gridStartChar	= "{";
	var gridEndChar		= "}";
	
	var gridLength	= string_length(g);
	
	var currentRow	= -1;
	var currentCol	= -1;
	
	var nextRowStart	= -1;
	var nextRowEnd		= -1;
	
	var nextColStart	= -1;
	var nextColEnd		= -1;
	
	var nextGridStart	= -1;
	var nextGridEnd		= -1;
	
	var nextChar		= "";
	
	var nestedGridCount = 0;
	
	var substring = "";
	
	// delete the opening curly brace
	g = string_delete(g, 1, 1);
	
	// search through the encoded grid and add data row by row
	var i = 0;	while (i < gridLength) {
		nextChar = string_char_at(g, 1);
		
		// if this is the beginning of a new row
		if (nextChar == rowStartChar) {
			// increment currentRow
			currentRow++;
			
			// check that the target grid can support this height
			if (ds_grid_height(_target) < currentRow + 1) {
				ds_grid_resize(_target, ds_grid_width(_target), currentRow + 1);	
			}
			
			// reset currentCol
			currentCol = -1;
			
			// initialize the first column on the new row
			_target[# 0, currentRow] = "";
			
			// remove this character
			g = string_delete(g, 1, 1);
			
			// increment i
			i++;
		}
		
		// if this marks the end of the row
		else if (nextChar == rowEndChar) {
			// remove this character
			g = string_delete(g, 1, 1);
			
			// increment i
			i++;	
		}
		
		// if this is the beginning of a new column
		else if (nextChar == colStartChar) {
			// increment currentCol
			currentCol++;
			
			// check if the target grid can support this width
			if (ds_grid_width(_target) < currentCol + 1) {
				ds_grid_resize(_target, currentCol + 1, ds_grid_height(_target));
			}
			
			// initialize the new column
			_target[# currentCol, currentRow] = "";
			
			// remove this character
			g = string_delete(g, 1, 1);
			
			// increment i
			i++;
		}
		
		// if this marks the end of the column
		else if (nextChar == colEndChar) {
			// remove this character
			g = string_delete(g, 1, 1);
			
			// increment i
			i++;
		}
		
		// if this is the beginning of a nested grid
		else if (nextChar == gridStartChar) {
			// get the position of the next gridStartChar and the next gridEndChar
			nextGridStart	= string_pos(gridStartChar, g);
			nextGridEnd		= string_pos(gridEndChar, g);
			
			// check if nextGridStart comes before nextGridEnd (this indicates that there is another nested grid)
			if (nextGridStart < nextGridEnd) {
				while (nextGridStart < nextGridEnd) 
				&& (nextGridStart > 0) {
					// add everything up until the nextGridEnd to the current column and row position
					_target[# currentCol, currentRow] += string_copy(g, 0, nextGridEnd);
					
					// delete everything up until nextGridEnd from the encoded grid
					g = string_delete(g, 0, nextGridEnd);
					
					// increment i by the number of characters just added (nextGridEnd + 1)
					i += nextGridEnd;
					
					// get the position of the next gridStartChar and the next gridEndChar
					nextGridStart	= string_pos(gridStartChar, g);
					nextGridEnd		= string_pos(gridEndChar, g);
				}
			}
			// if nextGridStart comes AFTER nextGridEnd (this indicates that there are no other nested grids)
			else {
				// add everything up until the nextGridEnd to the current column and row position
				_target[# currentCol, currentRow] += string_copy(g, 0, nextGridEnd);
				
				// delete everything up until nextGridEnd from the encoded grid
				g = string_delete(g, 0, nextGridEnd);
				
				// increment i by the number of characters just added (nextGridEnd + 1)
				i += nextGridEnd;
			}
		}
		
		// if this is the end of the main grid
		else if (nextChar == gridEndChar) {
			// remove this character
			g = string_delete(g, 1, 1);
			
			i++;
		}
		
		// if this is not a nagivation character
		else {
			// add the character to the current column and row position
			_target[# currentCol, currentRow] += nextChar;
			
			// remove this character
			g = string_delete(g, 0, 1);
			
			// increment i
			i++;
		}
	}
}

///@desc This function takes an encoded map and turns it back into a ds_map
/// so that it's easier to access quickly
function decode_map(_map, _target) {
	var m = _map;	var t = _target;
	
	// establish tokenKeyChar and newItemChar
	var tokenKeyChar	= "@";
	var newItemChar		= "#";
	
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

///@desc This function takes a ds_grid that is two columns wide and pairs
/// the items from each row together in a ds_map
function convert_grid_to_map(_grid, _target) {
	var g = _grid;	var t = _target;
	
	var height = ds_grid_height(g);
	
	var i = 0;	repeat (height - 1) {
		var key		= g[# 0, i];
		var token	= g[# 1, i];
		
		ds_map_add(t, key, token);
		
		i++;
	}
	
	ds_grid_destroy(g);
}

///@desc This function resets a ds_list by deleting each item on the list. (NOTE:
/// I'm not sure why this function even exists, but I'm currently using it to reset
/// the NPC list, so until I rework that somehow or at least check in on it, this stays)
function ds_list_reset(_list) {
	var l = _list;
	
	var i = 0; repeat (ds_list_size(l)) {
		ds_list_delete(l, i);
		
		i++;
	}
}

///@desc This function can be used to add a value to the bottom of a list
function ds_list_push(_list, _val) {
	_size = ds_list_size(_list);
	_list[| _size] = _val;
}

///@desc This function takes the ids of three lists. It adds everything on the two lists to
/// the third list which is marked targetList.
function ds_list_append(_list1, _list2, _targetList) {
	var l1 = _list1;
	var l2 = _list2;
	var tl = _targetList;
	
	var i = 0;	repeat (ds_list_size(l1)) {
		// get next token
		var token = l1[| i];
		
		// add the token to the target list
		ds_list_add(tl, token);
		
		// incrment i
		i++;
	}
	
	var i = 0;	repeat (ds_list_size(l2)) {
		// get next token
		var token = l2[| i];
		
		// add the token to the target list
		ds_list_add(tl, token);
		
		// increment i
		i++;
	}
}

function ds_grid_remove_row(_grid, _row) {
	// store args in locals
	var r = _row;
	
	// get the height of the grid
	var h = ds_grid_height(_grid);
	
	// get the width of the grid
	var w = ds_grid_width(_grid);
	
	// get the number of rows from the given row to the end (subtract 1 for 0 index)
	var n = h - r - 1;

	// repeat for all rows that follow the given row
	var i = r;	repeat (n) {
		// repeat for all columns
		var j = 0;	repeat (w) {
			_grid[# j, i] = _grid[# j, i + 1];
			
			j++;
		}
		
		i++;
	}
	
	ds_grid_resize(_grid, w, h - 1);
}

function string_get_asset_ID(_assetString) {
	// store args in locals
	var as = _assetString;
	
	// find the position of the first space
	var firstPos = string_pos(" ", as);
	
	// find the next space
	var secondPos = string_pos_ext(" ", as, firstPos + 1);
	
	// clear string through second space
	as = string_delete(as, 0, secondPos);
	
	// return the asset id of the corrected string
	return asset_get_index(as);
}