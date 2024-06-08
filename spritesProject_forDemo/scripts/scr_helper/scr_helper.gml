// this global variable stores a number representing the current frame. The count resets at 16000
global.gameTime = 0;
	
// this global variable keeps a ds list of any arguments that might need to be passed between objects or events
global.argumentList = ds_list_create();
	
///@desc This function is keeping track of the global.gameTime variable
function game_timer() {
	// increment global.gameTime
	global.gameTime++;
	
	// if global.gameTime passes the hard-limit (16000), reset the count
	if (global.gameTime >= 16000) {
		global.gameTime -= 16000;
	}
}

///@desc This is a helper function that sets values for drawing text
function draw_set(_halign, _valign, _alpha, _color) {
		draw_set_halign(_halign);
		draw_set_valign(_valign);
		draw_set_alpha(_alpha);
		draw_set_color(_color);
}

///@desc This function can be used to randomly reorder the items on a ds_list
function randomize_list(_list){
	randomize();
	for(var i = 0; i < ds_list_size(_list); i++){
		var int = irandom_range(0,ds_list_size(_list)-1);
		var inst = _list[|int];
		_list[|int] = _list[|0];
		_list[|0] = inst;
	}
}

///@desc This is a helper function that ensures to create only one of a new instance
function create_once(_x, _y, _layer, _obj) {
	if !(instance_exists(_obj)) {
		instance_create_depth(_x, _y, get_layer_depth(_layer), _obj)
	}
}

///@desc This is a helper function that destroys an instance after ensuring that it exists
function destroy_if_possible(_obj) {
	if (object_exists(_obj)) {
		instance_destroy(_obj);
	}
}