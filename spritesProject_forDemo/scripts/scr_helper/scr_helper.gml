#macro	screenHeight		224
#macro	screenWidth			256

function execute(_fn) {
	_fn();
}

function draw_set(_halign, _valign, _alpha, _color) {
		draw_set_halign(_halign);
		draw_set_valign(_valign);
		draw_set_alpha(_alpha);
		draw_set_color(_color);
}

function ds_list_push(_list, _val) {
	_size = ds_list_size(_list);
	_list[| _size] = _val;
}

function clear_turn_selection(_allyNum) {
	ally = global.all_units[| _allyNum];
	ally.turn_selected = false;
	ally.selectedMove = noone;
	ally.selectedTarget = noone;
}

function sort_by_highest(_list) {	
	var listSize = ds_list_size(_list);
	
	for (var i = 0; i < listSize; i++) {
		for (var j = 0; j < listSize - i; j++) {			
			if (_list[| j] < _list[| j + 1]) {
				var temp = _list[| j];
				_list[| j] = _list[| j + 1];
				_list[| j + 1] = temp;
				
			}
		}
	}
}

function agility_sort(_grid) {
	var gridSize = ds_grid_height(_grid);
	
	for (var i = 0; i < gridSize - 1; i++) {
		for (var j = 0; j < gridSize - i - 1; j++) {
			var spriteNum1	=	ds_grid_get(_grid, 0, j);
			var spriteNum2	=	ds_grid_get(_grid, 0, j + 1);
			
			if (spriteNum2 >= 0) {
				var sprite1 = global.all_units[| spriteNum1];
				var sprite2 = global.all_units[| spriteNum2];
				
				var agility1 = sprite1.agility;
				var agility2 = sprite2.agility;
				
				if (agility1 < agility2) {
					for (var k = 0; k < ds_grid_width(_grid); k++) {
						var temp	= ds_grid_get(_grid, k, j);
						var ttemp	= ds_grid_get(_grid, k, j + 1);
						
						ds_grid_set(_grid, k, j, ttemp);
						ds_grid_set(_grid, k, j + 1, temp);
					}
				}
				
				if (agility1 == agility2) {
					if (global.fasterPlayer == sprite2.team) and (global.fasterPlayer != sprite1.team) {
						for (var k = 0; k < ds_grid_width(_grid); k++) {
							var temp	= ds_grid_get(_grid, k, j);
							var ttemp	= ds_grid_get(_grid, k, j + 1);
							
							ds_grid_set(_grid, k, j, ttemp);
							ds_grid_set(_grid, k, j + 1, temp);
						}
					}
				}
			}
		}
	}
}

function randomize_list(_list){
	randomize();
	for(var i = 0; i < ds_list_size(_list); i++){
		var int = irandom_range(0,ds_list_size(_list)-1);
		var inst = _list[|int];
		_list[|int] = _list[|0];
		_list[|0] = inst;
	}
}

function ds_list_append(_target, _source){
	for (var i = 0; i < ds_list_size(_source); i++) {
		ds_list_add(_target, ds_list_find_value(_source, i));
	}
}

function create_once(_x, _y, _layer, _obj) {
	if !(instance_exists(_obj)) {
		instance_create_depth(_x, _y, get_layer_depth(_layer), _obj)
	}
}

function destroy_if_possible(_obj) {
	if (object_exists(_obj)) {
		instance_destroy(_obj);
	}
}

function correct_target_number(_var) {
	if (_var > 7) {
		_var -= 8;	
	}
	
	return _var;
}

function calculate_spell_damage(_user, _target, _spellType, _weakType, _strongType, _power) {
	
	var userStat			= _user.elemental_stats[| _spellType];
	var targetStat			= _target.elemental_stats[| _spellType];
	var targetStrongStat	= _target.elemental_stats[| _strongType];
	var targetWeakStat		= _target.elemental_stats[| _weakType];
	
	var ratio1	= userStat / targetStat;
	var ratio2	= targetWeakStat / targetStrongStat;
	
	damage	= ratio1 * ratio2 * _power;
	
	return damage;
}

function replenish_mp(_team, _amount) {
	team		= _team;
	regenAmount	= _amount;
	
	mpNeeded	= team.maxMP - team.currentMP;
	if (mpNeeded < regenAmount) {regenAmount = mpNeeded;}
	
	team.currentMP += round(regenAmount);
}

function replenish_hp(_team, _amount) {
	team		= _team;
	regenAmount	= _amount;
	
	hpNeeded	= team.maxHP - team.currentHP;
	if (hpNeeded < regenAmount) {regenAmount = hpNeeded;}
	
	team.currentHP += round(regenAmount);
}

function deplete_hp(_team, _amount) {
	team	= _team;
	amount	= _amount;
	
	hpLeft		= team.currentHP;
	if (hpLeft < amount) {amount = hpLeft;}
	
	team.currentHP -= round(amount);
}

function initialize_sprite_states() {
	for (var i = 0; i < ds_list_size(global.all_units); i++) {
		global.all_units[| i].state = spriteStates.idle;
	}
}

function set_sprites_hidden(_bool) {
	for (var i = 0; i < ds_list_size(global.all_units); i++) {
		global.all_units[| i].hidden = _bool;	
	}
}

function draw_neat_text(_x, _y, _string, _halign, _valign, _color, _width, _scale, _alpha, _angle) {
	var str = format_text(_string, _width);
	draw_set_font(fnt_basic);
	
	if (_color != c_white) {
		draw_set(_halign, _valign, _alpha, c_white);
	}	else {
		draw_set(_halign, _valign, _alpha, c_black);
	}
	
	draw_text_transformed(_x, _y, str, _scale, _scale, _angle);
	
	draw_set(_halign, _valign, _alpha, _color);
	draw_text_transformed(_x - _scale, _y - _scale, str, _scale, _scale, _angle);
}

// this function scans a given string for a given character. It returns 1 if the string contains the character, 0 if not.
function string_scan(_string, _char) {
	// initialize the boolean return variable as false
	var present = false;
	
	// get stringSize
	var stringSize = string_length(_string);
	
	// initialize i
	var i = 0;
	
	// repeat the following code for every character in the string
	repeat (stringSize) {
		
		// check if the character at index i in the given string matches the given character
		if (string_char_at(_string, i) == _char) {present = true;}	// if so, set the return variable to true
	
		// increment i
		i++;
	}

	return present;
}

// this function takes an encoded list, as well as x and y values. It draws the list to the screen, centered about the given x and y.
function draw_encoded_list(_list, _x, _y) {
	// check for structs
	var hasStructs = string_scan(_list, ";");
	
	// set parse character
	if (hasStructs) {var parseChar = ";";}
	else	{var parseChar = ",";}
	
	// copy the list to a blank substring
	var substring = _list;
	
	// reformat the substring by adding spaces
	var i = 0;
	repeat (string_length(substring)) {
		// if the character at i is a parse character, add a newline directly after it.
		if (string_char_at(substring, i) == parseChar) {
			substring = string_insert("\n", substring, i + 1);
		}
		
		// increment i
		i++;
	}
	// draw the string
	draw_text(_x, _y, substring);
}

// this function takes an encoded grid, as well as x and y values, and width and height values for cell size. 
// It draws the grid to the screen, centered about the given x and y, with each cell sized with the given dimensions.
function draw_encoded_grid(_grid, _x, _y, _width, _height) {

	var newRowChar		= "|";
	var newColumnChar	= "_";
	
	// create a substring
	var substring = _grid;
	
	// copy each column to a substring
	var i = 0;
	repeat (string_length(substring)) {
		// if the character at i is a secondary parse character, add a number of spaces to match the height argument
		if (string_char_at(substring, i) == newRowChar) {
			repeat(_height) {
				var temp = string_insert("\n", substring, i + 1);
				substring = temp;
			}
		}
		
		if (string_char_at(substring, i) == newColumnChar) {
			repeat(_width) {
				var temp = string_insert("	", substring, i + 1);
				substring = temp;
			}
		}
		
		// increment i
		i++;
	}
	
	// draw the substring
	draw_text(_x, _y, substring);
}

// this function takes a ds_list, as well as x and y values, and a height value for cell size.
// It draws the list to the screen, centered about the given x and y.
function draw_ds_list(_list, _x, _y, _height) {
	// get listSize
	var listSize = ds_list_size(_list);
	
	// initialize i and repeat for all list tokens
	var i = 0;
	repeat (listSize) {
		// get drawY depending on i, as well as the given _y and _height arguments
		var drawY = _y + ((i - listSize / 2) * (_height / listSize));
		
		// draw the token at i
		draw_text(_x, drawY, string(_list[|i]));
		
		// increment i
		i++;
	}
}

// this function takes a ds_grid, as well as x and y values, and width and height values for cell size.
// It draws the ds_grid to the screen, centered about the given x and y, with each cell sized with the given dimensions.
function draw_ds_grid(_grid, _x, _y, _width, _height) {
	// get grid width and height
	var gridWidth = ds_grid_width(_grid);
	var gridHeight = ds_grid_height(_grid);
	
	// initialize i and repeat for all columns
	var i = 0;
	repeat (gridWidth) {
		// initialize ii and repeat for all rows
		var ii = 0;
		repeat (gridHeight) {
			// get drawX depending on i, as well as the given _x and _width arguments
			var drawX = _x + ((i - gridWidth / 2) * (_width / gridWidth));
			
			// get drawY depending on ii, as well as the given _y and _height arguments
			var drawY = _y + ((ii - gridHeight / 2) * (_height / gridHeight));
			
			// draw the token at (i, ii)
			draw_text(drawX, drawY, _grid[# i, ii]);
			
			// increment ii
			ii++;
		}
		// increment i
		i++;
	}
}

global.frame =	0;
global.gameTime = 0;
#macro	FRAMERATE	16
#macro	MAXFRAME	8

function set_frame() {
	
	if (global.gameTime mod FRAMERATE == 0) {
		global.frame++;
	}
	
	if (global.frame > MAXFRAME) {
		global.frame -= MAXFRAME;	
	}
}
	
function game_timer() {
	global.gameTime++;
	
	if (global.gameTime >= 1600) {
		global.gameTime -= 1600;	
	}
}

function new_game() {
	create_once(0,	0, LAYER.sprites, player);
	player.location = locations.miriabramExt;
	
	room_transition(256, 160, directions.south, rm_overworld);
}

function ds_list_reset(_list) {
	var l = _list;
	
	var i = 0; repeat (ds_list_size(l)) {
		ds_list_delete(l, i);
		
		i++;
	}
}