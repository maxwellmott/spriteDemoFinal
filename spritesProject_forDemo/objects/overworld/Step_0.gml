/// @desc

// if there are no menus open and the alert stack is not empty, create an alert
if (global.overworld) && (ds_list_size(alertStack) > 0) {
	if !(instance_exists(overworldAlert)) instance_create_depth(0, 0, get_layer_depth(LAYER.uiFront), overworldAlert);
}

if global.roomBuilt gate_check_player();

if !(global.roomBuilt) {
	if spritesCreated
	&& sceneryCreated {
		global.roomBuilt = true;	
	}
}

if (player.sundown) && !(lightsOn) {
	with (lamppost) {frame = 1;}
}

if !(player.sundown) && (lightsOn) {
	with (lamppost) {frame = 0;}
}