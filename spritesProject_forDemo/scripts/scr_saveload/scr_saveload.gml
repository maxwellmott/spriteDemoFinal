///@desc This function is called when the player is beginning a new game. Right now it's
/// in a very mutative state, because I keep needing this to put you in different rooms
/// depending on what I'm testing as a way of getting to the problem first while maintaining
/// the game-start flow. In the playtest build, this function is called playtest_begin() and
/// works mostly the same
function start_new_game() {
	create_once(0,	0, LAYER.sprites, player);
	player.location = locations.miriabramExt;
	
	build_npc_location_list(npcLocationList);
	edit_npc_location_lists(npcLocationList);
	
	ds_list_destroy(npcLocationList);
	
	room_transition(128, 160, directions.south, rm_overworld, bgm_springRelaxSunny);
}

///@desc This function stores a given string of data in a buffer and then saves that buffer
/// to the given file
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

///@desc This function loads a JSON-encoded ds_map from the given file and
/// returns that data in string form
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

///@desc This function is called when the player wants to save their progress. The
/// function replaces the sprites save file with a new file containing a map of all
/// the values that need to be saved as well as their respective names.
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
		ds_map_add(_map, "location",			string(location));
		ds_map_add(_map, "x",					x)	
		ds_map_add(_map, "y",					y);
		ds_map_add(_map, "unlockedDoors",		unlockedDoors);
		ds_map_add(_map, "appearance",			appearance);
		ds_map_add(_map, "team",				teamString);
		ds_map_add(_map, "talismans",			talismanString);
		ds_map_add(_map, "wardrobe",			wardrobeString);
		ds_map_add(_map, "spells",				knownSpellString);
		ds_map_add(_map, "spellBook",			spellBookString);
		ds_map_add(_map, "contacts",			contactString);
		ds_map_add(_map, "roninScore",			string(roninScore));
		ds_map_add(_map, "roninMatchCount",		string(roninMatchCount));
		ds_map_add(_map, "onlineRating",		string(onlineRating));
		ds_map_add(_map, "onlineMatchCount",	string(onlineMatchCount));
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

///@desc This function is called when the player wants to continue from a saved file.
/// The function loads the map stored in the sprites save file and uses it to build the
/// game.
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
				location			= real(_map[? "location"]);
				x					= real(_map[? "x"]);
				y					= real(_map[? "y"]);
				unlockedDoors		= _map[? "unlockedDoors"];
				appearance			= _map[? "appearance"];
				teamString			= _map[? "team"];
				talismanString		= _map[? "talismans"];
				wardrobeString		= _map[? "wardrobe"];
				knownSpellString	= _map[? "spells"];
				spellBookString		= _map[? "spellBook"];
				contactString		= _map[? "contacts"];
				roninScore			= real(_map[? "roninScore"]);
				roninMatchCount		= real(_map[? "roninMatchCount"]);
				onlineRating		= real(_map[? "onlineRating"]);
				onlineMatchCount	= real(_map[? "onlineMatchCount"]);
			}
		}
	}
}