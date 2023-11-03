enum overworldAlerts {
	swimStart,
	swimStop,
	doorLocked,
	doorUnlocked,
	keypadStart,
	keypadFailure,
	keypadSuccess,
	noRoom,
	height
}

enum overworldAlertParams {
	ID,
	text,
	ynPrompt,
	func,
	height
}

var textGrid = load_csv("overworldAlerts_english.csv");

global.overworldAlertsGrid = ds_grid_create(overworldAlertParams.height, overworldAlerts.height);

function master_grid_add_overworld_alert(_id, _text, _ynPrompt, _function) {
	var i = 0; repeat (overworldAlertParams.height) {
		global.overworldAlertsGrid[# i, _id] = argument[i];
		
		i++;
	}
}

function start_swimming() {
	switch (player.facing) {
		case directions.east:	var xx = player.x + 32;	var yy = player.y;	break;
		case directions.south:	var yy = player.y + 32;	var xx = player.x;	break;
		case directions.west:	var xx = player.x - 32;	var yy = player.y;	break;
		case directions.north:	var yy = player.y - 32;	var xx = player.x;	break;
	}
	
	if (check_water_get_in(xx, yy)) {
		player.x = xx;
		player.y = yy;
		player.swimming = true;
	}	else	{
		ds_list_push(overworld.alertStack, overworldAlerts.noRoom);
	}
}

function stop_swimming() {	
	switch (player.facing) {
		case directions.east:	var xx = player.x + 32;	var yy = player.y;	break;
		case directions.south:	var yy = player.y + 32;	var xx = player.x;	break;
		case directions.west:	var xx = player.x - 32;	var yy = player.y;	break;
		case directions.north:	var yy = player.y - 32;	var xx = player.x;	break;
	}
	
	if (check_water_get_out(xx, yy)) {
		player.x = xx;
		player.y = yy;
		player.swimming = false;
	}	else	{
		ds_list_push(overworld.alertStack, overworldAlerts.noRoom);
	}
}

function start_keypad() {
	instance_create_depth(player.x, player.y, get_layer_depth(LAYER.uiFront), keypad);
}

master_grid_add_overworld_alert(overworldAlerts.swimStart,		textGrid[# 1, overworldAlerts.swimStart],		true,	start_swimming);
master_grid_add_overworld_alert(overworldAlerts.swimStop,		textGrid[# 1, overworldAlerts.swimStop],		true,	stop_swimming);
master_grid_add_overworld_alert(overworldAlerts.doorLocked,		textGrid[# 1, overworldAlerts.doorLocked],		false,	noone);
master_grid_add_overworld_alert(overworldAlerts.doorUnlocked,	textGrid[# 1, overworldAlerts.doorUnlocked],	false,	noone);
master_grid_add_overworld_alert(overworldAlerts.keypadStart,	textGrid[# 1, overworldAlerts.keypadStart],		true,	start_keypad);
master_grid_add_overworld_alert(overworldAlerts.keypadFailure,	textGrid[# 1, overworldAlerts.keypadFailure],	false,	noone);
master_grid_add_overworld_alert(overworldAlerts.keypadSuccess,	textGrid[# 1, overworldAlerts.keypadSuccess],	false,	noone);
master_grid_add_overworld_alert(overworldAlerts.noRoom,			textGrid[# 1, overworldAlerts.noRoom],			false,	noone);

global.allOverworldAlerts = encode_grid(global.overworldAlertsGrid);

ds_grid_destroy(global.overworldAlertsGrid);
ds_grid_destroy(textGrid);