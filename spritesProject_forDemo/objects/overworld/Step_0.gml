/// @desc

// if there are no menus open and the alert stack is not empty, create an alert
if !(instance_exists(menu)) {
	if (ds_list_size(alertStack) > 0) {
		if !(instance_exists(overworldAlert)) instance_create_depth(0, 0, get_layer_depth(LAYER.uiFront), overworldAlert);
	}
}

// ensure that transition is not happening
if !(instance_exists(transitionManager)) {
	// get the number of unlockAlerts present
	var uan = instance_number(unlockAlert);
	
	// get the size of the unlockAlertsList
	var uals = ds_list_size(player.unlockAlertList);
	
	// check if uan is less than the size of the unlockAlertList
	if (uan < uals) {
		// create a new unlockAlert
		instance_create_depth(x, y, get_layer_depth(LAYER.ui), unlockAlert);
	}
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

// check if there are any menus open
if !(instance_exists(menu)) 
|| (instance_exists(talkBubble)) {
	// destroy mouse if present
	destroy_if_possible(mouse);
	
	// check if there are activeEmotes
	if (ds_grid_height(activeEmotes) > 0) {
		// use a repeat loop to create all active emotes
		var i = 0;	repeat (ds_grid_height(activeEmotes)) {
			var inst = create_once(0, 0, LAYER.meta, owEmote);
				i++;
		}
	}
}