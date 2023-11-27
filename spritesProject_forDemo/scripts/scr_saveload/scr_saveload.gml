function save_string_to_file(_filename, _string) {	
	// creates a buffer the size of the string
	var _buffer = buffer_create(string_byte_length(_string) + 1, buffer_fixed, 1);
	
	// writes the string to the buffer
	buffer_write(_buffer, buffer_string, _string);
	
	// saves the buffer in the destination file
	buffer_save(_buffer, _filename);
	
	// deletes the buffer
	buffer_delete(_buffer);
}

function load_JSON_from_file(_filename) {
	// load the JSON file
	var _buffer = buffer_load(_filename);
	
	// read the file to a string
	var _string = buffer_read(_buffer, buffer_string);
	
	// delete the buffer
	buffer_delete(_buffer);
	
	// decode the string
	var _json = json_decode(_string);
	
	// return the decoded string
	return _json;
}

function save_game() {
	//Create a root list
	var _root_list = ds_list_create();

	with (player) {
		// create an empty ds_map within which to store all of the info
		var _map = ds_map_create();
		
		// add the root_list to the empty ds_map
		ds_list_add(_root_list, _map);
		
		// turn the root_list into a ds_map
		ds_list_mark_as_map(_root_list, ds_list_size(_root_list) - 1);
	
		// add all of the player's parameters to the ds_map
		ds_map_add(_map, "name",				name);
		ds_map_add(_map, "x",					x)	
		ds_map_add(_map, "y",					y);
		ds_map_add(_map, "appearance",			appearance);
		ds_map_add(_map, "team",				team);
		ds_map_add(_map, "talismans",			talismans);
		ds_map_add(_map, "inventory",			inventory);
		ds_map_add(_map, "wardrobe",			wardrobe);
		ds_map_add(_map, "SPELLS",				SPELLS);
		ds_map_add(_map, "potions",				potions);
		ds_map_add(_map, "contacts",			contacts);
		ds_map_add(_map, "roninScore",			roninScore);
		ds_map_add(_map, "roninMatchCount",		roninMatchCount);
		ds_map_add(_map, "onlineRating",		onlineRating);
		ds_map_add(_map, "onlineMatchCount",	onlineMatchCount);
	}
	
	// Wrap all of that in one ds_map
	var _wrapper = ds_map_create();
	ds_map_add_list(_wrapper, "ROOT", _root_list);
	
	// Save all of that to a string
	var _outload = json_encode(_wrapper);
	save_string_to_file("sprites.save", _outload);
	
	// Destroy the data
	ds_map_destroy(_wrapper);
}

function load_game() {
	
	instance_destroy(player);
	
	if (file_exists("sprites.save")) {
		var _wrapper = load_JSON_from_file("sprites.save");
		var _list = _wrapper[? "ROOT"];
		
		for (var i = 0; i < ds_list_size(_list); i++) {
			var _map = _list[| i];

			create_once(x, y, LAYER.sprites, player);
			with (player) {
				name				= _map[? "name"];
				x					= _map[? "x"];
				y					= _map[? "y"];
				appearance			= _map[? "appearance"];
				team				= _map[? "team"];
				talismans			= _map[? "talismans"];
				inventory			= _map[? "inventory"];
				wardrobe			= _map[? "wardrobe"];
				SPELLS				= _map[? "SPELLS"];
				potions				= _map[? "potions"];
				contacts			= _map[? "contacts"];
				roninScore			= _map[? "roninScore"];
				roninMatchCount		= _map[? "roninMatchCount"];
				onlineRating		= _map[? "onlineRating"];
				onlineMatchCount	= _map[? "onlineMatchCount"];
			}
		}
	}
}